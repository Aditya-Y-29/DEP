const mongoose = require('mongoose')
const Schema = mongoose.Schema

const CommunityMemberSchema = new Schema ({
    communityID:{
        type: String,
        required: [true,' Community Id is required'],
        trim: true,
    },
    userID:{
        type: String,
        required: [true,' User Id is required'],
        trim: true,
    }
})

const communityMember = mongoose.model('CommunityMember', CommunityMemberSchema)

module.exports = communityMember