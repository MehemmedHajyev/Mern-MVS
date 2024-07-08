const catagoryService = require('../services/catagory-service');



const getAllCatagories = async (req, res) => {
    const data = await catagoryService.getAllCatagories()
    // res.send(JSON.stringify(data, null, 2))
    res.json(data)
}

module.exports = {
    getAllCatagories
}