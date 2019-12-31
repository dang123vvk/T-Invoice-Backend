module.exports = {
    authenticate(req, res, next) {
        const role = req.headers.authorization;
        if (role === undefined) {
            return res.status(401).send();
        }
        else {
            next();
        }
    }
};