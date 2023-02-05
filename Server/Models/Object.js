const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ObjectSchema = new Schema ({
    communityID: String,
    name: String,
    iconPath: String,
    type: String,
    description: String,
    location: String,
    sub_type: String,
    owner: String,
})

const object = mongoose.model('object', ObjectSchema)

module.exports = object