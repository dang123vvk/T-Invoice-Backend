const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const http = require('http')
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const { database } = require('./libs/keys');


const port = 3001

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
app.use(session({
  secret: 'faztmysqlnodemysql',
  resave: false,
  saveUninitialized: false,
  store: new MySQLStore(database)
}));
app.get('/', (req, res) => res.send(''))
app.use('/users', require('./routes/users'));
const server = http.createServer(app)
server.listen(port, () => console.log(`Server is in port ${port}`))