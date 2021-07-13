import 'package:co_attainment_platform/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final model;

  LoginPage({@required this.model});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  showAlertDialog(BuildContext context, String title, String content) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
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

  TextEditingController signInEmailId = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  TextEditingController signUpEmailId = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        'Vignan\'s Institute of Information Technology',
        widget.model,
        context,
        isLoginPage: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            // colors: [
            //   Color(0xbff00acee),
            //   Color(0xbff00acee),
            //   Color(0xbffb200f0),
            //   // Color(0xbff50c878),
            //   Color(0xbff50c878),
            // ],
            colors: [
              Color(0xbff4158D0),
              // Color(0xbff00acee),
              Color(0xbffC850C0),
              // Color(0xbff50c878),
              Color(0xbffFFCC70),
            ],
          ),
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 240, right: 120),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          // color: Colors.white,
                          height: 500,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 100)),
                              Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 40),
                              buildCustomTextField(
                                signInEmailId,
                                TextInputType.emailAddress,
                                'Email-ID',
                              ),
                              buildCustomTextField(
                                signInPassword,
                                TextInputType.visiblePassword,
                                'Password',
                                obscureText: true,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 75,
                                  right: 75,
                                  top: 50,
                                  bottom: 8,
                                ),
                                width: MediaQuery.of(context).size.width,
                                // height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Color(0xbff4158D0),
                                          Color(0xbff4158D0),
                                          Color(0xbffC850C0),
                                          // Color(0xbff50c878),
                                          // Color(0xbff50c878),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      width: 300,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    // bool r = await widget.model.signIn(
                                    //   signInEmailId.text,
                                    //   signInPassword.text,
                                    // );

                                    // debug
                                    bool r = await widget.model.signIn(
                                      'sri@sampath.dev',
                                      'google',
                                    );

                                    if (r) {
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    } else {
                                      showAlertDialog(
                                        context,
                                        'Login Error',
                                        'Invalid email ID or password. If you just registered, make sure to verify your email.',
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 250, bottom: 250),
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 120, right: 240),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 500,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 100)),
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 40),
                            buildCustomTextField(
                              signUpEmailId,
                              TextInputType.emailAddress,
                              'Email-ID',
                            ),
                            buildCustomTextField(
                              signUpPassword,
                              TextInputType.visiblePassword,
                              'Password',
                              obscureText: true,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 75,
                                right: 75,
                                top: 50,
                                bottom: 8,
                              ),
                              width: MediaQuery.of(context).size.width,
                              // height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        // Color(0xbff00acee),
                                        // Color(0xbff00acee),
                                        Color(0xbffC850C0),
                                        Color(0xbffC850C0),
                                        Color(0xbffFFCC70),
                                        // Color(0xbff50c878),
                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    width: 300,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Register',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  bool r = await widget.model.signUp(
                                    signUpEmailId.text,
                                    signUpPassword.text,
                                  );

                                  if (r) {
                                    showAlertDialog(
                                      context,
                                      'Registered Successfully',
                                      'Check your inbox at ' +
                                          signUpEmailId.text +
                                          ' and verify your email using the link provided.',
                                    );
                                  } else {
                                    showAlertDialog(
                                      context,
                                      'Registration Error',
                                      'Check your email and password. If problem persists, contact admin at college',
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomTextField(TextEditingController controller,
      TextInputType inputType, String hintText,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(left: 75, right: 75, top: 8, bottom: 8),
      child: Container(
        height: 42,
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 8, right: 8),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
