require('dotenv').config();
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = require('./src/router');
const bodyParser = require('body-parser');

// JSON 형식의 데이터 처리
app.use(bodyParser.json());
// URL 인코딩 된 데이터 처리
app.use(bodyParser.urlencoded({ extended: true }));

// 라우터를 애플리케이션에 등록
app.use('/', router);
// 서버 시작
app.listen(port, () => {
  console.log(`웹서버 구동중 ${port}`);
});
