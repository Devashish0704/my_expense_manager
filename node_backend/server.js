require('dotenv').config(); // Ensure dotenv is configured

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const routes = require('./src/expense/routes');
const pool = require("./db");

const app = express();

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());
// Define routes
app.use('/api', routes);

// Middleware to log all requests
// app.use((req, res, next) => {
//   console.log(`Received ${req.method} request for ${req.url}`);
//   next();
// });

// Middleware
// app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({ extended: true }));
// app.use(cors());

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
