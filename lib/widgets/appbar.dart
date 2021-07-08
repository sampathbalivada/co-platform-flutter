import 'package:flutter/material.dart';

AppBar buildCustomAppBar(String title) {
  return AppBar(
    elevation: 4,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
    ),
  );
}
