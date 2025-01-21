const jwt = require('jsonwebtoken');

function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  
  // Bearer 토큰에서 실제 토큰 값 추출
  const token = authHeader && authHeader.split(' ')[1];
  if (!token) {
    return res.json({ message: '토큰이 없습니다.' });
  }

  jwt.verify(token, process.env.JWT_KEY, (err, decoded) => {
    if (err) {
      return res.json({ message: '유효하지 않은 토큰' });
    }
    // 토큰이 유효하면 사용자 정보를 요청 객체에 추가
    req.user = decoded;
    next(); // 요청 처리 흐름을 다음 미들웨어 또는 컨트롤러로 넘김
  });
}

module.exports = authenticateToken;
