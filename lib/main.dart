import 'package:ecommerce_app/features/admin/presentation/add_product_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/login_screen.dart';
import 'package:ecommerce_app/features/auth/provider/user_provider.dart';
import 'package:ecommerce_app/features/home/presentation/home_screen.dart';
import 'package:ecommerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/admin/presentation/admin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: (setting) => generateRoute(setting),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //   ? Provider.of<UserProvider>(context).user.type == 'user' ? const HomeScreen() : const AdminScreen()
      //   : const LoginScreen(),
      home: const AddProductsScreen(),
    );
  }
}
