const express = require('express')
const router = express.Router()


const {
    addUser,
    joinCommunity,
    getuserprofile,
    getusercommunity,
} = require('../Controllers/UserControllers')

router.route('/adduser').post(addUser)
router.route('/joincommunity').post(joinCommunity)
router.route('/getuserprofile').get(getuserprofile)
router.route('/getusercommunity').get(getusercommunity)

module.exports = router