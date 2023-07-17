const express = require("express");
const mongoose = require("mongoose");

const app = express();
const PORT = 3000;
const DB =
    "mongodb+srv://sotpanhnha:Nha1234567890@cluster0.o3rht72.mongodb.net/?retryWrites=true&w=majority";

const authRouter = require("./routers/auth");
const adminRouter =  require("./routers/admin");

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);

mongoose.connect(DB)
    .then(() => {
        console.log("connecte succusful");
    })
    .catch((e) => {
        console.log(e);
    });

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected to port ${PORT}`);
});
