const jwt = require('jsonwebtoken');
const util = require('util');

// jwt.sign 함수를 비동기적으로 사용할 수 있게 변환
const signAsync = util.promisify(jwt.sign);
const privateKey = process.env.JWT_KEY;

// payload를 받아 토큰을 생성하는 함수
async function generateToken(payload) {
  return await signAsync(payload, privateKey);
}
module.exports = generateToken;
