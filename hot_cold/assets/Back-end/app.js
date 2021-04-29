const express = require('express');
const app = express();
const seasonRoutes = require('./season.js');

app.use('/season', seasonRoutes);

/*app.use((req, res, next) => {
    let text = mxGame();
    res.status(200).json({
        message: text
    });
});*/

module.exports = app;