const express = require("express");
const User = require("../model/user");
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require("jsonwebtoken")
const auth = require("../middleware/auth");

authRouter.post("/api/signup", async (req, res) => {
    try {
        const {username, email, password} = req.body;
        const existUser = await User.findOne({email});
        if (existUser) {
            return res
                .status(400)
                .json({msg: "email already exist !!"});
        }
        const hashPassword = await bcryptjs.hash(password , 8);
        let user = new User({
            username,
            email,
            password : hashPassword,
        });
        user = await user.save();
        return res
            .status(200)
            .json(user);
    } catch (e) {
        res.status(500).json({error: e.message});
    }
});

authRouter.post("/api/signin", async (req, res) => {
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if (!user) {
            return res
                .status(400)
                .json({msg: "Account with this email does not exist !!"});
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res
                .status(400)
                .json({msg: "incorrect password"});
        }
        const  token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});
    }catch (e) {
        res.status(500).json({error: e.message})
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try{
        const  token = req.header("x-auth-token");
        if (!token) return res.json(false);
        const verified = jwt.verify(token, "passwordKey");
        if(!verified) return res.json(false);
        const  user = await  User.findById(verified.id);
        if(!user) return res.json(false);
        res.json(true);
    }catch (e) {
        res.status(500).json({error: e.message})
    }
})

authRouter.get('/', auth , async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
});

module.exports = authRouter;
