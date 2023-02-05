const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ObjectSchema = new Schema ({
    communityID: String,
    name: String,
    iconPath: String,
    type: String,
})

const object = mongoose.model('object', ObjectSchema)

module.exports = object