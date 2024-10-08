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
