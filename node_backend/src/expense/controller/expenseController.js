// src/expense/controller.js

const pool = require("../../../db");
const queries = require("../queries");

// Expenses

const getExpenses = async (req, res) => {
  try {
    const result = await pool.query(queries.getExpenses);
    res.status(200).json(result.rows);
  } catch (err) {
    console.error("Error fetching expenses:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

const getExpensesById = async (req, res) => {
  const userId = req.params.id;
  try {
    console.log(`Fetching expenses for userId: ${userId}`);
    const result = await pool.query(queries.getExpensesByUserId, [userId]);
    res.status(200).json(result.rows);
  } catch (err) {
    console.error("Error fetching expenses:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

const createExpense = async (req, res) => {
  const { category_id, amount, description, date } = req.body;
  try {
    const result = await pool.query(queries.createExpense, [
      req.user.id,
      category_id,
      amount,
      description,
      date,
    ]);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error creating expense:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

const updateExpense = async (req, res) => {
  const { category_id, amount, description, date } = req.body;
  const { id } = req.params;
  try {
    const result = await pool.query(queries.updateExpense, [
      category_id,
      amount,
      description,
      date,
      id,
      req.user.id,
    ]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error("Error updating expense:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

const deleteExpense = async (req, res) => {
  const { expense_id } = req.body;
  const { id } = req.params;
  try {
    const result = await pool.query(queries.deleteExpense, [expense_id, id]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error("Error deleting expense:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};


// Users
const getUsers = async (req, res) => {
  try {
    const result = await pool.query(queries.getUsers);
    res.status(200).json(result.rows);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const getUserById = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const result = await pool.query(queries.getUserById, [id]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const createUser = async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const result = await pool.query(queries.createUser, [
      name,
      email,
      password,
    ]);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error creating user:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

const updateUser = async (req, res) => {
  const id = parseInt(req.params.id);
  const { name, email, password } = req.body;
  try {
    const result = await pool.query(queries.updateUser, [
      name,
      email,
      password,
      id,
    ]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const deleteUser = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const result = await pool.query(queries.deleteUser, [id]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    console.error("Error creating user:", err);

    res.status(500).json({ error: "Internal server error" });
  }
};





// Payments
const getPayments = async (req, res) => {
  try {
    const result = await pool.query(queries.getPayments);
    res.status(200).json(result.rows);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const getPaymentById = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const result = await pool.query(queries.getPaymentById, [id]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const createPayment = async (req, res) => {
  const { user_id, amount, date, description } = req.body;
  try {
    const result = await pool.query(queries.createPayment, [
      user_id,
      amount,
      date,
      description,
    ]);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const updatePayment = async (req, res) => {
  const id = parseInt(req.params.id);
  const { user_id, amount, date, description } = req.body;
  try {
    const result = await pool.query(queries.updatePayment, [
      user_id,
      amount,
      date,
      description,
      id,
    ]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const deletePayment = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const result = await pool.query(queries.deletePayment, [id]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

module.exports = {
  getExpenses,
  getExpensesById,
  createExpense,
  updateExpense,
  deleteExpense,
 
  getUsers,
  getUserById,
  createUser,
  updateUser,
  deleteUser,
  
  
  getPayments,
  getPaymentById,
  createPayment,
  updatePayment,
  deletePayment,
};

// ALTER TABLE expenses ADD COLUMN is_recurring BOOLEAN DEFAULT false;
// ALTER TABLE expenses ADD COLUMN recurrence_interval VARCHAR(20); -- e.g., 'daily', 'weekly', 'monthly'

// ALTER TABLE income ADD COLUMN is_recurring BOOLEAN DEFAULT false;
// ALTER TABLE income ADD COLUMN recurrence_interval VARCHAR(20); -- e.g., 'daily', 'weekly', 'monthly'

// const pool = require('../../../db');
// const cron = require('node-cron');

// // Function to process recurring transactions
// const processRecurringTransactions = async () => {
//   try {
//     // Fetch all recurring expenses
//     const { rows: recurringExpenses } = await pool.query(`
//       SELECT * FROM expenses
//       WHERE is_recurring = true
//     `);

//     // Fetch all recurring income
//     const { rows: recurringIncome } = await pool.query(`
//       SELECT * FROM income
//       WHERE is_recurring = true
//     `);

//     // Process each recurring expense
//     for (const expense of recurringExpenses) {
//       await handleRecurringTransaction(expense, 'expense');
//     }

//     // Process each recurring income
//     for (const income of recurringIncome) {
//       await handleRecurringTransaction(income, 'income');
//     }
//   } catch (error) {
//     console.error('Error processing recurring transactions:', error);
//   }
// };

// // Function to handle a single recurring transaction
// const handleRecurringTransaction = async (transaction, type) => {
//   const { id, user_id, amount, date, category_id, description, recurrence_interval } = transaction;

//   // Determine the next occurrence date based on the recurrence interval
//   const nextOccurrenceDate = getNextOccurrenceDate(date, recurrence_interval);

//   // Insert the next occurrence of the transaction
//   const insertQuery = type === 'expense' ? `
//     INSERT INTO expenses (user_id, amount, date, category_id, description, is_recurring, recurrence_interval)
//     VALUES ($1, $2, $3, $4, $5, $6, $7)
//   ` : `
//     INSERT INTO income (user_id, amount, date, category_id, description, is_recurring, recurrence_interval)
//     VALUES ($1, $2, $3, $4, $5, $6, $7)
//   `;

//   await pool.query(insertQuery, [user_id, amount, nextOccurrenceDate, category_id, description, true, recurrence_interval]);
// };

// // Function to calculate the next occurrence date
// const getNextOccurrenceDate = (currentDate, interval) => {
//   const date = new Date(currentDate);

//   switch (interval) {
//     case 'daily':
//       date.setDate(date.getDate() + 1);
//       break;
//     case 'weekly':
//       date.setDate(date.getDate() + 7);
//       break;
//     case 'monthly':
//       date.setMonth(date.getMonth() + 1);
//       break;
//     default:
//       throw new Error('Invalid recurrence interval');
//   }

//   return date.toISOString().split('T')[0]; // Format as YYYY-MM-DD
// };

// // Schedule the processing of recurring transactions
// cron.schedule('0 0 * * *', () => {
//   console.log('Processing recurring transactions...');
//   processRecurringTransactions();
// });

// module.exports = {
//   processRecurringTransactions,
// };
