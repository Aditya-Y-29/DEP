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
    iconPath:{
        type: String,
        trim: true,
        //set some default path is not choosen
        //default: "/abc/"
    },
    objectType:{
        type: String,
        trim: true,
    },
    description:{
        type: String,
        trim: true,
    },
    location:{
        type: String,
        trim: true,
    },
    sub_type:{
        type: String,
        trim: true,
    },
    owner:{
        type: String,
        trim: true,
    },
})

const object = mongoose.model('object', ObjectSchema)

module.exports = object