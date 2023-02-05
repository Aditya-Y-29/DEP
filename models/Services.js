const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ServiceSchema = new Schema ({
    objectId: String,
    Description: String,
    dueDate: new Date()  
})

const Services = mongoose.model('Services', ServiceSchema)

module.exports = Services