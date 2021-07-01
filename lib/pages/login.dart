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
      appBar: AppBar(
        title: Text('Vignan\'s Institute of Information Technology'),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 240, right: 120),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Sign In'),
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
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        // bool r = await widget.model.signIn(
                        //   signInEmailId.text,
                        //   signInPassword.text,
                        // );

                        bool r = await widget.model.signIn(
                          'sri@sampath.dev',
                          'google',
                        );

                        if (r) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          showAlertDialog(
                            context,
                            'Login Error',
                            'Invalid email ID or password. If you just registered, make sure to verify your email.',
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 120, right: 240),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Register'),
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
                    ElevatedButton(
                      child: Text('Register'),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField buildCustomTextField(TextEditingController controller,
      TextInputType inputType, String hintText,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
