const express = require('express');
const router = express.Router();
const pool = require('../libs/db');
const { verifyToken } = require('../libs/verifytoken');
const { jwts } = require('../libs/jwt')

router.get('/', verifyToken, jwts, async (req, res) => {
    const group = await pool.query('SELECT * FROM groups_user');
    res.status(200).send({
        group: group
    });
});
router.get('/:groups_user_id', verifyToken, jwts, async (req, res) => {
    const { groups_user_id } = req.params;
    const group = await pool.query('SELECT * FROM groups_user WHERE groups_user_id = ? ', [groups_user_id]);
    res.status(200).send({
        group: group[0]
    });
});

router.get('/edit/:groups_user_id', verifyToken, jwts, async (req, res) => {
    const { groups_user_id } = req.params;
    const group = await pool.query('SELECT * FROM groups_user WHERE groups_user_id = ?', [groups_user_id]);
    res.status(200).send({
        group: group[0],

    });
});
router.get('/senior/:groups_user_id', verifyToken, jwts, async (req, res) => {
    const { groups_user_id } = req.params;
    const director = await pool.query('SELECT * FROM users WHERE groups_user_id = ? AND role_id =2', [groups_user_id]);
    const customer = await pool.query('SELECT * FROM customers JOIN users_customers ON users_customers.customer_id = customers.customer_id JOIN users ON users_customers.user_id = users.user_id  WHERE users.groups_user_id = ? AND users.role_id=2', [groups_user_id]);
    const datacustomer = await pool.query('SELECT * FROM customers JOIN users_customers ON users_customers.customer_id = customers.customer_id JOIN users ON users_customers.user_id = users.user_id JOIN customer_details ON customers.customer_details_id = customer_details.customer_details_id WHERE users.groups_user_id = ? AND users.role_id=2 ORDER BY customers.customer_id DESC LIMIT 3', [groups_user_id]);
    const bill = await pool.query('SELECT * FROM bills JOIN  users ON bills.user_id = users.user_id  WHERE users.groups_user_id = ? AND users.role_id=2', [groups_user_id]);
    const databill = await pool.query('SELECT * FROM bills JOIN  users ON bills.user_id = users.user_id JOIN status_bill ON status_bill.status_bill_id = bills.status_bill_id JOIN customers ON customers.customer_id = bills.customer_id  WHERE users.groups_user_id = ? AND users.role_id=2 ORDER BY bills.bill_id DESC LIMIT 3', [groups_user_id]);
    const totalbill = await pool.query('SELECT SUM(bills.bills_sum) as sum FROM bills JOIN  users ON bills.user_id = users.user_id  WHERE users.groups_user_id = ? AND users.role_id=2', [groups_user_id]);
    res.status(200).send({
        directorNumber: director.length,
        dataDirector: director,
        customerNumber: customer.length,
        billNumber: bill.length,
        total: totalbill[0].sum,
        dataBill: databill,
        dataCustomer: datacustomer,

    });
});

router.post('/edit', verifyToken, jwts, async (req, res) => {
    const { groups_user_name, groups_user_description, groups_user_id } = req.body;
    const group = await pool.query('SELECT * FROM groups_user WHERE groups_user_id != ? and groups_user_name=?', [groups_user_id, groups_user_name]);
    if (group.length == 0) {
        const groupuser = {
            groups_user_name,
            groups_user_description
        };
        await pool.query('UPDATE groups_user set ? WHERE groups_user_id = ?', [groupuser, groups_user_id]);
        res.status(200).send({
            status: true
        });
    }
    else {
        res.status(200).send({
            status: false
        });
    }
});

router.post('/add', verifyToken, jwts, async (req, res) => {
    const { groups_user_name, groups_user_description } = req.body;
    const group = await pool.query('SELECT * FROM groups_user WHERE  groups_user_name=?', [groups_user_name]);
    if (group.length == 0) {
        const groupuser = {
            groups_user_name,
            groups_user_description
        };
        await pool.query('INSERT INTO groups_user set ?', [groupuser]);
        res.status(200).send({
            status: true
        });
    }
    else {
        res.status(200).send({
            status: false
        });
    }
});

router.get('/delete/:groups_user_id', verifyToken, jwts, async (req, res) => {
    const { groups_user_id } = req.params;
    await pool.query('DELETE FROM groups_user WHERE groups_user_id = ?', [groups_user_id]);
    res.status(200).send({
        users: 'Users Removed Successfully'
    });
});

module.exports = router;
