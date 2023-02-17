const community = require('../Models/Community');
const communityMember = require('../Models/CommunityMember');
const user = require('../Models/User');



const addUser = async (req, res) => {
    const {name, userName, email, phone} = req.body;
    try {
        const newUser = new user({
            name,
            userName,
            email,
            phone
        })
        const savedUser = await newUser.save();
        res.status(200).json(savedUser);
    } catch (error) {
        res.status(500).json(error);
    }
}

const joinCommunity = async (req, res) => {
    const {communityId, userId} = req.body;
    try {
        const communityMember = new communityMember({
            communityId,
            userId
        })
        const savedCommunityMember = await communityMember.save();
        res.status(200).json(savedCommunityMember);
    } catch (error) {
        res.status(500).json(error);
    }
}

const getuserprofile = async (req, res) => {
    const {userId} = req.body;
    try {
        const user = await user.findById(userId);
        res.status(200).json(user);
    } catch (error) {
        res.status(500).json(error);
    }
}

const getusercommunity = async (req, res) => {
    const {userId} = req.body;
    try {
        const userCommunities= await communityMember.find({userId: userId});
        res.status(200).json(userCommunities);
    } catch (error) {
        res.status(500).json(error);
    }
}


module.exports = {
    addUser,
    joinCommunity,
    getuserprofile,
    getusercommunity
}