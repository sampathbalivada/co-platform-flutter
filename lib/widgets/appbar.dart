import 'package:flutter/material.dart';

AppBar buildCustomAppBar(String title, String email) {
  String left = '';
  String right = title;

  if (title.contains('>')) {
    var index = title.lastIndexOf('>');
    left = title.substring(0, index + 1);
    right = title.substring(index + 1);
  }

  return AppBar(
    elevation: 4,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          left,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 22,
          ),
        ),
        Text(
          right,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ],
    ),
    actions: [
      Center(
        child: Text(
          email,
          style: TextStyle(color: Colors.black),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      email != ""
          ? Icon(
              Icons.exit_to_app,
              color: Colors.black,
            )
          : SizedBox(),
      SizedBox(
        width: 20,
      ),
    ],
    iconTheme: IconThemeData(color: Colors.black),
  );
}
