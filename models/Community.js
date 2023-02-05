const mongoose = require('mongoose')
const Schema = mongoose.Schema

const CommunitySchema = new Schema ({
    communityName: String,
    ownerID: String,
    iconPath: String
})

const Community = mongoose.model('Community', CommunitySchema)

module.exports = Community