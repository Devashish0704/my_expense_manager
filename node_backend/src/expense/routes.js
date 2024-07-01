// src/expense/routes.js
const express = require('express');
const controllerA = require('./controller/authController');
const controllerE = require('./controller/expenseController');
const controllerB = require('./controller/budgetController');
const passport = require('./passport');
const { registerUserValidationRules, validate } = require('../users/validation');
const { generateOTP, verifyOTP } = require('../expense/controller/authController');



const router = express.Router();

//otp routes
router.post('/auth/generate-otp', controllerA.generateOTP);
router.post('/auth/verify-otp', controllerA.verifyOTP);

// Authentication routes
router.post('/register', registerUserValidationRules(), validate, controllerA.registerUser);
router.post('/login', controllerA.loginUser);

// Secure routes Expenses
router.get('/expenses', controllerE.getExpenses);
router.get('/expenses/:id',passport.authenticate('jwt', { session: false }), controllerE.getExpensesById);
router.post('/expenses', passport.authenticate('jwt', { session: false }), controllerE.createExpense);
router.put('/expenses/:id', passport.authenticate('jwt', { session: false }), controllerE.updateExpense);
router.delete('/expenses/:id', passport.authenticate('jwt', { session: false }), controllerE.deleteExpense);

//Income
router.get('/income', controllerE.getIncome);
router.get('/income/:id', passport.authenticate('jwt', { session: false }),controllerE.getIncomeById);
router.post('/income', passport.authenticate('jwt', { session: false }),controllerE.createIncome);
router.put('/income/:id', passport.authenticate('jwt', { session: false }),controllerE.updateIncome);
router.delete('/income/:id',passport.authenticate('jwt', { session: false }), controllerE.deleteIncome);


// Users
router.get('/users', controllerE.getUsers);
router.get('/users/:id', controllerE.getUserById);
router.post('/users', controllerE.createUser);
router.put('/users/:id', controllerE.updateUser);
router.delete('/users/:id', controllerE.deleteUser);

// Categories
router.get('/categories', controllerE.getCategories);
router.get('/categories/:id', controllerE.getCategoryById);
router.post('/categories', controllerE.createCategory);
router.put('/categories/:id', controllerE.updateCategory);
router.delete('/categories/:id', controllerE.deleteCategory);

// Budgets
router.get('/budgets', controllerB.getBudgets);
router.get('/budgets/:id', controllerB.getBudgetById);
router.post('/budgets', controllerB.createBudget);
router.put('/budgets/:id', controllerB.updateBudget);
router.delete('/budgets/:id', controllerB.deleteBudget);
router.get('/budgets/check/:userId', controllerB.checkBudgets);

// Payments
router.get('/payments', controllerE.getPayments);
router.get('/payments/:id', controllerE.getPaymentById);
router.post('/payments', controllerE.createPayment);
router.put('/payments/:id', controllerE.updatePayment);
router.delete('/payments/:id', controllerE.deletePayment);

module.exports = router;




// Example Queries:
// Fetch Expenses for a Budget Period:

// sql
// Copy code
// SELECT SUM(amount) AS total_expenses 
// FROM expense 
// WHERE userid = $1 AND category_id = $2 AND date BETWEEN $3 AND $4;
// Controller Logic:

// javascript
// Copy code
// const checkBudget = async (budget) => {
//   const { userid, category_id, amount, start_date, end_date } = budget;
//   try {
//     const result = await pool.query(
//       'SELECT SUM(amount) AS total_expenses FROM expense WHERE userid = $1 AND category_id = $2 AND date BETWEEN $3 AND $4',
//       [userid, category_id, start_date, end_date]
//     );
//     const totalExpenses = result.rows[0].total_expenses || 0;
//     return {
//       budget,
//       totalExpenses,
//       status: totalExpenses > amount ? 'exceeded' : 'within'
//     };
//   } catch (err) {
//     console.error('Error checking budget:', err);
//     throw err;
//   }
// };


// 
// 2. Generate Reports and Notifications
// Objective: Periodically check each user's expenses against their budgets, generate reports summarizing the expenses vs. budgets, and send notifications if needed.

// Steps:
// Scheduled Job for Periodic Checks:

// Set up a scheduled job (e.g., using cron jobs) to run the check at regular intervals (e.g., daily).
// Fetch All Budgets:

// Query the budget table to fetch all budget entries.
// Check Each Budget:

// For each budget entry, use the logic outlined above to calculate total expenses and compare against the budgeted amount.
// Generate Reports:

// Create a report summarizing the user's budget status for each category and period.
// Include details like total expenses, budgeted amount, remaining budget, and status (within or exceeded).
// Send Notifications:

// If a user's total expenses are approaching or exceeding their budgeted amount, send a notification (e.g., email or in-app notification) to alert them.
// Example Implementation:
// Scheduled Job:

// javascript
// Copy code
// const cron = require('node-cron');

// cron.schedule('0 0 * * *', async () => {
//   try {
//     const budgets = await pool.query('SELECT * FROM budget');
//     const budgetStatuses = await Promise.all(budgets.rows.map(checkBudget));

//     budgetStatuses.forEach(({ budget, totalExpenses, status }) => {
//       if (status === 'exceeded' || (status === 'within' && totalExpenses / budget.amount > 0.8)) {
//         sendNotification(budget.userid, `Your budget for ${budget.category_id} is ${status}. You have spent ${totalExpenses} out of ${budget.amount}.`);
//       }
//     });

//     generateReport(budgetStatuses);
//   } catch (err) {
//     console.error('Error during budget check job:', err);
//   }
// });
// Notification Logic:

// javascript
// Copy code
// const sendNotification = (userid, message) => {
//   // Logic to send notification (e.g., email or in-app)
//   console.log(`Notify user ${userid}: ${message}`);
// };
// Report Generation:

// javascript
// Copy code
// const generateReport = (budgetStatuses) => {
//   // Logic to generate and save the report
//   console.log('Generating budget report:', budgetStatuses);
// };
// Summary
// Budget Period Calculation: Identify the budget period and fetch relevant expenses to calculate the total.
// Comparison: Compare total expenses against the budget and determine the status.
// Scheduled Checks: Use a scheduled job to periodically check budgets and expenses.
// Notifications and Reports: Generate reports and send notifications to users based on their budget status.
// This detailed logic provides a comprehensive approach to managing and tracking budgets within your application. If you have any further questions or need additional details, feel free to ask!





