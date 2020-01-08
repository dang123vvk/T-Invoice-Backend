const express = require('express');
const router = express.Router();
const pool = require('../libs/db');
const { verifyToken } = require('../libs/verifytoken');
const _ = require ('lodash');
const { jwts } = require('../libs/jwt');

router.post('/add', verifyToken, jwts, async (req, res) => {
    const { account_bank_number, account_bank_name, account_bank_address, account_bank_swift } = req.body;
    const account_bank_1 = await pool.query('SELECT * FROM accounts_bank where account_bank_number=?', account_bank_number);
    if (account_bank_1.length > 0) {
        res.status(200).send({
            status: false,
        });
    }
    else {
        const newAccountbank = {
            account_bank_number,
            account_bank_name,
            account_bank_address,
            account_bank_swift,
        };
        await pool.query('INSERT INTO accounts_bank set ?', [newAccountbank]);
        res.json({
            message: 'Account Bank Saved Successfully',
            status: true
        });
    }
});
router.get('/', verifyToken, jwts, async (req, res) => {
    const accountsbank = await pool.query('SELECT * FROM accounts_bank ORDER BY account_bank_id DESC ');
    res.json({
        accountsbank: accountsbank
    });
});

router.get('/search/:search_text?', verifyToken, jwts, async (req, res) => {
    const accountsbank = await pool.query('SELECT * FROM accounts_bank ORDER BY account_bank_id DESC ');
    const { search_text } = req.params;
    if (search_text){
        const newAccountsbank = accountsbank.filter(bank => bank.account_bank_number.includes(search_text) || bank.account_bank_address.includes(search_text)|| bank.account_bank_swift.includes(search_text)|| bank.account_bank_name.includes(search_text))
        res.json({
            accountsbank: newAccountsbank
        });
    }
    else{
        res.json({
            accountsbank: accountsbank
        });
    }
});

router.get('/delete/:account_bank_id', verifyToken, jwts, async (req, res) => {
    const { account_bank_id } = req.params;
    await pool.query('DELETE FROM accounts_bank WHERE account_bank_id = ?', [account_bank_id]);
    res.json({
        message: 'Account Bank Deleted Successfully',
    });
});
router.get('/edit/:account_bank_id', verifyToken, jwts, async (req, res) => {
    const { account_bank_id } = req.params;
    const accountsbank = await pool.query('SELECT * FROM accounts_bank WHERE account_bank_id = ?', [account_bank_id]);
    res.json({
        accountsbank: accountsbank[0]
    });
});

router.post('/edit/:account_bank_id', verifyToken, jwts, async (req, res) => {
    const { account_bank_id } = req.params;
    const { account_bank_number, account_bank_name, account_bank_address, account_bank_swift } = req.body;
    const newAccountbank = {
        account_bank_number,
        account_bank_name,
        account_bank_address,
        account_bank_swift
    };
    await pool.query('UPDATE accounts_bank set ? WHERE account_bank_id = ?', [newAccountbank, account_bank_id]);
    res.json({
        message: 'Account Bank Edited Successfully'
    });
});

module.exports = router;