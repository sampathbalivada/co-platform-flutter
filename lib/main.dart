import 'package:co_attainment_platform/models/model.dart';
import 'package:co_attainment_platform/pages/add_course.dart';
import 'package:co_attainment_platform/pages/assign_co_threshold.dart';
import 'package:co_attainment_platform/pages/co_question_mapping.dart';
import 'package:co_attainment_platform/pages/upload_marks.dart';
import 'package:flutter/material.dart';

import 'pages/add_faculty_to_course.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/update_co_threshold.dart';

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
        "/": (context) => LoginPage(model: _model),
        "/home": (context) => HomePage(model: _model),
        "/upload_marks": (context) => UploadMarks(model: _model),
        "/calculate_statistics": (context) => UploadMarks(model: _model),
        "/add_course": (context) => AddCoursePage(model: _model),
        "/assign_co_threshold": (context) =>
            AssignCOThresholdPage(model: _model),
        "/check_statistics": (context) => UploadMarks(model: _model),
        "/add_faculty_to_course": (context) =>
            AddFacultyToCourse(model: _model),
        "/update_co_threshold": (context) =>
            UpdateCOThresholdPage(model: _model),
        "/co_question_mapping": (context) =>
            COQuestionMapping(model: _model),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}
