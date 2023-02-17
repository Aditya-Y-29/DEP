const objects = require('../Models/Objects');
const expense=require('../Models/Expense');
const service=require('../Models/Service');


const addExpense = async (req, res) => {
    const {objectId,userId,amount,description,expenseDate,expenseTime} = req.body;
    try {
        const newExpense = new expense({
            objectId,
            userId,
            amount,
            description,
            expenseDate,
            expenseTime
        })
        const savedExpense = await newExpense.save();
        res.status(200).json(savedExpense);
    }
    catch (error) {
        res.status(500).json(error);
    }
}

const addService = async (req, res) => {
    const {objectId,userId,amount,description,serviceDate,serviceTime} = req.body;
    try {
        const newService = new service({
            objectId,
            userId,
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
    const {objectId} = req.body;
    try {
        const expenses = await expense.find({objectId: objectId});
        res.status(200).json(expenses);
    }
    catch (error) {
        res.status(500).json(error);
    }
}

const getServices = async (req, res) => {
    const {objectId} = req.body;
    try {
        const services = await service.find({objectId: objectId});
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