// src/expense/validation.js
const { body, validationResult } = require('express-validator');

const registerUserValidationRules = () => {
  return [
    body('name').isLength({ min: 1 }).withMessage('Name is required'),
    body('email').isEmail().withMessage('Email is not valid'),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
  ];
};

const validate = (req, res, next) => {
  const errors = validationResult(req);
  if (errors.isEmpty()) {
    return next();
  }
  const extractedErrors = [];
  errors.array().map(err => extractedErrors.push({ [err.param]: err.msg }));

  return res.status(422).json({
    errors: extractedErrors,
  });
};

function validateUserInput(input) {
  const { name, email } = input;
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (typeof name !== 'string' || typeof email !== 'string') {
    return false;
  }
  if (!name.trim() || !emailRegex.test(email)) {
    return false;
  }
  return true;
}



module.exports = {
  registerUserValidationRules,
  validate,
  validateUserInput 
};
