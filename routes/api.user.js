const router = require('express').Router();
const controller = require('../controller/user')

router.post('/user', controller.createUser )
router.post('/user/doctor', controller.createDoctor)
router.get('/user/:id', controller.getUser)

module.exports = router;