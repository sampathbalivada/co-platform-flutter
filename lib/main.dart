import 'package:co_attainment_platform/models/model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'pages/login.dart';

main(List<String> args) {
  COPlatform _model = COPlatform();

  runApp(MainApp(_model));
}

class MainApp extends StatelessWidget {
  final _model;

  MainApp(this._model);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login": (context) => LoginPage(model: _model),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
    );
  }
}
