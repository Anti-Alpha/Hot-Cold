// calling different functions depending on the page route

const express = require('express');
const app = express();
const seasonRoutes = require('./season.js');

app.use('/season', seasonRoutes);

module.exports = app;