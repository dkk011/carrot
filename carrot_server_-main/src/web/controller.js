exports.home = (req, res) => {
  res.json('애플리케이션 소개');
}
exports.page = (req, res) => {
  const route = req.params.route;
  if (route == 'policy') {
    res.json('개인정보 처리방침');
  }
  if (route == 'terms') {
    res.json('이용 약관');
  }
}
