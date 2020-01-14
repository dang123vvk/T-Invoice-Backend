module.exports = {
seinor(req, res, next) {
    // Get auth header value
    const role = req.headers['role'];
    // Check if bearer is undefined
    if(role === 'Sr.Director') {
      next();
    } else {
      // Forbidden
      res.sendStatus(403);
    }
  }};