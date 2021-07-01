import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final model;

  LoginPage({@required this.model});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailId = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vignan\'s Institute of Information Technology'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailId,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-Mail ID',
              ),
            ),
            TextField(
              controller: password,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () async {
                bool r = await widget.model.signIn(emailId.text, password.text);

                print(r);
              },
            ),
          ],
        ),
      ),
    );
  }
}
