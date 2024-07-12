const { calculateNextDueDate } = require('../utils/dateUtils');
const pool = require('../../db');

async function processRecurringTransactions() {
    try {
        const today = new Date();

        const result = await pool.query(`
            SELECT * FROM recurring_txns
            WHERE start_date <= $1
            AND (remaining_payments > 0 OR max_payments IS NULL)
        `, [today]);

        const transactions = result.rows;

        for (const transaction of transactions) {
            const { id, user_id, amount, category_id, description, start_date, frequency, remaining_payments, max_payments, type } = transaction;

            // Perform transaction processing logic here
            // For example, send payment, update database, etc.
            // This is where you can integrate adding expenses/income to the respective tables

            // Calculate next due date
            const nextDueDate = calculateNextDueDate(new Date(start_date), frequency);

            // Insert income or expense based on type
            if (type === 'income') {
                await pool.query(`
                    INSERT INTO income (user_id, amount, date, category_id, description)
                    VALUES ($1, $2, $3, $4, $5)
                `, [user_id, amount, today, category_id, description]);
            } else if (type === 'expense') {
                await pool.query(`
                    INSERT INTO expenses (user_id, amount, date, category_id, description)
                    VALUES ($1, $2, $3, $4, $5)
                `, [user_id, amount, today, category_id, description]);
            }

            // Update start_date and remaining_payments for recurring_txns
            if (max_payments !== null && remaining_payments > 0) {
                const updatedRemainingPayments = remaining_payments - 1;
                if (updatedRemainingPayments === 0) {
                    // If remaining_payments reaches 0, stop processing this transaction
                    await pool.query(`
                        UPDATE recurring_txns
                        SET remaining_payments = $1
                        WHERE id = $2
                    `, [updatedRemainingPayments, id]);
                } else {
                    await pool.query(`
                        UPDATE recurring_txns
                        SET start_date = $1, remaining_payments = $2
                        WHERE id = $3
                    `, [nextDueDate, updatedRemainingPayments, id]);
                }
            } else {
                await pool.query(`
                    UPDATE recurring_txns
                    SET start_date = $1
                    WHERE id = $2
                `, [nextDueDate, id]);
            }
        }
    } catch (error) {
        console.error('Error processing recurring transactions:', error);
        throw error; 
    }
}

module.exports = { processRecurringTransactions };
