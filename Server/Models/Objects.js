const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ObjectSchema = new Schema ({
    communityID:{
        type: String,
        required: [true,' Community Id is required'],
        trim: true,
    },
    ownerID:{
        type: String,
        trim: true,
    },
    name:{
        type: String,
        required: [true,' Object name is required'],
        trim: true,
        unique: true,
    },
    type:{
        type: String,
        trim: true,
    },
    location:{
        type: String,
        trim: true,
    },
    description:{
        type: String,
        trim: true,
    },
})

const object = mongoose.model('Objects', ObjectSchema)

module.exports = object