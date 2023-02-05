const community = require('../Models/Community');
const communityMember = require('../Models/CommunityMember');
const user = require('../Models/User');



// LOGIN RELATED FUNCTION





// COMMUNITY RELATED FUNCTIONS


const addUser = async (req, res) => {

    const {userName,email,phone} = req.body;

    const newUser = await user.insertMany({
        userName: userName,
        email: email,
        phone: phone,
    });

    console.log(newUser[0]._id.toString());

    res.status(200).json({
        Status: "User Added Successfully"

    });
}



const addCommunity = async (req, res) => {
    const {userID,communityName} = req.body;

    const newCommunity = await community.insertMany({
        communityName: communityName,
        ownerID: userID,
    });

    const newCommunityMember = await communityMember.insertMany({
        communityID: communityID,
        userID: userID,
    });

    res.status(200).json({
        message: "Community Added Successfully"
    });
}



const joinCommunity = async (req, res) => {
    const {userID,communityID} = req.body;

    const newCommunityMember = await communityMember.insertMany({
        communityID: communityID,
        userID: userID,
    });
    
    res.status(200).json({
        message: "Community Joined Successfully"
    });
}

module.exports = {
    addUser,
    addCommunity,
    joinCommunity
}