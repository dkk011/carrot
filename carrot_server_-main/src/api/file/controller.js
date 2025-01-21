const repository = require('./repository');

exports.upload = async (req, res) => {
  const file = req.file;

  const { affectedRows, insertId } = await repository.create(file.originalname, file.path, file.size);

  if (affectedRows > 0) {
    return res.json({ result: 'ok', data: insertId })
  } else {
    return res.json({ result: 'fail' })
  }
};

exports.download = async (req, res) => {
  const { id } = req.params;

  const item = await repository.show(id);
  
  if (item == null) {
    return res.json({ result: 'fail' })
  }

  res.download(item.file_path, item.original_name, (err) => {
    if (err) {
      res.json({ result: "error", message: err.message });
    }
  });
}
