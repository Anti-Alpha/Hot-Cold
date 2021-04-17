const express = require("express");
const router = express.Router();
const fs = require('fs');

const addon = require('./build/Release/addon.node');

const filePath = './data.txt';

function mxGame(){
    let res = addon.matrixGameSolver();
    text = "Company should choose strategy number " + res;
    return text;
}

router.get('/', (req, res, next) => {
    res.status(200).json({
        season: 'Handling GET requests to /season'
    })
});


router.get('/:seasonId', (req, res, next) => {
    const season = req.params.seasonId;
    if(season === "Winter" || season === "Spring" || season === "Summer" || season === "Autumn"){
        fs.writeFileSync(filePath, season);
        let result = mxGame();
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