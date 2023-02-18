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
    const {communityID, userID} = req.body;
    try {
        const newcommunityMember = new communityMember({
            communityID,
            userID
        });
        const savedCommunityMember = await newcommunityMember.save();
        res.status(200).json(savedCommunityMember);
    } catch (error) {
        console.log(error);
        res.status(400).json(error);
    }
}

const getuserprofile = async (req, res) => {
    const {userID} = req.body;
    try {
        const userprofile = await user.findById(userID);
        res.status(200).json(userprofile);
    } catch (error) {
        res.status(500).json(error);
    }
}

const getusercommunity = async (req, res) => {
    const {userID} = req.body;
    try {
        const userCommunities= await communityMember.find({userID: userID});
        console.log(userCommunities);
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