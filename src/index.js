const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const http = require('http')
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const { database } = require('./libs/keys');

const port = 5001
let allowCrossDomain = function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    next();
}
app.use(allowCrossDomain)
app.use( bodyParser.json({limit: '50mb'}) );
app.use(bodyParser.urlencoded({
  limit: '50mb',
  extended: true,
  parameterLimit:50000
}))
app.use('/', require('./routes/authentication'));
app.use('/accountsbank', require('./routes/accountsbank'));
app.use('/bills', require('./routes/bills'));
app.use('/customers', require('./routes/customers'));
app.use('/roups', require('./routes/groups'));
app.use('/templates', require('./routes/templates'));
app.use('/users', require('./routes/users'));
const server = http.createServer(app)
server.listen(port, () => console.log(`Server is in port ${port}`))