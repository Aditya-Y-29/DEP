const express = require('express')
const router = express.Router()

const {
    sendOTPEmail,
    verifyOTP,
    userSignUp
} = require('../controllers/LoginControllers')

router.post("/", sendOTPEmail)  
router.post("/verifyotp", verifyOTP) 
router.post("/signup", userSignUp) 

module.exports = router