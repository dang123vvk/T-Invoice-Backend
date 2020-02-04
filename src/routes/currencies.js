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
router.get('/next/:month', verifyToken, role, jwts, async (req, res) => {
    const { month } = req.params;
    const currencies = await pool.query('SELECT * FROM currencies WHERE currency_month=? ',[month]);
    var mou = '1';
    if(Number(month.slice(5, 7)) < 12){
        if(Number(month.slice(5, 7)) <10 ){
            
            mou = String(  month.slice(0,4) + '-0' +  (Number(month.slice(5, 7)) + 1) );
        }
        else {
            mou = String(  month.slice(0,4) + '-' +  (Number(month.slice(5, 7)) + 1) );
        }
        
    }
    else {
     mou = String((Number(month.slice(0,4)) + 1) + '-01');;
    }
    currencies.forEach(async currency => {
        const newCurrecy = {
            currency_name: currency.currency_name,
            currency_code: currency.currency_code,
            currency_month: mou,
            currency_rate: currency.currency_rate,
        };
        await pool.query('INSERT INTO currencies set ?', [newCurrecy]);
    });
   res.json({
        message: 'Successfully'
    });
});
router.get('/get_id', verifyToken, role, jwts, async (req, res) => {
    const id = await pool.query('SELECT MAX(currency_id) AS id FROM currencies');
    res.json({
        id: id
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
    const { currency_name, currency_code,  currency_rate } = req.body;
    const newCurrecy = {
        currency_name,
        currency_code,
        currency_rate,
    };
    await pool.query('UPDATE currencies set ? WHERE currency_id = ?', [newCurrecy, currency_id]);
    res.json({
        message: 'A currency Edited Successfully'
    });
});

module.exports = router;