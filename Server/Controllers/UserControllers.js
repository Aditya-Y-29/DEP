const communityMember = require('../Models/CommunityMember');
const user = require('../Models/User');



const createUser = async (req, res) => {
    const {name, userName, email, phone} = req.body;
    try {
        const newUser = new user({
            name,
            userName,
            email,
            phone
        })
        const savedUser = await newUser.save();
        const id= savedUser._id;
        res.status(200).json({
            message:"User Created",
            userID: id
        });
    } catch (error) {
        res.status(400).json({
            message:"User Creation Failed",
            data:error
        });
    }
}



const createCommunity = async (req, res) => {
    const {communityName, userID} = req.body;
    try {
        const newcommunityMember = new communityMember({
            communityName,
            userID
        });
        const savedCommunityMember = await newcommunityMember.save();
        const id= savedCommunityMember._id;
        res.status(200).json({
            message:"Community Created",
            communityID: id
        });
    } catch (error) {
        res.status(400).json({
            message:"Community Creation Failed",
            data:error
        });
    }
}

const addUserCommunity = async (req, res) => {
    const {userID} = req.body;
    try {
        const userCommunities= await communityMember.find({userID: userID});
        console.log(userCommunities);
        res.status(200).json(userCommunities);
    } catch (error) {
        res.status(500).json(error);
    }
}

const getuserprofile = async (req, res) => {
    const {userID} = req.body;
    try {
        const userprofile = await user.findById(userID);
        res.status(200).json({
            message:"User Profile Fetched Successfully",
            data: userprofile
        });
    } catch (error) {
        res.status(500).json(error);
    }
}



module.exports = {
    createUser,
    createCommunity,
    getuserprofile,
    addUserCommunity
}