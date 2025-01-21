const { pool } = require('../../database')

exports.create = async (name, path, size) => {
  const query = `INSERT INTO files 
    (original_name, file_path, file_size)
    VALUES (?,?,?)`;
  return await pool.query(query, [name, path, size]);
}

exports.show = async (id) => {
  const query = `SELECT * FROM files WHERE id = ?`;
  const result = await pool.query(query, [`${id}`]);
  return (result.length < 0) ? null : result[0];
}

