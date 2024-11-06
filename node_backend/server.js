require('dotenv').config(); // Ensure dotenv is configured

const express = require('express');
const bodyParser = require('body-parser');
const routes = require('./src/expense/routes');
const cors = require('cors');

const app = express();

// Define routes
app.use('/api', routes);

// Middleware
app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));

app.use(cors());
// Define routes
app.use('/api', routes);



// Health check endpoint
app.get('/health', (req, res) => {
  res.send('Server is running');
});

// Example endpoint that interacts with the database
app.get('/test-db', async (req, res) => {
  try {
    console.log('Trying to connect to the database');
    const result = await pool.query('SELECT NOW()');
    res.send(result.rows);
  } catch (error) {
    console.error('Database connection failed:', error.stack);
    res.status(500).send('Database connection failed');
  }
});

// Scheduling function
require('./src/tasks/schedulingFunction');

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
