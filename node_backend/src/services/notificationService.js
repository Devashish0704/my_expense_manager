// services/notificationService.js
async function sendNotification(userId, message) {
  // Implementation to send notification
  console.log(`Sending notification to user ${userId}: ${message}`);
  // Example: integration with a notification service provider
  // await notificationProvider.send(userId, message);
}

module.exports = { sendNotification };
