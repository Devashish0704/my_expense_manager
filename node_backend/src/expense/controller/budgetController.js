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
  const { user_id, category_id, allocated_budget, start_date, end_date } = req.body;
  try {
      const newBudget = await pool.query(queries.createBudget,
          [user_id, category_id, allocated_budget, start_date, end_date]
      );
      res.status(201).json(newBudget.rows[0]);
  } catch (err) {
      console.error('Error creating budget:', err);
      res.status(500).json({ error: 'Internal server error' });
  }
};

const updateBudget = async (req, res) => {
  const budgetId = req.params.id;
  const { category_id, allocated_budget, start_date, end_date } = req.body;
  try {
      const updatedBudget = await pool.query(
          queries.updateBudget,
          [category_id, allocated_budget, start_date, end_date, budgetId]
      );
      if (updatedBudget.rows.length === 0) {
          return res.status(404).json({ error: 'Budget not found' });
      }
      res.status(200).json(updatedBudget.rows[0]);
  } catch (err) {
      console.error('Error updating budget:', err);
      res.status(500).json({ error: 'Internal server error' });
  }
};

const deleteBudget = async (req, res) => {
  const budgetId = req.params.id;
  try {
      const deletedBudget = await pool.query(
          queries.deleteBudget,
          [budgetId]
      );
      if (deletedBudget.rows.length === 0) {
          return res.status(404).json({ error: 'Budget not found' });
      }
      res.status(200).json(deletedBudget.rows[0]);
  } catch (err) {
      console.error('Error deleting budget:', err);
      res.status(500).json({ error: 'Internal server error' });
  }
};;

// Controller function to check all budgets for a user
const checkBudgets = async (req, res) => {
  const userId = req.params.id; // Assuming user ID is retrieved from authentication middleware
  try {
      // Fetch all budgets for the given user ID
      const budgets = await pool.query(
          'SELECT * FROM budget WHERE user_id = $1',
          [userId]
      );

      // Check each budget and update current_amount
      const budgetStatuses = await Promise.all(budgets.rows.map(checkAndUpdateBudget));

      // Respond with the statuses
      res.status(200).json(budgetStatuses);
  } catch (err) {
      console.error('Error checking budgets:', err);
      res.status(500).json({ error: 'Internal server error' });
  }
}

// Function to check budget status and update current_amount
const checkAndUpdateBudget = async (budget) => {
  const { id, user_id, category_id, allocated_budget, start_date, end_date } = budget;
  try {
      // Calculate total expenses for the budget period
      const result = await pool.query(
          'SELECT COALESCE(SUM(amount), 0) AS total_expenses FROM expenses WHERE user_id = $1 AND category_id = $2 AND date BETWEEN $3 AND $4',
          [user_id, category_id, start_date, end_date]
      );
      const totalExpenses = parseFloat(result.rows[0].total_expenses);

      console.log(`Total Expenses for Budget ID ${id}: ${totalExpenses}`);

      // Determine the status
      let status = 'within';
      if (totalExpenses > allocated_budget) {
          status = 'exceeded';
      } else if (totalExpenses / allocated_budget >= 0.8) {
          // 80% threshold
          status = 'approaching';
      }

      // Update current_amount in the budget table
      await pool.query(
          'UPDATE budget SET current_amount = $1 WHERE id = $2',
          [totalExpenses, id]
      );

      return {
          budget,
          totalExpenses,
          status,
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
};
