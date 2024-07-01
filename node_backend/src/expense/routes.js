// src/expense/routes.js
const express = require('express');
const controllerA = require('./controller/authController');
const controllerE = require('./controller/expenseController');
const controllerB = require('./controller/budgetController');
const controllerI = require('./controller/incomeController');
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

// Users
router.get('/users', controllerE.getUsers);
router.get('/users/:id', controllerE.getUserById);
router.post('/users', controllerE.createUser);
router.put('/users/:id', controllerE.updateUser);
router.delete('/users/:id', controllerE.deleteUser);


// Secure routes Expenses
router.get('/expenses', controllerE.getExpenses);
router.get('/expenses/:id',passport.authenticate('jwt', { session: false }), controllerE.getExpensesById);
router.post('/expenses', passport.authenticate('jwt', { session: false }), controllerE.createExpense);
router.put('/expenses/:id', passport.authenticate('jwt', { session: false }), controllerE.updateExpense);
router.delete('/expenses/:id', passport.authenticate('jwt', { session: false }), controllerE.deleteExpense);

//Income
router.get('/income', controllerI.getIncome);
router.get('/income/:id', passport.authenticate('jwt', { session: false }),controllerI.getIncomeById);
router.post('/income', passport.authenticate('jwt', { session: false }),controllerI.createIncome);
router.put('/income/:id', passport.authenticate('jwt', { session: false }),controllerI.updateIncome);
router.delete('/income/:id',passport.authenticate('jwt', { session: false }), controllerI.deleteIncome);


// Budgets
router.get('/budgets', controllerB.getBudgets);
router.get('/budgets/:id',passport.authenticate('jwt', { session: false }), controllerB.getBudgetById);
router.post('/budgets',passport.authenticate('jwt', { session: false }), controllerB.createBudget);
router.put('/budgets/:id',passport.authenticate('jwt', { session: false }), controllerB.updateBudget);
router.delete('/budgets/:id',passport.authenticate('jwt', { session: false }), controllerB.deleteBudget);
router.get('/budgets/check',passport.authenticate('jwt', { session: false }), controllerB.checkBudgets);

// Categories
router.get('/categories', controllerE.getCategories);
router.get('/categories/:id', controllerE.getCategoryById);
router.post('/categories', controllerE.createCategory);
router.put('/categories/:id', controllerE.updateCategory);
router.delete('/categories/:id', controllerE.deleteCategory);


// Payments
router.get('/payments', controllerE.getPayments);
router.get('/payments/:id', controllerE.getPaymentById);
router.post('/payments', controllerE.createPayment);
router.put('/payments/:id', controllerE.updatePayment);
router.delete('/payments/:id', controllerE.deletePayment);

module.exports = router;




