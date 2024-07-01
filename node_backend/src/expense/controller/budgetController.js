const pool = require("../../../db");
const queries = require("../queries");

//Budgets

const getBudgets = async (req, res) => {
  try {
    const result = await pool.query(queries.getBudgets);
    res.status(200).json(result.rows);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const getBudgetById = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const result = await pool.query(queries.getBudgetById, [id]);
    res.status(200).json(result.rows);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const createBudget = async (req, res) => {
  const { user_id, category_id, amount, start_date, end_date } = req.body;
  try {
    // Insert budget into the database
    const result = await pool.query(queries.createBudget, [
      user_id,
      category_id,
      amount,
      start_date,
      end_date,
    ]);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error("Error creating budget:", err);
    res.status(500).json({ error: "Internal server error" });
  }
};

const updateBudget = async (req, res) => {
    const { category_id, amount, start_date, end_date } = req.body;
    const { id } = req.params;
    try {
      const result = await pool.query(queries.deleteBudget, [category_id, amount, start_date, end_date, id, req.user.id]);
      res.status(200).json(result.rows[0]);
    } catch (err) {
      console.error('Error updating budget:', err);
      res.status(500).json({ error: 'Internal server error' });
    }
  };
  

const deleteBudget = async (req, res) => {
  const id = parseInt(req.params.id);
  try {
    const result = await pool.query(queries.deleteBudget, [id]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};


// Function to check budgets
const checkBudgets = async (req, res) => {
  const userId = req.params.userId;
  try {
    // Fetch all budgets for the given user ID
    const budgets = await pool.query('SELECT * FROM budget WHERE user_id = $1', [userId]);
    
    // Check each budget
    const budgetStatuses = await Promise.all(budgets.rows.map(checkBudget));
    
    // Respond with the statuses
    res.status(200).json(budgetStatuses);
  } catch (err) {
    console.error('Error checking budgets:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// Helper function to check a single budget
const checkBudget = async (budget) => {
    const { user_id, category_id, amount, start_date, end_date } = budget;
    try {
    const result = await pool.query(
      'SELECT SUM(amount) AS total_expenses FROM expenses WHERE user_id = $1 AND category_id = $2 AND date BETWEEN $3 AND $4',
      [user_id, category_id, start_date, end_date]
    );
  
      const totalExpenses = result.rows[0].total_expenses || 0;
  
      console.log(`Total Expenses for Budget ID ${budget.id}: ${totalExpenses}`);
  
      // Determine the status
      let status = 'within';
      if (totalExpenses > amount) {
        status = 'exceeded';
      } else if (totalExpenses / amount >= 0.8) { // 80% threshold
        status = 'approaching';
      }
  
      return {
        budget,
        totalExpenses,
        status
      };
    } catch (err) {
      console.error('Error checking budget:', err);
      throw err;
    }
  };



  
  

module.exports = {
  getBudgets,
  getBudgetById,
  createBudget,
  updateBudget,
  deleteBudget,
  checkBudgets,
  checkBudget
};
