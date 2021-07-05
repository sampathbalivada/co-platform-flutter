import 'package:flutter/material.dart';

Widget buildCustomTextField(TextEditingController controller,
    TextInputType inputType, String label, String hintText,
    {bool obscureText = false, Function(String)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        hintText: "Enter " + label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: onChanged,
    ),
  );
}
