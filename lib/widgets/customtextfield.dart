import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  customtextfield(
      {super.key,
      required this.controller,
      required this.hinttxt,
      this.hintcolor,
      this.obscureText = true,
      this.prefix,
      this.suffici,
      required this.command,
      required this.command2});

  final TextEditingController controller;
  final String hinttxt;
  Icon? prefix;
  IconButton? suffici;
  final String command;
  final String command2;
  Color? hintcolor;
  bool obscureText;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return command;
          } else if (value.length < 5) {
            return command2;
          }
          return null;
        },
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffici,
          hintText: hinttxt,
          hintStyle: TextStyle(color: hintcolor),
        ));
  }
}
