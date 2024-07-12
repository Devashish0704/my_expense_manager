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


// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
