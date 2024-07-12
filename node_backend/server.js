// server.js
const express = require('express');
const bodyParser = require('body-parser');
const routes = require('./src/expense/routes');
const cors = require('cors');

const app = express();

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());


app.use('/api', routes);

require('./src/tasks/schedulingFunction');

app.get('/health', (req, res) => {
  res.send('Server is running');
});

// Middleware to log all requests
app.use((req, res, next) => {
  console.log(`Received ${req.method} request for ${req.url}`);
  next();
});

// Middleware to parse JSON request bodies
app.use(express.json());

// Database connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.send('Server is running');
});

// Example endpoint that interacts with the database
app.get('/test-db', async (req, res) => {
  try {
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

// Error handling middleware
app.use((err, req, res, next) => {
  console.error('Unhandled error:', err.stack);
  res.status(500).send({ error: 'Internal server error', message: err.message });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
