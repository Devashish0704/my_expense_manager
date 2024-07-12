const pool = require("../../../db");
const queries = require("../queries");


// Categories
const getCategories = async (req, res) => {
    try {
      // Fetch categories from the database
      const { rows } = await pool.query(queries.getCategories);
  
      // Initialize empty maps for income and expense categories
      let incomeCategories = {};
      let expenseCategories = {};
  
      // Iterate through fetched categories and map them based on type
      rows.forEach(category => {
        if (category.type === 'income') {
          incomeCategories[category.id] = category.name;
        } else if (category.type === 'expense') {
          expenseCategories[category.id] = category.name;
        }
      });
  
      // Return mapped categories as JSON response
      res.status(200).json({ incomeCategories, expenseCategories });
    } catch (error) {
      console.error('Error fetching categories:', error);
      res.status(500).json({ error: 'Failed to fetch categories' });
    }
  };
  
 const getCategoryById = async (req, res) => {
  const { id } = req.params; // Assuming id is passed as a route parameter (user_id)
  
  try {
    // Execute the SQL query to fetch categories by user_id
    const { rows } = await pool.query(queries.getCategoryById, [id]);

    let incomeCategories = {};
      let expenseCategories = {};

       // Iterate through fetched categories and map them based on type
       rows.forEach(category => {
        if (category.type === 'income') {
          incomeCategories[category.id] = category.name;
        } else if (category.type === 'expense') {
          expenseCategories[category.id] = category.name;
        }
      });

    // Respond with the fetched categories
    res.status(200).json({ incomeCategories, expenseCategories });
  } catch (error) {
    console.error('Error fetching categories by user_id:', error);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
};
 const getCategoryByIdForDeletion = async (req, res) => {
  const { id } = req.params; // Assuming id is passed as a route parameter (user_id)
  
  try {
    // Execute the SQL query to fetch categories by user_id
    const { rows } = await pool.query(queries.getCategoryByIdForDeletion, [id]);

      let incomeCategories = {};
      let expenseCategories = {};

       // Iterate through fetched categories and map them based on type
       rows.forEach(category => {
        if (category.type === 'income') {
          incomeCategories[category.id] = category.name;
        } else if (category.type === 'expense') {
          expenseCategories[category.id] = category.name;
        }
      });

    // Respond with the fetched categories
    res.status(200).json({ incomeCategories, expenseCategories });
  } catch (error) {
    console.error('Error fetching categories by user_id:', error);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
};


const createCategory = async (req, res) => {
  const { name, description, type, user_id  } = req.body;

  try {
    // Execute the SQL query to insert a new category
    const { rows } = await pool.query(queries.createCategory, [
      name,
      description,
      type,
      user_id,
    ]);

    // Respond with the newly created category
    res.status(201).json(rows[0]); // Assuming only one row is returned
  } catch (error) {
    console.error('Error creating category:', error);
    res.status(500).json({ error: 'Failed to create category' });
  }
};

const updateCategory = async (req, res) => {
  const id = parseInt(req.params.id);
  const { name, description } = req.body;
  try {
    const result = await pool.query(queries.updateCategory, [
      name,
      description,
      id,
    ]);
    res.status(200).json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: "Internal server error" });
  }
};

const deleteCategory = async (req, res) => {
  const { id } = req.params; // Assuming id is passed as a route parameter (category id)

  try {
    // Check if the category exists and is not common
    const { rows: existingCategory } = await pool.query(queries.deleteCategory, [id]);

    if (existingCategory.length === 0) {
      return res.status(404).json({ error: 'Category not found or cannot be deleted' });
    }

    // Execute the SQL query to delete the category
    await pool.query(queries.deleteCategory, [id]);

    // Respond with success message
    res.status(200).json({ message: 'Category deleted successfully' });
  } catch (error) {
    console.error('Error deleting category:', error);
    res.status(500).json({ error: 'Failed to delete category' });
  }
};

module.exports = {
  getCategories,
  getCategoryById,
  getCategoryByIdForDeletion,
  createCategory,
  updateCategory,
  deleteCategory,
};
