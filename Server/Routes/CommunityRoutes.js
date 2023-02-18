const express = require('express')
const router = express.Router()


const {
    createCommunity,
    createObject,
    getObjects,
}= require('../Controllers/CommunityControllers')

router.route('/createCommunity').post(createCommunity)
router.route('/createobject').post(createObject)
router.route('/getobjects').get(getObjects)

module.exports=router
