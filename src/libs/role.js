module.exports = {
role(req, res, next) {
    // Get auth header value
    const role = req.headers['role'];
    // Check if bearer is undefined
    if(role === 'Admin') {
      next();
    } else {
      // Forbidden
      res.sendStatus(403);
    }
  }};