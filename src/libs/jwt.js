const jwt = require("jsonwebtoken");
module.exports = {
    jwts(req, res, next) {
        jwt.verify(req.token, 'secretkey', (err) => {
            if (err) {
                res.sendStatus(403);
            } else {
                next();
            }
        })
    }
}