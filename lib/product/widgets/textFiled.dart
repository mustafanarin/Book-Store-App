
import 'package:flutter/material.dart';

class TextFiledProject extends StatelessWidget {
  const TextFiledProject({
    super.key, required this.hintText, required this.controller,required this.validator, required this.keyboardType, this.obscure = false,
  });
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
     validator: validator,
     controller: controller,
     autovalidateMode: AutovalidateMode.onUserInteraction,
     keyboardType: keyboardType,
     decoration: InputDecoration(
       hintText: hintText,
     ),
     obscureText: obscure,
  );
  }
}