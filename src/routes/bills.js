const express = require('express');
const router = express.Router();
const pool = require('../libs/db');
const { verifyToken } = require('../libs/verifytoken')
const { jwts } = require('../libs/jwt')

router.get('/list/customer/:customer_id/:user_id', verifyToken, jwts, async (req, res) => {
    const { customer_id, user_id } = req.params;
    const customer = await pool.query('SELECT * FROM customers WHERE customer_id = ?', [customer_id]);
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE bills.customer_id = ? AND bills.user_id = ? ORDER BY bill_id DESC', [customer_id, user_id]);
    res.status(200).send({
        bill: bill,
        customer: customer[0]
    });
});
router.get('/list/all/senior/:groups_user_id', verifyToken, jwts, async (req, res) => {
    const { groups_user_id } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN  users ON bills.user_id = users.user_id JOIN status_bill ON status_bill.status_bill_id = bills.status_bill_id JOIN customers ON customers.customer_id = bills.customer_id  WHERE users.groups_user_id = ? AND users.role_id=2 ORDER BY bills.bill_id DESC', [groups_user_id]);
    res.status(200).send({
        bill: bill,
    });
});
router.get('/senior/director/:customer_id/:user_id', verifyToken,jwts, async (req, res) => {
    const { customer_id, user_id } = req.params;
    const customer = await pool.query('SELECT * FROM customers WHERE customer_id = ?', [customer_id]);
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE bills.customer_id = ? AND bills.user_id = ? ORDER BY bill_id DESC', [customer_id, user_id]);
    res.status(200).send({
        bill: bill,
        customer: customer[0]
    });
});
router.get('/list/user/:user_username', verifyToken, jwts, async (req, res) => {
    const { user_username } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE  users.user_username = ? ORDER BY bill_id DESC', [user_username]);
    res.status(200).send({
        bill: bill,
    });
});
router.get('/list/user/:user_username/search/:search_text?', verifyToken, jwts, async (req, res) => {
    const { user_username, search_text } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE  users.user_username = ? ORDER BY bill_id DESC', [user_username]); 
    if (search_text){
        const newBill = bill.filter(b => b.customer_name.includes(search_text)|| b.status_bill_name.includes(search_text)|| b.bill_date.includes(search_text))
        res.status(200).send({
            bill: newBill,  
        });
    }
    else{
        res.status(200).send({
            bill: bill,
        });
    }
});
//filter bill by customer_id, status_bill_id, date_start, date_end
router.get('/list/user/:user_username/filter/:customer_id/:status_bill_id/:date_start/:date_end', verifyToken, jwts, async (req, res) => {
    const { user_username, customer_id, status_bill_id, date_start, date_end } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE users.user_username = ? AND bills.customer_id = ? AND bills.status_bill_id = ? AND bills.bill_date >= ? AND bills.bill_date <= ? ORDER BY bill_id DESC', [user_username, customer_id, status_bill_id, date_start, date_end]); 
    res.status(200).send({
        bill: bill,
    });
});
router.get('/list/user/limit/:user_id', verifyToken,jwts, async (req, res) => {
    const { user_id } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE  bills.user_id = ? ORDER BY bill_id DESC LIMIT 3', [user_id]);
    res.status(200).send({
        bill: bill,
    });
});
router.get('/list/user/length/:user_id', verifyToken, jwts,async (req, res) => {
    const { user_id } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE  bills.user_id = ? ORDER BY bill_id DESC', [user_id]);
    res.status(200).send({
        length: bill.length,
    });
});
router.get('/list/user/sum/:user_id', verifyToken, jwts, async (req, res) => {
    const { user_id } = req.params;
    const bill = await pool.query('SELECT SUM(bills_sum) as sum FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE  bills.user_id = ? ORDER BY bill_id DESC', [user_id]);
    if (bill[0].sum == null) {
        res.status(200).send({
            total: 0,
        });
    }
    else {
        res.status(200).send({
            total: bill[0].sum,
        });
    }
});
router.get('/list/user/length/notsent/:user_id', verifyToken, jwts, async (req, res) => {
    const { user_id } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE  bills.user_id = ? AND bills.status_bill_id=1 ', [user_id]);
    res.status(200).send({
        bill: bill,
        length: bill.length,
    });
});
router.get('/status', verifyToken,jwts, async (req, res) => {
    const status = await pool.query('SELECT * FROM status_bill ');
    res.status(200).send({
        status: status,
    });
});
router.get('/filter/:groups_user_id/:user_id/:status_bill_id/:date_from/:date_to', verifyToken,jwts, async (req, res) => {
    const { groups_user_id, user_id, status_bill_id, date_from, date_to } = req.params;
    if (user_id == 0) {
        const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE users.groups_user_id=? AND users.role_id = 2  AND bills.status_bill_id=? AND bills.bill_get_date >=? AND bills.bill_get_date <=? ORDER BY bills.bill_id DESC ', [groups_user_id, status_bill_id, date_from, date_to]);
        res.status(200).send({
            bill: bill,
        });
    }
    else {
        const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE users.groups_user_id=? AND bills.user_id=? AND users.role_id = 2 AND bills.status_bill_id=? AND bills.bill_get_date >=? AND bills.bill_get_date <=? ORDER BY bills.bill_id DESC ', [groups_user_id, user_id, status_bill_id, date_from, date_to]);
        res.status(200).send({
            bill: bill,
        });
    }
});
router.get('/list', verifyToken,jwts,  async (req, res) => {
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id ORDER BY bill_id DESC  ');
    res.status(200).send({
        bill: bill,
    });
});
router.get('/search/:user_id/:customer_name/:status_bill_id/:date_from/:date_to', verifyToken, jwts, async (req, res) => {
    if (customer_name == ' ') {
        const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE bills.user_id=?  AND bills.status_bill_id=? AND bills.bill_get_date >=? AND bills.bill_get_date <=? ORDER BY bills.bill_id DESC ', [user_id, status_bill_id, date_from, date_to]);
        res.status(200).send({
            bill: bill,
        });
    }
    else {
        const customer = '%' + customer_name + '%';
        const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE bills.user_id=? AND customers.customer_name LIKE ? AND bills.status_bill_id=? AND bills.bill_get_date >=? AND bills.bill_get_date <=? ORDER BY bills.bill_id DESC ', [user_id, customer, status_bill_id, date_from, date_to]);
        res.status(200).send({
            bill: bill,
        });
    }
});

