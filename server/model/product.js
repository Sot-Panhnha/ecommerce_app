const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
    name : {
        type : String,
        require : true,
        trim : true,
    },
    description : {
        type : String,
        require : true,
        trim : true,
    },
    categories : {
        type : String,
        require : true,
        trim : true,
    },
    images : [
        {
            type : String,
            require : true ,
        }
    ],
    quality : {
        type : Number,
        require : true,
    },
    price : {
        type : Number,
        require : true,
    }
})

const Product = mongoose.model("product", productSchema);
module.exports = Product;
