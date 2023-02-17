const mongoose = require('mongoose')
const Schema = mongoose.Schema

const CommunitySchema = new Schema ({
    communityName: {
        type: String,
        required: [true,' Community name is required'],
        trim: true,
    },
    ownerID: {
        type: String,
        required: [true,' Owner Id is required'],
        trim: true,
    }
})

const Community = mongoose.model('Community', CommunitySchema)

module.exports = Community