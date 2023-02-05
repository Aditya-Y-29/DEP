const mongoose = require('mongoose')
const Schema = mongoose.Schema

const UserSchema = new Schema ({
    userName: String,
    email: String,
    phone: String,
    inCommunities: []
})

const User = mongoose.model('Users', UserSchema)

module.exports = User