router.post('/add', verifyToken, jwts, async (req, res) => {
    const { customer_id, user_id, bill_date, account_bank_id, bills_sum, bill_monthly_cost, bill_reference, bill_no, bill_content, data } = req.body;
    const {
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
    const newTemplate = {
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
    const resultA = await pool.query('INSERT INTO templates_bill set ? ', [newTemplate]);
    const templates_id = resultA.insertId;
    const newBill = {
        bill_reference: bill_reference,
        po_number_id: bill_no,
        customer_id: customer_id,
        user_id: user_id,
        bill_date: bill_date,
        status_bill_id: 1,
        account_bank_id: account_bank_id,
        templates_id: templates_id,
        bills_sum: bills_sum,
        bill_monthly_cost: bill_monthly_cost,
        bill_content: bill_content,
        bill_get_date: bill_date
    };
    const resultB = await pool.query('INSERT INTO bills set ?', [newBill]);
    const bill_id = resultB.insertId;
    for (i = 0; i < data.length; i++) {
        const newItem = {
            bill_id: bill_id,
            bill_item_description: data[i].bill_item_description,
            bill_item_cost: parseFloat(data[i].bill_item_cost),
        }
        await pool.query('INSERT INTO bill_items set ?', [newItem]);
    }
    res.json({
        message: 'Bill Saved Successfully'
    });
});
router.post('/edit/:bill_id', verifyToken,jwts, async (req, res) => {
    const { bill_id } = req.params;
    const { customer_id, user_id, bill_date, account_bank_id, bills_sum, bill_monthly_cost, status_bill_id, bill_reference, po_number_id, bill_content, templates_id, items } = req.body;
    const newBill = {
        bill_reference: bill_reference,
        po_number_id: po_number_id,
        customer_id: customer_id,
        user_id: user_id,
        bill_date: bill_date,
        status_bill_id: status_bill_id,
        account_bank_id: account_bank_id,
        templates_id: templates_id,
        bills_sum: bills_sum,
        bill_monthly_cost: bill_monthly_cost,
        bill_content: bill_content,
        bill_get_date: bill_date

    };
    const {
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
    const newTemp = {
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
    await pool.query('UPDATE templates_bill set ? WHERE templates_id = ?', [newTemp, templates_id]);
    await pool.query('UPDATE bills set ? WHERE bill_id = ?', [newBill, bill_id]);
    await pool.query('DELETE FROM bill_items WHERE bill_id = ?', [bill_id]);
    for (i = 0; i < items.length; i++) {
        const newItem = {
            bill_id: bill_id,
            bill_item_description: items[i].bill_item_description,
            bill_item_cost: items[i].bill_item_cost,
        }
        await pool.query('INSERT INTO bill_items set ?', [newItem]);
    }
    res.json({
        message: 'Bill Edited Successfully'
    });
});
router.get('/edit/:bill_id/:user_username', verifyToken, jwts,async (req, res) => {
    const { bill_id, user_username } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN accounts_bank ON bills.account_bank_id = accounts_bank.account_bank_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE bill_id = ?', [bill_id]);
    const accountsbank = await pool.query('SELECT * FROM accounts_bank');
    const items = await pool.query('SELECT * FROM bill_items WHERE bill_id =?', [bill_id]);
    const po_nos_add = await pool.query('SELECT * FROM po_number WHERE customer_id = ? AND status_po_id=2', [bill[0].customer_id]);
    const po_number = await pool.query('SELECT * FROM po_number WHERE po_number_id=?', [bill[0].po_number_id]);
    const user = await pool.query('SELECT * FROM users WHERE user_username=?', [user_username])
    const template = await pool.query('SELECT * FROM templates_bill WHERE templates_id=?', [bill[0].templates_id]);
    if (user[0].user_id == bill[0].user_id) {
        res.status(200).send({
            bill: bill[0],
            accountsbank: accountsbank,
            items: items,
            length: po_nos_add.length,
            po_nos_add: po_nos_add,
            po_number: po_number[0],
            temp: template[0],
            status: true
        })
    }
    else {
        res.status(200).send({
            status: false
        })
    }
});
router.get('/detail/senior/:bill_id/:senior_id', verifyToken, jwts, async (req, res) => {
    const { bill_id, senior_id } = req.params;
    const bill = await pool.query('SELECT * FROM bills JOIN users ON bills.user_id = users.user_id JOIN accounts_bank ON bills.account_bank_id = accounts_bank.account_bank_id JOIN customers ON bills.customer_id = customers.customer_id JOIN status_bill ON bills.status_bill_id = status_bill.status_bill_id WHERE bill_id = ?', [bill_id]);
    const senior = await pool.query('SELECT * FROM users WHERE role_id=3 AND groups_user_id=?', [bill[0].groups_user_id]);
    const accountsbank = await pool.query('SELECT * FROM accounts_bank');
    const items = await pool.query('SELECT * FROM bill_items WHERE bill_id =?', [bill_id]);
    const po_number = await pool.query('SELECT * FROM po_number WHERE po_number_id=?', [bill[0].po_number_id]);
    const template = await pool.query('SELECT * FROM templates_bill WHERE templates_id=?', [bill[0].templates_id]);
    if (senior_id == senior[0].user_id) {
        res.status(200).send({
            bill: bill[0],
            accountsbank: accountsbank,
            items: items,
            status: true,
            po_number: po_number[0],
            temp: template[0],
        })
    }
    else {
        res.status(200).send({
            status: false
        })
    }
});
router.get('/delete/:bill_id', verifyToken, jwts, async (req, res) => {
    const { bill_id } = req.params;
    await pool.query('DELETE FROM bill_items WHERE bill_id = ?', [bill_id]);
    await pool.query('DELETE FROM bills WHERE bill_id = ?', [bill_id]);
    res.json({
        message: "Deleted Bill Successfully"
    });
});
module.exports = router;