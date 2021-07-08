import 'package:co_attainment_platform/models/model.dart';
import 'package:co_attainment_platform/pages/add_course.dart';
import 'package:co_attainment_platform/pages/assign_co_threshold.dart';
import 'package:co_attainment_platform/pages/calculate_statistics.dart';
import 'package:co_attainment_platform/pages/check_statistics/check_statistics.dart';
import 'package:co_attainment_platform/pages/co_question_mapping.dart';
import 'package:co_attainment_platform/pages/select_course_for_statistics.dart';
import 'package:co_attainment_platform/pages/select_mid_and_calculate_stats.dart';
import 'package:co_attainment_platform/pages/check_statistics/select_mid_and_check_statistics.dart';
import 'package:co_attainment_platform/pages/show_statistics.dart';
import 'package:co_attainment_platform/pages/upload_marks.dart';
import 'package:co_attainment_platform/pages/upload_marks_select_file.dart';
import 'package:flutter/material.dart';

import 'pages/add_faculty_to_course.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/update_co_threshold.dart';

main() {
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
        "/calculate_statistics": (context) =>
            CalculateStatistics(model: _model),
        "/add_course": (context) => AddCoursePage(model: _model),
        "/assign_co_threshold": (context) =>
            AssignCOThresholdPage(model: _model),
        "/check_statistics": (context) => CheckStatistics(model: _model),
        "/add_faculty_to_course": (context) =>
            AddFacultyToCourse(model: _model),
        "/update_co_threshold": (context) =>
            UpdateCOThresholdPage(model: _model),
        "/co_question_mapping": (context) => COQuestionMapping(model: _model),
        "/upload_marks_select_file": (context) =>
            UploadMarksSelectFile(model: _model),
        "/select_mid_and_calculate_stats": (context) =>
            SelectMidAndCalculateStats(model: _model),
        "/select_course_for_statistics": (context) =>
            SelectCourseForStatistics(model: _model),
        "/select_mid_and_check_statistics": (context) =>
            SelectMidAndCheckStatistics(model: _model),
        "/show_statistics": (context) => ShowStatistics(model: _model),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}
