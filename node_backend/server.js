<<<<<<< HEAD
// server.js
require('dotenv').config(); // Add this line at the top
=======
require('dotenv').config(); // Ensure dotenv is configured
>>>>>>> 2ae45eac08b0004ae0de4a76c9209d3b360fd5f1

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const routes = require('./src/expense/routes');
const pool = require("./db");

const app = express();

// Middleware to log all requests
app.use((req, res, next) => {
  console.log(`Received ${req.method} request for ${req.url}`);
  next();
});

// Middleware
app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));

app.use(cors());
<<<<<<< HEAD

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

// Example endpoint for adding data
app.post('/add-data', async (req, res) => {
  const { name, email } = req.body;
  try {
    const result = await pool.query('INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *', [name, email]);
    res.status(201).send(result.rows[0]);
  } catch (error) {
    console.error('Error inserting data:', error.stack);
    res.status(500).send({ error: 'Internal server error', message: error.message });
  }
});

// Define routes
app.use('/api', routes);

// Scheduling function
require('./src/tasks/schedulingFunction');

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Unhandled error:', err.stack);
  res.status(500).send({ error: 'Internal server error', message: err.message });
});

=======
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

>>>>>>> 2ae45eac08b0004ae0de4a76c9209d3b360fd5f1
// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
