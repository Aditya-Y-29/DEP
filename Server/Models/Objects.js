const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ObjectSchema = new Schema ({
    communityID:{
        type: String,
        required: [true,' Community Id is required'],
        trim: true,
    },
    name:{
        type: String,
        required: [true,' Object name is required'],
        trim: true,
        unique: true,
    },
    description:{
        type: String,
        trim: true,
    },
    ownerID:{
        type: String,
        trim: true,
    }
})

const object = mongoose.model('object', ObjectSchema)

module.exports = object