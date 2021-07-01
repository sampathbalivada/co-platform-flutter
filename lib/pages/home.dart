import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final model;

  HomePage({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(model.supabaseClient.auth.user().email),
    );
  }
}
