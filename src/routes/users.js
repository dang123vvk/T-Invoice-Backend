const express = require('express')
const router = express.Router()
const pool = require('../libs/db')
const { jwts } = require('../libs/jwt')
const { verifyToken } = require('../libs/verifytoken')
const helpers = require('../libs/helpers');

//All user except Admin
router.get('/', verifyToken, jwts, async (req, res) => {
    const users = await pool.query('SELECT * FROM users JOIN groups_user ON groups_user.groups_user_id = users.groups_user_id JOIN roles ON roles.role_id =users.role_id  where users.role_id!=1');
    res.status(200).send({
        users: users
    });
});
//Get number of user
router.get('/length', verifyToken, jwts, async (req, res) => {
    const users = await pool.query('SELECT * FROM users JOIN groups_user ON groups_user.groups_user_id = users.groups_user_id JOIN roles ON roles.role_id =users.role_id  where users.role_id!=1');
    res.status(200).send({
        length: users.length
    });
});
//Get user of group by group_user_id
router.get('/groups/senior/:groups_user_id', verifyToken, jwts, async (req, res) => {
    const { groups_user_id } = req.params;
    const users = await pool.query('SELECT * FROM users JOIN groups_user ON groups_user.groups_user_id = users.groups_user_id JOIN roles ON roles.role_id =users.role_id  where users.role_id=2 and users.groups_user_id=? ORDER BY users.role_id DESC ', [groups_user_id]);
    res.status(200).send({
        users: users
    });
});
//Get roles 
router.get('/roles', verifyToken, jwts, async (req, res) => {
    const roles = await pool.query('SELECT * FROM roles');
    res.status(200).send({
        roles: roles
    });
});
//Get number of group
router.get('/groups/length', async (req, res) => {
    const groups = await pool.query('SELECT * FROM groups_user');
    res.status(200).send({
        length: groups.length
    });
});
//Get groups
router.get('/groups', verifyToken, jwts, async (req, res) => {
    const groups = await pool.query('SELECT * FROM groups_user');
    res.status(200).send({
        groups: groups
    });
});
//Delete user by id 
router.get('/delete/:user_id', verifyToken, jwts, async (req, res) => {
    const { user_id } = req.params;
    await pool.query('DELETE FROM users WHERE user_id = ?', [user_id]);
    res.status(200).send({
        users: 'Users Removed Successfully'
    });
});
//Get user to update information of user
router.get('/edit/:user_username', verifyToken, jwts, async (req, res) => {
    const { user_username } = req.params;
    const users = await pool.query('SELECT user_username,user_fullname,groups_user_name FROM users JOIN groups_user ON groups_user.groups_user_id=users.groups_user_id WHERE user_username = ?', [user_username]);
    res.status(200).send({
        user: users[0]
    });
});
//Update information of user
router.post('/edit/:user_id', verifyToken, jwts, async (req, res) => {
    const { user_id } = req.params;
    const { user_fullname, user_username, user_password, groups_user_id } = req.body;
    const newUser = {
        user_fullname,
        user_username
    };
    if (user_password != "") {

        newUser.user_password = await helpers.encryptPassword(user_password);
    }
    newUser.groups_user_id = groups_user_id;
    await pool.query('UPDATE users set ? WHERE user_id = ?', [newUser, user_id]);
    res.status(200).send({
        status: true
    });
});
//Update information profile current user
router.post('/edit/profile/:user_username', verifyToken, jwts, async (req, res) => {
    const { user_username } = req.params;
    const { user_fullname, user_oldpassword, user_password } = req.body;
    const newUser = {
        user_fullname
    };
    const rows = await pool.query('SELECT * FROM users WHERE user_username = ?', [user_username]);
    const user1 = rows[0];
    if (user_oldpassword != "") {
        const validPassword = await helpers.matchPassword(user_oldpassword, user1.user_password);
        if (validPassword) {
            if (user_password != "") {
                newUser.user_password = await helpers.encryptPassword(user_password);
            }
            await pool.query('UPDATE users set ? WHERE user_username = ?', [newUser, user_username]);
            res.status(200).send({
                status: true,
                message: 'Update successful!'
            });
        }
        else {
            res.status(200).send({
                status: false,
                message: 'The old password is incorrect'
            });
        }
    }
    else {
        await pool.query('UPDATE users set ? WHERE user_username = ?', [newUser, user_username]);
        res.status(200).send({
            status: true,
            message: 'Update successful!'
        });
    }
});
//Add user
router.post('/add', verifyToken, jwts, async (req, res, ) => {
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