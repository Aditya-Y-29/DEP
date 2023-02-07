const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ExpenseSchema = new Schema ({
    objectId:{
        type: String,
        required: [true,' Community name is required'],
        trim: true,
    },
    userID:{
        type: String,
        required: [true,' Community name is required'],
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
    // still thinking for this
    expenseDate: new Date(),
    expenseTime: new Time(),
    billImagePath:{
        type: String,
        required: [true,' Icon path is required'],
        trim: true,
    }
})

const Expense = mongoose.model('Expense', ExpenseSchema)

module.exports = Expense