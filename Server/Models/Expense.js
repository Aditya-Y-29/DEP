const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ExpenseSchema = new Schema ({
    objectID:{
        type: String,
        required: [true,' Object name is required'],
        trim: true,
    },
    userID:{
        type: String,
        required: [true,' User name is required'],
        trim: true,
    },
    amount:{
        type: Number,
        required: [true,' Amount is required'],
        min: [0,'Amount must be positive']
    },
    description:{
        type: String,
        trim: true,
        minlength: 1,
        maxlength: 100,
        required: [true, 'Description is required']
    },
    expenseDate: Date,
})

const Expense = mongoose.model('Expense', ExpenseSchema)

module.exports = Expense