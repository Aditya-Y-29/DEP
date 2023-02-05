const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ServiceSchema = new Schema ({
    objectId: String,
    description: String,
    dueDate: new Date()  
})

const Service = mongoose.model('Service', ServiceSchema)

module.exports = Service