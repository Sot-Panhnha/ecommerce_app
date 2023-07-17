const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin')
const Product = require("../model/product");


adminRouter.post('/admin/add-product', admin, async (req, res ) => {
    try {
        const { name, category, description, price, quantity, images } = req.body;
        let product = new Product({
            name,
            description,
            category,
            price,
            quantity,
            images,
        });
        product = await product.save();
        res.json(product);
    } catch (e) {
        res
            .status(500)
            .json({error: e.toString()})
    }
});

module.exports = adminRouter;