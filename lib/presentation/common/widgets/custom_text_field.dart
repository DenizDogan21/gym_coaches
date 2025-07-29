import 'package:flutter/material.dart';

/// CustomTextField widget, normal, password ve numeric tiplerde kullanılabilir.
/// Parametrelerle placeholder, controller ve validator eklenebilir.
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isNumeric;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isNumeric = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : keyboardType,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
