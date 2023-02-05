const mongoose = require('mongoose')
const Schema = mongoose.Schema

const CommunityMemberSchema = new Schema ({
    communityID: String,
    userID: String
})

const communityMember = mongoose.model('CommunityMember', CommunityMemberSchema)

module.exports = communityMember