const mongoose = require('mongoose')
const Schema = mongoose.Schema

const UserSchema = new Schema ({
    userName: String,
    email: String,
    phone: String,
})

const User = mongoose.model('User', UserSchema)

module.exports = User