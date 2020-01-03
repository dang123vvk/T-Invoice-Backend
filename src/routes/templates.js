const express = require('express')
const router = express.Router()
const pool = require('../libs/db')
const { verifyToken } = require('../libs/verifytoken')
const { jwts } = require('../libs/jwt')


router.get('/edit', verifyToken, jwts, async (req, res) => {
    const temp = await pool.query('SELECT * FROM templates_customer WHERE templates_id=1');
    res.status(200).send({
        temp: temp[0]
    });
});

router.get('/selectcustomer/:customer_id', verifyToken, jwts, async (req, res) => {
    const { customer_id } = req.params;
    const temp = await pool.query('SELECT * FROM templates_customer WHERE customer_id=?', [customer_id]);
    const temp2 = await pool.query('SELECT * FROM templates_customer WHERE templates_id=1');
    if (temp.length > 0) {
        res.status(200).send({
            temp: temp[0]
        });
    }
    else {
        res.status(200).send({
            temp: temp2[0]
        });
    }
});

router.get('/editcustomer/:customer_id', verifyToken,jwts, async (req, res) => {
    const { customer_id } = req.params;
    const temp = await pool.query('SELECT * FROM templates_customer WHERE customer_id=?', [customer_id]);
    const cus = await pool.query('SELECT * FROM customers WHERE customer_id=?', [customer_id]);
    const temp2 = await pool.query('SELECT * FROM templates_customer WHERE templates_id=1');
    if (temp.length > 0) {
        res.status(200).send({
            temp: temp[0],
            cus: cus[0]
        });
    }
    else {
        res.status(200).send({
            temp: temp2[0],
            cus: cus[0]
        });
    }
});

router.post('/editcustomer/', verifyToken, jwts,async (req, res) => {
    const {
        customer_id,
        templates_name_company,
        templates_address,
        templates_phone,
        templates_email,
        templates_name_on_account,
        templates_tel,
        templates_fax,
        templates_sign,
        templates_name_cfo,
        templates_tel_cfo,
        templates_extension_cfo,
        templates_email_cfo } = req.body;
    const newUser = {
        customer_id,
        templates_name_company,
        templates_address,
        templates_phone,
        templates_email,
        templates_name_on_account,
        templates_tel,
        templates_fax,
        templates_sign,
        templates_name_cfo,
        templates_tel_cfo,
        templates_extension_cfo,
        templates_email_cfo
    };

    const temp = await pool.query('SELECT * FROM templates_customer WHERE customer_id=?', [customer_id]);
    if (temp.length > 0) {
        await pool.query('UPDATE templates_customer set ? WHERE templates_id = ?', [newUser, temp[0].templates_id]);
        res.status(200).send({
            status: true
        });
    }
    else {
        await pool.query('INSERT INTO templates_customer set ? ', [newUser]);
        res.status(200).send({
            status: true
        });
    }
});


router.get('/select/:bill_id', verifyToken,jwts, async (req, res) => {
    const { bill_id } = req.params;
    const bill = await pool.query('SELECT * FROM bills WHERE bill_id=?', [bill_id]);
    const templates_id = bill[0].templates_id
    const template = await pool.query('SELECT * FROM templates_bill WHERE templates_id=?', templates_id);
    res.status(200).send({
        temp: template[0]
    });
});

router.post('/edit', verifyToken,jwts, async (req, res) => {
    const {
        customer_id,
        templates_name_company,
        templates_address,
        templates_phone,
        templates_email,
        templates_name_on_account,
        templates_tel,
        templates_fax,
        templates_sign,
        templates_name_cfo,
        templates_tel_cfo,
        templates_extension_cfo,
        templates_email_cfo } = req.body;
    const newUser = {
        customer_id,
        templates_name_company,
        templates_address,
        templates_phone,
        templates_email,
        templates_name_on_account,
        templates_tel,
        templates_fax,
        templates_sign,
        templates_name_cfo,
        templates_tel_cfo,
        templates_extension_cfo,
        templates_email_cfo
    };
    await pool.query('UPDATE templates_customer set ? WHERE templates_id = 1', [newUser]);
    res.status(200).send({
        status: true
    });
});

module.exports = router;