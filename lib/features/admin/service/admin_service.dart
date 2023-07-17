import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:ecommerce_app/constants/util.dart';
import 'package:ecommerce_app/features/auth/provider/user_provider.dart';
import 'package:ecommerce_app/features/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  void sellProduct({
    required BuildContext context,
    required String name,
    required double price,
    required double quantity,
    required String category,
    required String description,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('de6iujdzw', 'tyiurwis');
      List<String> imageUrl = [];

      for(int i = 0 ; i < images.length; i++){
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrl.add(res.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          category: category,
          price: price,
          quantity: quantity,
          images: imageUrl
      );
      http.Response response = await http.post(Uri.parse('$uri/admin/add-product'),
        headers: <String , String>{
          'Content-Type': 'application/json , charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product add SuccessFully !");
            Navigator.pop(context);
          }
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}