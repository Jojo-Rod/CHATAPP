import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.controller, required this.hintText, required this.obscureText});
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder:
              const OutlineInputBorder(borderSide: BorderSide(color:Color.fromARGB(255, 255, 255, 255))),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(47, 19, 209, 0))),
          fillColor: Colors.grey[100],
          filled: true,
          // hintText: hintText,
          hintText:hintText, 
          hintStyle: const TextStyle(fontSize: 18, color: Color.fromARGB(200, 158, 158, 158)),
          ),
    );
  }
}
