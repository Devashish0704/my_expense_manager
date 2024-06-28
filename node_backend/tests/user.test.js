// user.test.js
const { validateUserInput } = require('../src/users/validation');

describe('Validation', () => {
  test('validateUserInput should return true for valid input', () => {
    const input = { name: 'John Doe', email: 'john.doe@example.com' };
    expect(validateUserInput(input)).toBe(true);
  });

  test('validateUserInput should return false for invalid input', () => {
    const input = { name: 'John Doe', email: 'invalid-email' };
    expect(validateUserInput(input)).toBe(false);
  });
});


