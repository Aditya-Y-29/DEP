const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ServiceSchema = new Schema ({
    objectId:{
        type: String,
        trim: true,
        required: [true, 'Object ID is required']
    },
    description:{
        type: String,
        trim: true,
        minlength: 1,
        maxlength: 100,
        required: [true, 'Description is required']
    },
    // still thinking for this
    dueDate: new Date()  
})

const Service = mongoose.model('Service', ServiceSchema)

module.exports = Service