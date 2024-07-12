// Income

const pool = require("../../../db");
const queries = require("../queries");


const getIncome = async (req, res) => {
    try {
      const result = await pool.query(queries.getIncome);
      res.status(200).json(result.rows);
    } catch (err) {
      console.error("Error fetching income:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };
  
  const getIncomeById = async (req, res) => {
    const userId = req.params.id;
    try {
      console.log(`Fetching income for userId: ${userId}`);
      const result = await pool.query(queries.getIncomeByUserId, [userId]);
      res.status(200).json(result.rows);
    } catch (err) {
      console.log(`Error fetching income:`, err);
      res.status(500).json({ error: `Internal Server Error` });
    }
  };
  
  const createIncome = async (req, res) => {
    const { categoryid, amount, description, date } = req.body;
    try {
      const result = await pool.query(queries.createIncome, [
        req.user.id,
        categoryid,
        amount,
        description,
        date,
      ]);
      res.status(201).json(result.rows[0]);
    } catch (err) {
      console.error("Error creating income:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };
  
  const updateIncome = async (req, res) => {
    const { categoryid, amount, description, date } = req.body;
    const { id } = req.params;
    try {
      const result = await pool.query(queries.updateIncome, [
        categoryid,
        amount,
        description,
        date,
        id,
        req.user.id,
      ]);
      res.status(200).json(result.rows[0]);
    } catch (err) {
      console.error("Error updating income:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };
  
  const deleteIncome = async (req, res) => {
    const { user_id } = req.body;
    const { id } = req.params;
    try {
      const result = await pool.query(queries.deleteIncome, [user_id, id]);
      res.status(200).json(result.rows[0]);
    } catch (err) {
      console.error("Error deleting income:", err);
      res.status(500).json({ error: "Internal server error" });
    }
  };

  module.exports = {
    getIncome,
    getIncomeById,
    createIncome,
    updateIncome,
    deleteIncome
  }