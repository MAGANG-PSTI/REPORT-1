require("dotenv").config()

const express = require('express');
const AuthRouters = require("./routers/auth");
const cors = require("cors");
const app = express();

// Initializing express JSON Format and Cross Origin Server access.
app.use(express.json());
app.use(cors());

// Express uses "/api" keyword for routings.
app.use("/api", AuthRouters);

app.listen(process.env.PORT, '0.0.0.0', ()=>{
    console.log(`Succesfully listened to http://localhost:${process.env.PORT}`)
});