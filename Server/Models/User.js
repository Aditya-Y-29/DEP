const mongoose = require('mongoose')
const validatorPackage = require('validator')
const Schema = mongoose.Schema

const UserSchema = new Schema ({
    name:{
        type: String,
        required: [true,' Name is required'],
        trim: true,
    },
    userName:{
        type: String,
        required: [true,' UserName is required'],
        trim: true,
        unique: true,
    },
    email:{
        type: String,
        unique: true,
        required: [true, 'Email address is required'],
        validate: {
          validator: validatorPackage.isEmail,
          message: 'Please provide a valid email',
        },
    },
    phone:{
        type: String,
        unique: true,
        required: [true,' Phone nunber is required'],
    },
})

const User = mongoose.model('User', UserSchema)

module.exports = User