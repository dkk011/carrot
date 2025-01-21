const { pool } = require('../../database')

exports.index = async (page, size, keyword) => {
  const offset = (page - 1) * size;

  let query = `SELECT feed.*, u.name AS user_name, image_id FROM feed 
    LEFT JOIN user u ON u.id = feed.user_id 
    LEFT JOIN files f ON feed.image_id = f.id`;

  const params = [];

  if (keyword) {
    query += ` WHERE LOWER(feed.title) LIKE ? OR LOWER(feed.content) LIKE ?`;
    const keywordParam = `%${keyword}%`;
    params.push(keywordParam, keywordParam);
  }

  query += ` ORDER BY feed.id DESC LIMIT ? OFFSET ?`;

  // params.push(size, offset);                    // MYSQL 8.0.22 버전 이하
  params.push(size.toString(), offset.toString()); // MYSQL 8.0.22 버전 이상

  return await pool.query(query, params);
}

exports.create = async (user, title, content, price, image) => {
  const query = `INSERT INTO feed (user_id, title, content, price, image_id) VALUES (?,?,?,?,?)`;
  // image가 undefined인 경우 null로 설정
  const imageId = image === undefined ? null : image;
  return await pool.query(query, [user, title, content, price, imageId]);
}

exports.show = async (id) => {
  const query = `SELECT feed.*, u.name user_name, u.profile_id user_profile, image_id FROM feed 
    LEFT JOIN user u on u.id = feed.user_id 
    LEFT JOIN files f1 on feed.image_id = f1.id
    LEFT JOIN files f2 on u.profile_id = f2.id
    WHERE feed.id = ?`
  let result = await pool.query(query, [id]);
  return (result.length < 0) ? null : result[0];
}

exports.update = async (title, content, price, imgid, id) => {
  let query = `UPDATE feed SET title = ? ,content = ?, price = ?`;
  let params = [title, content, price];

  if(imgid) {
    query += ', image_id = ?';
    params.push(`${imgid}`);
  }

  query += ' WHERE id = ?';
  params.push(`${id}`);
  return await pool.query(query, params);
}

exports.delete = async id => {
  return await pool.query(`DELETE FROM feed WHERE id = ?`, [`${id}`]);
}
