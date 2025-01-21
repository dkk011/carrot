const { pool } = require('../../database')

exports.register = async (phone, password, name) => {
  const query = `INSERT INTO user (phone, password, name) VALUES (?,?,?)`;
  return await pool.query(query, [phone, password, name]);
}

exports.login = async (phone, password) => {
  const query = `SELECT * FROM user WHERE phone = ? AND password = ?`;
  let result = await pool.query(query, [phone, password]);
  return (result.length < 0) ? null : result[0];
}

exports.findByPhone = async (phone) => {
  let result = await pool.query(`SELECT count(*) count FROM user where phone = ?`, [phone]);
  return (result.length < 0) ? null : result[0];
}
exports.findId = async (id) => {
  const result = await pool.query(`SELECT id, name, phone, created_at, profile_id FROM user WHERE id = ?`, [`${id}`]);
  return (result.length < 0) ? null : result[0];
}
exports.update = async (id, name, image) => {
  const profileId = image === undefined ? null : image;
  const query = `UPDATE user SET name = ?, profile_id = ? WHERE id = ?`;
  return await pool.query(query, [name, profileId, id]);
}
