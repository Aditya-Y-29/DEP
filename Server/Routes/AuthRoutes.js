const express = require('express')
const router = express.Router()


const {
    signup,
    login,
    sendotp,
    logout
} = require('../Controllers/UserControllers')

router.route('/adduser').post(addUser)
router.route('/addcommunity').post(addCommunity)
router.route('/joincommunity').post(joinCommunity)

module.exports = router