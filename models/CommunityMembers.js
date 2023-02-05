const mongoose = require('mongoose')
const Schema = mongoose.Schema

const CommunityMembers = new Schema ({
    communityID: String,
    userID: string
})

const CommunityMember = mongoose.model('CommunityMember', CommunityMembers)

module.exports = CommunityMember