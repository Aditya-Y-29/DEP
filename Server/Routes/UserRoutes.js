const express = require('express')
const router = express.Router()


const {
    createUser,
    createCommunity,
    getuserprofile,
    addUserCommunity,
} = require('../Controllers/UserControllers')

router.route('/createUser').post(createUser);
router.route('/createCommunity').post(createCommunity);
router.route('/addUserCommunity').post(addUserCommunity);
router.route('/getUserProfile').get(getuserprofile)

module.exports = router