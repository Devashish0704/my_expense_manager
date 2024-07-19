const getExpenses = 'SELECT * FROM expenses';
const getExpensesByUserId = 'SELECT * FROM expenses WHERE user_id = $1';
const createExpense = 'INSERT INTO expenses (user_id, category_id, amount, description, date) VALUES ($1, $2, $3, $4, $5) RETURNING *';
// const updateExpense = 'UPDATE expenses SET category_id = $1, amount = $2, description = $3, date = $4 WHERE id = $5 AND user_id = $6';
const updateExpense = `UPDATE expenses SET category_id = COALESCE($1, category_id), amount = COALESCE($2, amount), description = COALESCE($3, description), date = COALESCE($4, date) WHERE id = $5 AND user_id = $6`;
const deleteExpense = 'DELETE FROM expenses WHERE id = $1 AND user_id = $2 RETURNING *';

const getIncome = 'SELECT * FROM income';
const getIncomeByUserId = 'SELECT * FROM income WHERE user_id = $1';
const createIncome = 'INSERT INTO income (user_id, category_id, amount, description, date) VALUES ($1, $2, $3, $4, $5) RETURNING *';
const updateIncome = 'UPDATE income SET category_id = COALESCE($1, category_id), amount = COALESCE($2, amount), description = COALESCE($3, description), date = COALESCE($4, date) WHERE id = $5 AND user_id = $6';
const deleteIncome = 'DELETE FROM income WHERE id = $1 AND user_id = $2 RETURNING *';


const getUsers = 'SELECT * FROM users';
const getUserById = 'SELECT * FROM users WHERE id = $1';
// const createUser = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING *';
const updateUser = 'UPDATE users SET name = $1, email = $2, password = $3 WHERE id = $4 RETURNING *';
const deleteUser = 'DELETE FROM users WHERE id = $1 RETURNING *';

const getCategories = 'SELECT * FROM categories';
const getCategoryById = `SELECT id, name, description, type, user_id, is_common FROM categories WHERE user_id IS NULL OR user_id = $1`;
const getCategoryByIdForDeletion = `SELECT id, name, description, type, user_id, is_common FROM categories WHERE user_id = $1`;
const createCategory = `INSERT INTO categories (name, description, type, user_id)  VALUES ($1, $2, $3, $4) RETURNING id, name, description, type, user_id`;
const updateCategory = 'UPDATE categories SET name = $1, description = $2 WHERE id = $3 RETURNING *';
const deleteCategory = `DELETE FROM categories WHERE id = $1 AND is_common = false`;
const checkCategory = `SELECT id FROM categories WHERE id = $1 AND is_common = false`;

const getBudgets = 'SELECT * FROM budget';
const getBudgetById = 'SELECT * FROM budget WHERE user_id = $1';
const createBudget = 'INSERT INTO budget (user_id, category_id, allocated_budget, start_date, end_date) VALUES ($1, $2, $3, $4, $5) RETURNING *';
const updateBudget = 'UPDATE budget SET category_id = $1, allocated_budget = $2, start_date = $3, end_date = $4 WHERE id = $5 RETURNING *';
const deleteBudget = 'DELETE FROM budget WHERE id = $1 RETURNING *';
const checkBudget = 'SELECT SUM(amount) AS total_expenses FROM expenses WHERE user_id = $1 AND category_id = $2 AND date BETWEEN $3 AND $4';


const getRecurringTxns = 'SELECT * FROM recurring_txns';
const getRecurringTxnById = 'SELECT * FROM recurring_txns WHERE user_id = $1';
const createRecurringTxn = 'INSERT INTO recurring_txns (user_id, amount, start_date, frequency, category_id, description, remaining_payments, max_payments, type, payment_name) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10) RETURNING *';
const updateRecurringTxn = 'UPDATE recurring_txns SET amount = $2, start_date = $3, frequency = $4, category_id = $5, description = $6, remaining_payments = $7, max_payments = $8, type = $9 WHERE id = $1 AND user_id = $10 RETURNING *';
const deleteRecurringTxn = 'DELETE FROM recurring_txns WHERE id = $1 AND user_id = $2 RETURNING *';


const getPayments = 'SELECT * FROM payments';
const getPaymentById = 'SELECT * FROM payments WHERE id = $1';
const createPayment = 'INSERT INTO payments (user_id, amount, date, method, description) VALUES ($1, $2, $3, $4, $5) RETURNING *';
const updatePayment = 'UPDATE payments SET user_id = $1, amount = $2, date = $3, method = $4, description = $5 WHERE id = $6 RETURNING *';
const deletePayment = 'DELETE FROM payments WHERE id = $1 RETURNING *';



const registerUser = 'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING *';
const loginUser = 'SELECT * FROM users WHERE email = $1';

const beforeAll = 'CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), password VARCHAR(100))';
const afterAll = 'DROP TABLE IF EXISTS users';


const createUser = `INSERT INTO users (google_id, name, email, created_at) VALUES ($1, $2, $3, NOW()) RETURNING id, name, email, created_at`;

const findUserByGoogleId = `SELECT id, google_id AS googleId, name, email, created_at FROM users WHERE google_id = $1`;


module.exports = {
  getExpenses,
  getExpensesByUserId,
  createExpense,
  updateExpense,
  deleteExpense,

  getIncome,
  getIncomeByUserId,
  createIncome,
  updateIncome,
  deleteIncome,

  getUsers,
  getUserById,
  createUser,
  findUserByGoogleId,
  updateUser,
  deleteUser,

  getCategories,
  getCategoryById,
  getCategoryByIdForDeletion,
  createCategory,
  updateCategory,
  deleteCategory,
  checkCategory,

  getRecurringTxns,
  getRecurringTxnById,
  createRecurringTxn,
  deleteRecurringTxn,
  updateRecurringTxn,

  getPayments,
  getPaymentById,
  createPayment,
  updatePayment,
  deletePayment,
  
  getBudgets,
  getBudgetById,
  createBudget,
  updateBudget,
  deleteBudget,
  checkBudget,

  registerUser,
  loginUser,
  beforeAll,
  afterAll
};
