const express = require('express');
const dotevn = require('dotenv');

const catagoriesController = require('./controllers/catagory-controller');
dotevn.config();            


const PORT = process.env.PORT || 3001


const app = express();

app.use(express.static('public'))


app.get('/', (req, res) => {
    res.send('App İsleyir');
});


app.get('/faq', (req, res) => {
    res.send('Faq Page')
});

app.get('/catagories', catagoriesController.getAllCatagories)



app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
