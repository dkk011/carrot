const express = require('express');
const router = express.Router();

const multer = require('multer');
const upload = multer({ dest: 'storage/' });
const authenticateToken = require('./middleware/authenticate');

const webController = require('./web/controller');
const apiFeedController = require('./api/feed/controller');
const apiUserController = require('./api/user/controller');
const fileController = require('./api/file/controller')

const { logRequestTime } = require('./middleware/log');


router.get('/', webController.home);
router.get('/page/:route', logRequestTime, webController.page);

router.use(logRequestTime);

router.post('/file', upload.single('file'), fileController.upload);
router.get('/file/:id', fileController.download);


router.post('/auth/phone', apiUserController.phone);
router.put('/auth/phone', apiUserController.phoneVerify);
router.post('/auth/register', apiUserController.register);
router.post('/auth/login', apiUserController.login);

router.use(authenticateToken);

router.get('/api/user/my', apiUserController.show);
router.put('/api/user/my', apiUserController.update);

router.get('/api/feed', apiFeedController.index);
router.post('/api/feed', apiFeedController.store);
router.get('/api/feed/:id', apiFeedController.show);
router.put('/api/feed/:id', apiFeedController.update);
router.delete('/api/feed/:id', apiFeedController.delete);

module.exports = router;

