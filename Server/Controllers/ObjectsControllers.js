const objects = require('../Models/Objects');
const expense=require('../Models/Expense');
const service=require('../Models/Service');


const addExpense = async (req, res) => {
    const {objectID,userID,amount,description,expenseDate} = req.body;
    try {
        const newExpense = new expense({
            objectID,
            userID,
            amount,
            description,
            expenseDate,
        })
        const savedExpense = await newExpense.save();
        res.status(200).json(savedExpense);
    }
    catch (error) {
        console.log(error);
        res.status(500).json(error);
    }
}

const addService = async (req, res) => {
    const {objectID,userID,description,serviceDate} = req.body;
    try {
        const newService = new service({
            objectID,
            userID,
            description,
            serviceDate,
        })
        const savedService = await newService.save();
        res.status(200).json(savedService);
    }
    catch (error) {
        res.status(500).json(error);
    }
}


const getExpenses = async (req, res) => {
    const {objectID} = req.body;
    try {
        const expenses = await expense.find({objectID: objectID});
        res.status(200).json(expenses);
    }
    catch (error) {
        res.status(500).json(error);
    }
}

const getServices = async (req, res) => {
    const {objectID} = req.body;
    try {
        const services = await service.find({objectID: objectID});
        res.status(200).json(services);
    }
    catch (error) {
        res.status(500).json(error);
    }
}

module.exports = {
    addExpense,
    addService,
    getExpenses,
    getServices
}