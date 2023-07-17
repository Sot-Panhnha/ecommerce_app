import 'dart:convert';

import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:ecommerce_app/constants/util.dart';
import 'package:ecommerce_app/features/model/User.dart';
import 'package:ecommerce_app/features/auth/provider/user_provider.dart';
import 'package:ecommerce_app/features/home/presentation/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  // user register account
  void signUpUser({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      User user = User(
        id: " ",
        name: username,
        email: email,
        password: password,
        address: " ",
        type: " ",
        token: "",
      );
      http.Response res = await http.post(
          Uri.parse('$uri/user/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type' : 'application/json , charset=UTF-8',
          }
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: (){
          showSnackBar(context, "Account Created!!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  // user login account
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: " ",
        name: " ",
        email: email,
        password: password,
        address: " ",
        type: " ",
        token: "",
      );
      http.Response res = await http.post(
          Uri.parse('$uri/user/signin'),
          body: jsonEncode({
            "email" : email,
            "password" : password,
          }),
          headers: <String, String>{
            'Content-Type' : 'application/json , charset=UTF-8',
          }
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await preferences.setString("x-auth-token", jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // collect data of user
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString("x-auth-token");

      if(token == null){
        preferences.setString("x-auth-token", " ");
      }

      var tokenResponse = await http.post(
          Uri.parse("$uri/tokenIsValid"),
          headers: <String , String>{
            'Content-Type' : 'application/json , charset=UTF-8',
            'token' : token!,
          }
      );
      var response = jsonDecode(tokenResponse.body);
      if(response == true){
        http.Response userResponse = await http.get(
            Uri.parse('$uri/'),
            headers: <String , String>{
              'Content-Type' : 'application/json , charset=UTF-8',
              'token' : token,
            }
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
