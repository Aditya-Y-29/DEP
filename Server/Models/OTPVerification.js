const mongoose = require('mongoose')
const Schema = mongoose.Schema

const OTPVerificationSchema = new Schema ({
    phone:String,
    otp:String,
    createdAt: { type: Date, expires: 300, default: Date.now }
})

const OTPVerification = mongoose.model("OTPVerification",OTPVerificationSchema)

module.exports =OTPVerification