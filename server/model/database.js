const mongoose = require("mongoose");

mongoose.connect(process.env.DB).then(()=>{console.log("Connected to MONGODB.")}).catch((e)=>{ console.log(`Failed to connect. Error print: ${e}`)});

const mongoSchema = mongoose.Schema(
{
    name:{
        required:true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
        const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
    
        return value.match(re);

    },
message: "Please enter valid email."        
        }
    },
   password: {
           required: true,
           type: String,
       },
}
)
const User = mongoose.model("users", mongoSchema, "users");
module.exports = User;