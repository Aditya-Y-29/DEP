const mongoose = require('mongoose')
const Schema = mongoose.Schema

const Objects = new Schema ({
    communityID: String,
    name: String,
    iconPath: String,
    type: String,
})

const object = mongoose.model('object', objects)

module.exports = object