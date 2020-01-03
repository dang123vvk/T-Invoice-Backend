const express = require('express');
const router = express.Router();
const pool = require('../libs/db');
const { verifyToken } = require('../libs/verifytoken');
const { jwts } = require('../libs/jwt')

//Add customer
router.post('/add', verifyToken, jwts, async (req, res) => {
    const { customer_details_company, customer_details_project, customer_details_country, customer_details_note } = req.body;
    const { customer_name, customer_email, customer_number_phone, customer_address, customer_swift_code, user_id, po_nos } = req.body;
    const customer_1 = await pool.query('SELECT * FROM customers where customer_email=?', customer_email);
    if (customer_1.length > 0) {
        res.status(200).send({
            status: false,
        });
    }
    else {
        const newCustomerDetails = {
            customer_details_company,
            customer_details_project,
            customer_details_country,
            customer_details_note,
        };
        const resultCD = await pool.query('INSERT INTO customer_details set ?', [newCustomerDetails]);
        const customer_details_id = resultCD.insertId;
        const newCustomer = {
            customer_name,
            customer_email,
            customer_number_phone,
            customer_address,
            customer_swift_code,
            customer_details_id,
        };
        const resultC = await pool.query('INSERT INTO customers set ?', [newCustomer]);
        const customer_id = resultC.insertId;
        const newUserCustomer = {
            user_id,
            customer_id,
        }
        await pool.query('INSERT INTO users_customers set ?', [newUserCustomer]);
        for (i = 0; i < po_nos.length; i++) {
            const po_no = {
                po_number_no: po_nos[i].po_number_no,
                customer_id: customer_id,
                status_po_id: po_nos[i].status_po_id,
                po_number_description: po_nos[i].po_number_description,
            }
            await pool.query('INSERT INTO po_number set ?', [po_no]);
        }
        res.status(200).send({
            status: true,
            message: 'Customer saved successfully'
        })
    }
});
//Get customer
router.get('/director/senior/:user_id/:groups_user_id/:senior_id', verifyToken, jwts, async (req, res) => {
    const { user_id, groups_user_id, senior_id } = req.params;
    const group = await pool.query('SELECT * FROM users WHERE user_id=? ', [user_id]);
    const senior = await pool.query('SELECT * FROM users WHERE role_id=3 AND groups_user_id=?', [groups_user_id]);
    const customers = await pool.query('SELECT * FROM customers JOIN users_customers ON customers.customer_id = users_customers.customer_id WHERE users_customers.user_id=? ', [user_id]);
    if ((groups_user_id == group[0].groups_user_id) && (senior_id == senior[0].user_id)) {
        res.json({
            customers: customers,
            status: true,
            user: group[0]
        });
    }
    else {
        res.json({
            status: false
        });
    }
});
//Get customer by user_id
router.get('/:user_id', verifyToken, jwts, async (req, res) => {
    const { user_id } = req.params;
    const customers = await pool.query('SELECT * FROM customers JOIN users_customers ON customers.customer_id = users_customers.customer_id WHERE users_customers.user_id=? ORDER BY customers.customer_id DESC', [user_id]);
    const po_nos_add = await pool.query('SELECT * FROM po_number WHERE customer_id = ? AND status_po_id=2', [customers[0].customer_id]);
    res.json({
        customers: customers,
        length_po_nos_add: po_nos_add.length,
        po_nos_add: po_nos_add,
    });
});
//Get customer by user_id limit 3
router.get('/limit/:user_id', verifyToken, jwts, async (req, res) => {
    const { user_id } = req.params;
    const customers = await pool.query('SELECT * FROM customers JOIN customer_details ON customers.customer_details_id = customer_details.customer_details_id   JOIN users_customers ON customers.customer_id = users_customers.customer_id WHERE users_customers.user_id=? ORDER BY customers.customer_id DESC LIMIT 3', [user_id]);
    res.json({
        customers: customers
    });
});
//Get number of customer by user_id
router.get('/length/:user_id', verifyToken, jwts, async (req, res) => {
    const { user_id } = req.params;
    const customers = await pool.query('SELECT * FROM customers JOIN users_customers ON customers.customer_id = users_customers.customer_id WHERE users_customers.user_id=? ', [user_id]);
    res.json({
        length: customers.length
    });
});
//Delete customer
router.get('/delete/:customer_id', verifyToken, jwts, async (req, res) => {
    const { customer_id } = req.params;
    await pool.query('DELETE FROM users_customers WHERE customer_id = ? and user_id = ?', [customer_id, req.user.user_id]);
    await pool.query('DELETE FROM customers WHERE customer_id = ?', [customer_id]);
    res.status(200).send({
        message: 'Customer delleted successfull'
    });
});
//Get customer of user_id
router.get('/edit/:customer_id/:user_id', verifyToken, jwts, async (req, res) => {
    const { customer_id, user_id } = req.params;
            const customers = await pool.query('SELECT * FROM customers WHERE customer_id = ?', [customer_id]);
            const customer_user = await pool.query('SELECT * FROM users_customers WHERE customer_id = ?', [customer_id]);
            const customerDetails = await pool.query('SELECT * FROM customer_details WHERE customer_details_id = ?', [customers[0].customer_details_id]);
            const po_nos = await pool.query('SELECT * FROM po_number JOIN status_po ON status_po.status_po_id = po_number.status_po_id WHERE customer_id = ?', [customer_id]);
            const po_nos_add = await pool.query('SELECT * FROM po_number  WHERE customer_id = ? AND status_po_id=2', [customer_id]);
            const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id JOIN po_number ON po_number.po_number_id=bills.po_number_id WHERE bills.customer_id = ? ORDER BY bill_id DESC', [customer_id]);
            if (user_id == customer_user[0].user_id) {
                if (po_nos_add.length > 0) {
                    res.status(200).send({
                        customers: customers[0],
                        customerDetail: customerDetails[0],
                        customer_user: customer_user[0],
                        po_nos: po_nos,
                        status_po_nos_add: true,
                        po_nos_add: po_nos_add,
                        bill: bill,
                        status: true
                    });
                }
                else {
                    res.status(200).send({
                        customers: customers[0],
                        customerDetail: customerDetails[0],
                        customer_user: customer_user[0],
                        po_nos: po_nos,
                        status_po_nos_add: false,
                        po_nos_add: po_nos_add,
                        bill: bill,
                        status: true
                    });
                }

            }
            else {
                res.status(200).send({
                    status: false
                });
            }
});
//Get list customer in group
router.get('/list/all/senior/:groups_user_id', verifyToken, jwts, async (req, res) => {
    const { groups_user_id } = req.params;
    const customer = await pool.query('SELECT * FROM customers JOIN users_customers ON users_customers.customer_id = customers.customer_id JOIN users ON users_customers.user_id = users.user_id JOIN customer_details ON customers.customer_details_id = customer_details.customer_details_id WHERE users.groups_user_id = ? AND users.role_id=2 ORDER BY customers.customer_id DESC LIMIT 3', [groups_user_id]);
    res.status(200).send({
        customer: customer,
    });
});
//Get Po_No of Customer
router.get('/list/po_no/:customer_id', verifyToken, jwts, async (req, res) => {
    const { customer_id } = req.params;
    const po_nos_add = await pool.query('SELECT * FROM po_number WHERE customer_id = ? AND status_po_id=2', [customer_id]);
    res.status(200).send({
        length_po_nos_add: po_nos_add.length,
        po_nos_add: po_nos_add,
    });
});
//Post from user to update Customer
router.post('/edit/:customer_id', verifyToken, jwts, async (req, res) => {
    const { customer_id } = req.params;
            const { customer_name, customer_email, customer_number_phone, customer_address, customer_swift_code, customer_details_id } = req.body;
            const newCustomer = {
                customer_name,
                customer_email,
                customer_number_phone,
                customer_address,
                customer_swift_code,
                customer_details_id,
            };
            const { customer_details_company, customer_details_project, customer_details_country, customer_details_note, po_nos } = req.body;
            const newCustomerDetails = {
                customer_details_company,
                customer_details_project,
                customer_details_country,
                customer_details_note,
            };
            await pool.query('UPDATE customer_details set ? WHERE customer_details_id = ?', [newCustomerDetails, newCustomer.customer_details_id]);
            await pool.query('UPDATE customers set ? WHERE customer_id = ?', [newCustomer, customer_id]);
            res.status(200).send({
                message: 'Customer edited successfully'
            });
});
//Update Po_Number
router.post('/po_no/:po_number_id', verifyToken, jwts, async (req, res) => {
    const { po_number_id } = req.params;
    const { po_number_no, po_number_description, status_po_id } = req.body;
    const po_no = {
        po_number_no: po_number_no,
        status_po_id: status_po_id,
        po_number_description: po_number_description,
    };
    await pool.query('UPDATE po_number set ? WHERE po_number_id = ?', [po_no, po_number_id]);
    res.status(200).send({
        message: 'po_no edited successfully'
    });
});
//add Po No for Customer
router.post('/add_po_no/:customer_id', verifyToken, jwts, async (req, res) => {
    const { customer_id } = req.params;
    const { po_number_no, po_number_description, status_po_id } = req.body;
    const po_no = {
        po_number_no: po_number_no,
        status_po_id: status_po_id,
        customer_id: customer_id,
        po_number_description: po_number_description,
    };
    await pool.query('INSERT INTO po_number set ?', [po_no])
    const po_nos = await pool.query('SELECT * FROM po_number JOIN status_po ON status_po.status_po_id = po_number.status_po_id WHERE customer_id = ?', [customer_id]);
    res.status(200).send({
        message: 'po_no edited successfully',
        po_nos: po_nos,
    });
});
module.exports = router;