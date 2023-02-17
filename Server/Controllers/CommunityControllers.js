const community = require('../Models/Community');
const objects = require('../Models/Objects');



const createCommunity = async (req, res) => {
    const {name, userId} = req.body;
    try {
        const newCommunity = new community({
            name,
            ownerID: userId
        })
        const savedCommunity = await newCommunity.save();
        res.status(200).json(savedCommunity);
    } catch (error) {
        res.status(500).json(error);
    }
}

const createObject = async (req, res) => {
    const {name, description, communityId,owner} = req.body;
    try {
        const newObject = new objects({
            name,
            description,
            communityId,
            owner
        })
        const savedObject = await newObject.save();
        res.status(200).json(savedObject);
    } catch (error) {
        res.status(500).json(error);
    }
}


const getObjects = async (req, res) => {
    const {communityId} = req.body;
    try {
        const communityobjects=objects.findById(communityId);
        res.status(200).json(communityobjects);
    }
    catch (error) {
        res.status(500).json(error);
    }
}


module.exports = {
    createCommunity,
    createObject,
    getObjects  
}