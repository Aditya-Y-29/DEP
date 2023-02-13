const express = require('express')
const router = express.Router()


const {
    signup,
    login,
    sendotp,
    logout
} = require('../Controllers/UserControllers')

router.route('/signup').post(signup)
router.route('/login').post(login)
router.route('/sendotp').post(sendotp)
router.route('/logout').post(logout)

module.exports = router