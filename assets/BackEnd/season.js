const express = require("express");
const router = express.Router();
const fs = require('fs');

const addon = require('./build/Release/addon.node');

const filePath = 'tmp/data.txt';

router.get('/', (req, res, next) => {
    res.status(200).json({
        season: 'Handling GET requests to /season'
    })
});


router.get('/:seasonId', (req, res, next) => {
    const season = req.params.seasonId;
    if(season === "Winter" || season === "Spring" || season === "Summer" || season === "Autumn"){
        let result = addon.matrixGameSolver(season);
        res.status(200).json({
            strategy: result
        });
    }else{
        res.status(200).json({
            error: "No such season"
        });
    }
});

router.post('/', (req, res, next) => {
    res.status(200).json({
        season: 'Handling POST requests to /season'
    })
});

module.exports = router;