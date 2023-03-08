const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ServiceSchema = new Schema ({
    objectID:{
        type: String,
        trim: true,
        required: [true, 'Object ID is required']
    },
    name:{
        type: String,
        required: [true,' Name is required'],
        trim: true,
    },
    creatorID:{
        type: String,
        required: [true,'Creator ID is required'],
        trim: true,
    },
    description:{
        type: String,
        trim: true,
        minlength: 1,
        required: [true, 'Description is required']
    },
    serviceDate: Date,
    serviceTime: Time,
    resolverID:{
        type: String,
        trim: true,
    }
})

const Service = mongoose.model('Service', ServiceSchema)

module.exports = Service