import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, var model) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Log Out"),
    onPressed: () {
      model.logout();
      Navigator.popUntil(context, ModalRoute.withName('/home'));
      Navigator.popAndPushNamed(context, '/');
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logging Out"),
    content: Text("Are you sure you want to Logout of the application?"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

AppBar buildCustomAppBar(String title, var model, BuildContext context,
    {bool isLoginPage = false}) {
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
    actions: isLoginPage == false
        ? [
            Center(
              child: Text(
                model.emailId,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              color: Colors.black,
              onPressed: () {
                showAlertDialog(context, model);
              },
            ),
            SizedBox(
              width: 20,
            ),
          ]
        : [],
    iconTheme: IconThemeData(color: Colors.black),
  );
}
