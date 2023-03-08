const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ExpenseSchema = new Schema ({
    objectID:{
        type: String,
        required: [true,' Object name is required'],
        trim: true,
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
    amount:{
        type: Number,
        required: [true,' Amount is required'],
    },
    description:{
        type: String,
        trim: true,
        minlength: 1,
        maxlength: 100,
        required: [true, 'Description is required']
    },
    expenseDate: Date,
    expenseTime: Time,
    resolverID:{
        type: String,
        trim: true,
    }
})

const Expense = mongoose.model('Expense', ExpenseSchema)

module.exports = Expense