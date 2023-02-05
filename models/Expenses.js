const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ExpenseSchema = new Schema ({
    objectId: String,
    userID: String,
    amount: Integer,
    description: String,
    expenseDate: new Date(),
    expenseTime: new Time(),
    billImagePath: String
})

const Expenses = mongoose.model('Expenses', ExpenseSchema)

module.exports = Expenses