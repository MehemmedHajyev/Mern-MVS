const pool = require('../config/db');
const CatagoryModel = require('../models/catagory-model');



const getAllCatagories = async () => {
    const res = await pool.query('select *from categories')
    return CatagoryModel.map(res.rows);
}
module.exports = {
    getAllCatagories,
}
