const express = require('express');
const Authrouters = express.Router();
const User =require('../model/database');
const bcryptjs = require('bcryptjs');
const jsonwebtoken = require('jsonwebtoken');

// Authrouters.get('/test', (req, res) => {
//     res.send("hello");
// });

// Testing SIGNUP
Authrouters.post('/signup', async(req,res) => {

try {
const {name, email, password} = req.body;

const existsUser = await User.findOne({ email });

if(existsUser) {
return res.status(400).json({msg: "User with this email has already exists."});
}

const hashedPassword = await bcryptjs.hash(password, 8);

let user = new User({
name,
email,
password: hashedPassword,
});

user = await user.save();
res.json(user);

}catch(e) {
console.log(e);
}
})


Authrouters.post('/signin', async (req,res) =>{
try{
  const {email, password} = req.body;
 const user = await User.findOne({email});
 
 if(!user) {
    return res.status(400).json({message: "User with this email doesn't exists."});
 }

 const isMatch = await bcryptjs.compare(password, user.password);

 if(!isMatch) {
    return res.status(400).json({message: "Incorrect Password"})
 }
 const token = jsonwebtoken.sign({id: user._id}, "passwordKey");
res.json({ token, ...user._doc});

}catch(e){
res.status(500).json({error: e.message})
}
});

module.exports = Authrouters; 