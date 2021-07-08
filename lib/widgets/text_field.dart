import 'package:flutter/material.dart';

Widget buildCustomTextField(TextEditingController controller,
    TextInputType inputType, String label, String hintText,
    {bool obscureText = false, Function(String)? onChanged}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 42,
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 8, right: 8),
          labelText: label,
          hintText: "Enter " + label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: onChanged,
      ),
    ),
  );
}
