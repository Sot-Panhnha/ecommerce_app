const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
    username: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
                    /^\s*[\w\-\+_]+(\.[\w\-\+_]+)*\@[\w\-\+_]+\.[\w\-\+_]+(\.[\w\-\+_]+)*\s*$/;
                return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 6;
            },
            message: "Please enter a valid password",
        },
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String,
        default: "",
    },
});

const User = mongoose.model("user", userSchema);
module.exports = User;
