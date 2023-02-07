const mongoose = require('mongoose')
const validatorPackage = require('validator')
const Schema = mongoose.Schema

const UserSchema = new Schema ({
    userName:{
        type: String,
        required: [true,' UserName is required'],
        trim: true,
        unique: true,
    },
    email:{
        type: String,
        unique: true,
        lowercase: true,
        required: [true, 'Email address is required'],
        validate: {
          validator: validatorPackage.isEmail,
          message: 'Please provide a valid email',
        },
    },
    phone:{
        type: Number,
        unique: true,
        required: [true,' Phone nunber is required'],
        min: [0, 'Please enter a valid Phone number'],
        max: [9999999999, 'please enter a valid phone number'],
    }    
})

const User = mongoose.model('User', UserSchema)

module.exports = User