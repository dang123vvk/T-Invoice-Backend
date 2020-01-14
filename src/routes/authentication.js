const express = require('express');
const router = express.Router();
const pool = require('../libs/db');
const jwt = require("jsonwebtoken");
const passport = require('passport');
const helpers = require('../libs/helpers');

router.post('/signin', async (req, res) => {
  const {user_username, user_password} = req.body;
  const user = {
    user_name: user_username,
    user_password: user_password
  };
  const rows = await pool.query('SELECT * FROM users JOIN roles ON roles.role_id = users.role_id WHERE user_username = ?', [user_username]);
  if (rows.length > 0) {
    const user1 = rows[0];
    const validPassword = await helpers.matchPassword(user_password, user1.user_password)
    if(user1.role_id==1){
    }
    if (validPassword) {
      jwt.sign({user}, 'secretkey', (err, token) => {
        res.json({
          message :'Login successfull',
          token: 'Bearer ' + token,
          user_fullname: user1.user_fullname,
          user_username: user1.user_username,
          status: true,
          role: user1.role_name,
          user_id: user1.user_id,
          group: user1.groups_user_id
        });
      });
    } else {
      res.status(200).send({
        message:'User Name or Email or Password is incorrect',
        status: false
      });
    }
  } else {
    res.status(200).send({
      message:'User Name is not exist',
      status: false
    });
  }
});

module.exports = router;