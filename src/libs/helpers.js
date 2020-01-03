const bcrypt = require('bcryptjs');

const helpers = {};

helpers.encryptPassword = async (user_password) => {
  const salt = await bcrypt.genSalt(10);
  const hash = await bcrypt.hash(user_password, salt);
  return hash;
};

helpers.matchPassword = async (user_password, savedPassword) => {
  try {
    return await bcrypt.compare(user_password, savedPassword);
  } catch (e) {
    console.log(e)
  }
};

module.exports = helpers;