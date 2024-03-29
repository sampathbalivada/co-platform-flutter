import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, var model) {
  // set up the button
  Widget okButton = TextButton(
    style: TextButton.styleFrom(
      primary: Colors.red,
    ),
    child: Text("Logout"),
    onPressed: () {
      model.logout();
      Navigator.popUntil(context, ModalRoute.withName('/home'));
      Navigator.popAndPushNamed(context, '/');
    },
  );

  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logging Out"),
    content: Text("Are you sure you want to Logout of the application?"),
    actions: [
      okButton,
      cancelButton,
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
        Container(
          height: 36,
          padding: EdgeInsets.only(right: 16),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.scaleDown,
          ),
        ),
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
