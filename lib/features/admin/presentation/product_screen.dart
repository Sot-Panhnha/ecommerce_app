import 'package:ecommerce_app/features/admin/presentation/add_product_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:const  SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { navigateToAddProduct(); },
        tooltip: 'Add a product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
