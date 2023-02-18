const express = require('express')
const router = express.Router()


const {
    addExpense,
    getExpenses,
    addService,
    getServices,
} = require('../Controllers/ObjectsControllers')


router.route('/addExpense').post(addExpense)
router.route('/getExpenses').get(getExpenses)
router.route('/addService').post(addService)
router.route('/getServices').get(getServices)

module.exports = router