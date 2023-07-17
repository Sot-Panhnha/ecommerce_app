import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_app/common/widgets/custom_button.dart';
import 'package:ecommerce_app/common/widgets/custom_textField.dart';
import 'package:ecommerce_app/constants/util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/features/admin/service/admin_service.dart';
import 'package:flutter/material.dart';

class AddProductsScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {

  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  final AdminService adminService = AdminService();

  String category = 'Fashion';
  List<File> images = [];
  final _addProductsFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController .dispose();
  }
  List<String> productCategories = [
    'Electronics',
    'Fashion',
    'Book',
    'Gaming',
    'Pet',
  ];

  void selectImage() async {
    var res = await pickImage();
    setState(() {
      images = res;
    });
  }

  void sellProducts() {
    if( _addProductsFormKey.currentState!.validate() && images.isNotEmpty ){
      adminService.sellProduct(
        context: context,
        name: productNameController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        description: descriptionController.text,
        images: images,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              );
            },
          ),
          title: const Text('Add Product'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _addProductsFormKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(

                      children: [
                        images.isNotEmpty ? CarouselSlider(
                          items: images.map((i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            );
                          },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 150,
                          ),
                        ) :
                        GestureDetector(
                          onTap: selectImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10,  4],
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.drive_folder_upload_outlined,size: 40, color: Colors.grey.withOpacity(0.7),),
                                  const SizedBox(height: 10,),
                                  Text("Select Products Image",style: TextStyle(fontSize: 15, color: Colors.grey.withOpacity(0.7)),),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        CustomTextField(
                          controller: productNameController,
                          hintText: 'Product Name',
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Category", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 10,),
                            SizedBox(
                              child: DropdownButton(
                                value: category,
                                icon: const Icon(Icons.arrow_drop_down_sharp),
                                items: productCategories.map((String item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    category = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          controller: priceController,
                          hintText: 'Product Price',
                        ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          controller: quantityController,
                          hintText: 'Product Quantity',
                        ),
                        const SizedBox(height: 10,),
                        CustomTextField(
                          maxLine: 7,
                          controller: descriptionController,
                          hintText: 'Product Description',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            CustomButton(text: 'Sell', onPressed: (){})
          ],
        )
    );
  }
}
