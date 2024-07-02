const cron = require('node-cron');
const { sendNotification } = require('./notificationService'); // Implement your notification service
const { checkBudget } = require('../expense/controller/budgetController').checkBudget; // Assuming you have a module for budget checking

// Example scheduler to run every day at 8 AM
cron.schedule('0 8 * * *', async () => {
  try {
    const userIds = [/* Fetch user IDs from your database or specify */];
    for (const userId of userIds) {
      const budgets = await pool.query('SELECT * FROM budget WHERE user_id = $1', [userId]);
      for (const budget of budgets.rows) {
        try {
          const budgetStatus = await checkBudget(budget);
          if (budgetStatus.status === 'approaching' || budgetStatus.status === 'exceeded') {
            await sendNotification(userId, `Budget for category ${budget.category_id} is ${budgetStatus.status}!`);
          }
        } catch (err) {
          console.error('Error checking budget:', err);
        }
      }
    }
  } catch (err) {
    console.error('Error fetching budgets for notifications:', err);
  }
});
