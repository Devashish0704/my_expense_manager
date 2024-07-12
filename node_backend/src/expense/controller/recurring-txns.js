const pool = require("../../../db");
const queries = require("../queries");

const getRecurringTxns = async (req, res) => {
    try {
        const result = await pool.query(queries.getRecurringTxns);
        res.status(200).json(result.rows);
    } catch (err) {
        console.error("Error fetching recurring transactions:", err);
        res.status(500).json({ error: "Internal server error" });
    }
};

const getRecurringTxnById = async (req, res) => {
    const  user_id  = req.params.id;
    try {
        console.log(`Fetching recurrence_txns for userId: ${user_id}`);
        const result = await pool.query(queries.getRecurringTxnById, [user_id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Recurring transaction not found' });
        }
        res.status(200).json(result.rows);
    } catch (err) {
        console.error("Error fetching recurring transaction:", err);
        res.status(500).json({ error: "Internal server error" });
    }
};

const createRecurringTxn = async (req, res) => {
    const {id, amount, start_date, frequency, category_id, description, remaining_payments, max_payments, type, payment_name } = req.body;
    try {
        const result = await pool.query(queries.createRecurringTxn, [
            id, amount, start_date, frequency, category_id, description, remaining_payments, max_payments, type, payment_name
        ]);
        res.status(201).json(result.rows[0]);
    } catch (err) {
        console.error("Error creating recurring transaction:", err);
        res.status(500).json({ error: "Internal server error" });
    }
};

const updateRecurringTxn = async (req, res) => {
    const { id } = req.params;
    const { amount, start_date, frequency, category_id, description, remaining_payments, max_payments, type } = req.body;
    try {
        const result = await pool.query(queries.updateRecurringTxn, [
            id, amount, start_date, frequency, category_id, description, remaining_payments, max_payments, type, req.user.id
        ]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Recurring transaction not found' });
        }
        res.status(200).json(result.rows[0]);
    } catch (err) {
        console.error("Error updating recurring transaction:", err);
        res.status(500).json({ error: "Internal server error" });
    }
};

const deleteRecurringTxn = async (req, res) => {
    const { id } = req.params;
    try {
        const result = await pool.query(queries.deleteRecurringTxn, [id, req.user.id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Recurring transaction not found' });
        }
        res.status(200).json({ message: 'Recurring transaction deleted successfully', deleted: result.rows[0] });
    } catch (err) {
        console.error("Error deleting recurring transaction:", err);
        res.status(500).json({ error: "Internal server error" });
    }
};

module.exports = {
    getRecurringTxns,
    getRecurringTxnById,
    createRecurringTxn,
    updateRecurringTxn,
    deleteRecurringTxn
};


