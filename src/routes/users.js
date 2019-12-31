const express = require('express')
const router = express.Router()
const pool = require('../libs/db')
const { jwts } = require('../libs/jwt')
const { verifyToken } = require('../libs/verifytoken')

router.get('/', verifyToken, jwts, async (req, res) => {
    const users = await pool.query('SELECT * FROM users');
    res.status(200).send({
        users
    })
})

router.post('/add', verifyToken,jwts, async (req, res, ) => {
    const { user_fullname, user_username, user_password, groups_user_id, role_id } = req.body;
    const users1 = await pool.query('SELECT * FROM users where user_username=?', user_username);
    if (users1.length > 0) {
        res.status(200).send({
            status: false,
        });
    }
    else {
        const newUser = {
            user_fullname,
            user_username,
            user_password,
            role_id,
            groups_user_id,
        };
        newUser.user_password = await helpers.encryptPassword(user_password);
        await pool.query('INSERT INTO users set ?', [newUser]);
        res.status(200).send({
            status: true,
        });
    }
});

module.exports = router