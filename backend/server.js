const express = require('express');
const path = require('path');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
const PORT = 3333;

// Serve frontend static files
app.use(express.static(path.join(__dirname, 'frontend')));

// Middleware
app.use(bodyParser.json());

const DB_FILE = path.join('/app/backend', 'todos.db');  // New path after PVC mounting

const db = new sqlite3.Database(DB_FILE);

db.serialize(() => {
  db.run("CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT)");
});

// API: Get all todos
app.get('/api/todos', (req, res) => {
  db.all("SELECT * FROM todos", (err, rows) => {
    if (err) return res.status(500).send(err);
    res.json(rows);
  });
});

// API: Add todo
app.post('/api/todos', (req, res) => {
  const task = req.body.task;
  db.run("INSERT INTO todos (task) VALUES (?)", [task], function(err) {
    if (err) return res.status(500).send(err);
    res.json({ id: this.lastID, task });
  });
});

// API: Delete todo
app.delete('/api/todos/:id', (req, res) => {
  const id = req.params.id;
  db.run("DELETE FROM todos WHERE id = ?", [id], function(err) {
    if (err) return res.status(500).send(err);
    res.sendStatus(200);
  });
});

// Catch-all to serve frontend (React, plain HTML, etc.)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'frontend', 'index.html'));
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
