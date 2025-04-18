const express = require('express');
const path = require('path');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
const PORT = 3333;

// Serve frontend static files
app.use(express.static(path.join(__dirname, 'frontend')));

// Middleware to parse JSON request bodies
app.use(bodyParser.json());

const DB_FILE = path.join(__dirname, 'data', 'todos.db'); // <-- Use mounted volume


// Ensure the todos.db file exists (important for OpenShift PVC)
if (!fs.existsSync(DB_FILE)) {
  console.log("Database file not found — creating new one.");
  fs.writeFileSync(DB_FILE, '');
}

// Check if database is empty, and initialize the database if necessary
const stats = fs.statSync(DB_FILE);
if (stats.size === 0) {
  console.log("Initializing new database...");
  const db = new sqlite3.Database(DB_FILE);

  db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT)", (err) => {
      if (err) {
        console.error("Failed to create todos table:", err);
      } else {
        console.log("Todos table created successfully.");
      }
    });
  });

  db.close();
}

// Initialize database connection
const db = new sqlite3.Database(DB_FILE);

// API: Get all todos
app.get('/api/todos', (req, res) => {
  db.all("SELECT * FROM todos", (err, rows) => {
    if (err) {
      console.error("Error fetching todos:", err);
      return res.status(500).send(err);
    }
    res.json(rows);
  });
});

// API: Add a new todo
app.post('/api/todos', (req, res) => {
  const task = req.body.task;
  console.log("Received new todo:", task); // Log the incoming task

  db.run("INSERT INTO todos (task) VALUES (?)", [task], function(err) {
    if (err) {
      console.error("Error inserting todo:", err); // Log any error that occurs during the database insert
      return res.status(500).send(err);
    }
    console.log("Inserted todo with ID:", this.lastID); // Log the inserted task's ID
    res.json({ id: this.lastID, task });
  });
});

// API: Delete a todo
app.delete('/api/todos/:id', (req, res) => {
  const id = req.params.id;
  console.log("Deleting todo with ID:", id);

  db.run("DELETE FROM todos WHERE id = ?", [id], function(err) {
    if (err) {
      console.error("Error deleting todo:", err);
      return res.status(500).send(err);
    }
    console.log("Deleted todo with ID:", id);
    res.sendStatus(200);
  });
});

// Catch-all to serve frontend (React, plain HTML, etc.)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'frontend', 'index.html'));
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
