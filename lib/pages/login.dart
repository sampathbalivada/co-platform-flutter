import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final model;

  LoginPage({@required this.model});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              child: Padding(
                padding: const EdgeInsets.only(left: 60, right: 30),
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
                        bool r = await widget.model.signIn(
                          signInEmailId.text,
                          signInPassword.text,
                        );

                        if (r) {
                          // goto HomePage
                        } else {
                          // show Dialog box with reason for error
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 60),
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
                          // show Dialog Box to verify email
                        } else {
                          // show Dialog Box to contact admin at college
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
