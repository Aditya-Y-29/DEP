const express = require('express');
const mongoose = require('mongoose');
const morgan = require('morgan');
const cors = require('cors');
require('dotenv').config()
const app = express();

app.use(express.json());
app.use(morgan('dev'));
app.use(cors());


// Routes

const userRoutes = require('./Routes/UserRoutes');
const communityRoutes = require('./Routes/CommunityRoutes');
const objectRoutes = require('./Routes/ObjectsRoutes');


app.use('/api/user', userRoutes);
app.use('/api/community', communityRoutes);
app.use('/api/object', objectRoutes);




mongoose.set("strictQuery", false);

mongoose.connect(process.env.MONGO_URI)
    .then(result => {
        app.listen(process.env.PORT, () => {
            console.log(`Listening on port ${process.env.PORT}`)
        })
    })
    .catch(err => console.log(err))