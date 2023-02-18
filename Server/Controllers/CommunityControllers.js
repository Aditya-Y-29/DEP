const community = require('../Models/Community');
const objects = require('../Models/Objects');



const createCommunity = async (req, res) => {
    const {communityName, ownerID} = req.body;
    try {
        const newCommunity = new community({
            communityName,
            ownerID
        })
        const savedCommunity = await newCommunity.save();
        res.status(200).json(savedCommunity);
    } catch (error) {
        res.status(500).json(error);
    }
}

const createObject = async (req, res) => {
    const {name, description, communityID,ownerID} = req.body;
    try {
        const newObject = new objects({
            name,
            description,
            communityID,
            ownerID
        })
        const savedObject = await newObject.save();
        res.status(200).json(savedObject);
    } catch (error) {
        res.status(500).json(error);
    }
}

const getObjects = async (req, res) => {
    const {communityID} = req.body;
    try {
        const communityobjects=await objects.find({communityID: communityID});
        res.status(200).json(communityobjects);
    }
    catch (error) {
        console.log(error);
        res.status(500).json(error);
    }
}


module.exports = {
    createCommunity,
    createObject,
    getObjects  
}