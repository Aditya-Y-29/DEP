const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ServiceSchema = new Schema ({
    objectId:{
        type: String,
        trim: true,
        required: [true, 'Object ID is required']
    },
    userID:{
        type: String,
        required: [true,' Community name is required'],
        trim: true,
    },
    description:{
        type: String,
        trim: true,
        minlength: 1,
        maxlength: 100,
        required: [true, 'Description is required']
    },
    servicedate: Date
})

const Service = mongoose.model('Service', ServiceSchema)

module.exports = Service