// src/expense/routes.js
require('dotenv').config();

const express = require('express');
const controllerA = require('./controller/authController');
const controllerE = require('./controller/expenseController');
const controllerB = require('./controller/budgetController');
const controllerC = require('./controller/categoryController');
const controllerI = require('./controller/incomeController');
const controllerRT = require('./controller/recurring-txns');

const imageController = require('./controller/imageController');
const passport = require('./passport');
const { registerUserValidationRules, validate } = require('../users/validation');

const router = express.Router();

//otp routes
router.post('/auth/generate-otp', controllerA.generateOTP);
router.post('/auth/verify-otp', controllerA.verifyOTP);

// Authentication routes
router.post('/register', registerUserValidationRules(), validate, controllerA.registerUser);
router.post('/login', controllerA.loginUser);
router.post('/auth/google/verify', controllerA.googleUser)
<<<<<<< HEAD
=======


//  profile image
router.post('/profile-image',passport.authenticate('jwt', { session: false }), imageController.uploadOrUpdateImage);
router.get('/profile-image/:userId',passport.authenticate('jwt', { session: false }), imageController.getImage);
router.delete('/profile-image/:userId',passport.authenticate('jwt', { session: false }), imageController.deleteImage);

  

// Users
router.get('/users', controllerE.getUsers);
router.get('/users/:id', controllerE.getUserById);
router.post('/users', controllerE.createUser);
router.put('/users/:id', controllerE.updateUser);
router.delete('/users/:id', controllerE.deleteUser);

>>>>>>> 2ae45eac08b0004ae0de4a76c9209d3b360fd5f1


<<<<<<< HEAD
//  profile image
router.post('/profile-image',passport.authenticate('jwt', { session: false }), imageController.uploadOrUpdateImage);
router.get('/profile-image/:userId',passport.authenticate('jwt', { session: false }), imageController.getImage);
router.delete('/profile-image/:userId',passport.authenticate('jwt', { session: false }), imageController.deleteImage);

  

// Users
router.get('/users', controllerE.getUsers);
router.get('/users/:id', controllerE.getUserById);
router.post('/users', controllerE.createUser);
router.put('/users/:id', controllerE.updateUser);
router.delete('/users/:id', controllerE.deleteUser);


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


=======
//Income
router.get('/income', controllerI.getIncome);
router.get('/income/:id', passport.authenticate('jwt', { session: false }),controllerI.getIncomeById);
router.post('/income', passport.authenticate('jwt', { session: false }),controllerI.createIncome);
router.put('/income/:id', passport.authenticate('jwt', { session: false }),controllerI.updateIncome);
router.delete('/income/:id',passport.authenticate('jwt', { session: false }), controllerI.deleteIncome);


>>>>>>> 2ae45eac08b0004ae0de4a76c9209d3b360fd5f1
// Budgets
router.get('/budgets', controllerB.getBudgets);
router.get('/budgets/:id',passport.authenticate('jwt', { session: false }), controllerB.getBudgetById);
router.post('/budgets',passport.authenticate('jwt', { session: false }), controllerB.createBudget);
router.put('/budgets/:id',passport.authenticate('jwt', { session: false }), controllerB.updateBudget);
router.delete('/budgets/:id',passport.authenticate('jwt', { session: false }), controllerB.deleteBudget);
router.get('/budgets/check/:id',passport.authenticate('jwt', { session: false }), controllerB.checkBudgets);

// Categories
router.get('/categories', controllerC.getCategories);
router.get('/categories/:id',passport.authenticate('jwt', { session: false }), controllerC.getCategoryById);
router.get('/categories/deletion/:id',passport.authenticate('jwt', { session: false }), controllerC.getCategoryByIdForDeletion);
router.post('/categories',passport.authenticate('jwt', { session: false }), controllerC.createCategory);
router.put('/categories/:id',passport.authenticate('jwt', { session: false }), controllerC.updateCategory);
router.delete('/categories/:id',passport.authenticate('jwt', { session: false }), controllerC.deleteCategory);



// Recurring Transactions
router.get('/recurring-txns', controllerRT.getRecurringTxns);
router.get('/recurring-txns/:id', passport.authenticate('jwt', { session: false }), controllerRT.getRecurringTxnById);
router.post('/recurring-txns', controllerRT.createRecurringTxn);
router.put('/recurring-txns/:id', passport.authenticate('jwt', { session: false }), controllerRT.updateRecurringTxn);
router.delete('/recurring-txns/:id', passport.authenticate('jwt', { session: false }), controllerRT.deleteRecurringTxn);


// Payments
router.get('/payments', controllerE.getPayments);
router.get('/payments/:id', controllerE.getPaymentById);
router.post('/payments', controllerE.createPayment);
router.put('/payments/:id', controllerE.updatePayment);
router.delete('/payments/:id', controllerE.deletePayment);

module.exports = router;




