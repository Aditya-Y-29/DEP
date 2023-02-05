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

const Expense = mongoose.model('Expense', ExpenseSchema)

module.exports = Expense