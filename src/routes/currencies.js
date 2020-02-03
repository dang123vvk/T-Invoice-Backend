const express = require('express');
const router = express.Router();
const pool = require('../libs/db');
const { verifyToken } = require('../libs/verifytoken');
const { jwts } = require('../libs/jwt');
const { role } = require('../libs/role')


router.post('/add', verifyToken, role, jwts, async (req, res) => {
    const { currency_name, currency_code, currency_month, currency_rate } = req.body;
    const newCurrecy = {
        currency_name,
        currency_code,
        currency_month,
        currency_rate,
    };
    await pool.query('INSERT INTO currencies set ?', [newCurrecy]);
    res.json({
        message: 'A New Currecy Saved Successfully',
        status: true
    })
});
router.get('/month/:month', verifyToken, role, jwts, async (req, res) => {
    const { month } = req.params;
    const currencies = await pool.query('SELECT * FROM currencies WHERE currency_month=?  ORDER BY currency_code DESC ',[month]);
    res.json({
        currencies: currencies
    });
});

router.get('/edit/:currency_id', verifyToken, role, jwts, async (req, res) => {
    const { currency_id } = req.params;
    const currencies = await pool.query('SELECT * FROM currencies WHERE currency_id = ?', [currency_id]);
    res.json({
        currency: currencies[0]
    });
});

router.post('/edit/:currency_id', verifyToken,role, jwts, async (req, res) => {
    const { currency_id } = req.params;
    const { currency_name, currency_code, currency_month, currency_rate } = req.body;
    const newCurrecy = {
        currency_name,
        currency_code,
        currency_month,
        currency_rate,
    };
    await pool.query('UPDATE currencies set ? WHERE currency_id = ?', [newCurrecy, currency_id]);
    res.json({
        message: 'A currency Edited Successfully'
    });
});

module.exports = router;