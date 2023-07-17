import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLine;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLine = 1,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.7),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.7),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      maxLines: maxLine,
      validator: (val) {
        if(val == null || val.isEmpty ){
          return hintText;
        }else{
          return null;
        }
      },
    );
  }
}
