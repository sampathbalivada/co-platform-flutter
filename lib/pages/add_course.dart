import 'package:co_attainment_platform/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AddCoursePage extends StatefulWidget {
  final model;

  AddCoursePage({@required this.model});

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  bool _isloading = false;
  TextEditingController courseCode = TextEditingController();
  TextEditingController courseName = TextEditingController();
  TextEditingController branchCode = TextEditingController();

  TextEditingController coordinatorEmail = TextEditingController();
  String yearSelected = "None";
  DateTime selectedYear = DateTime(2021);
  showAlertDialog(BuildContext context, String title, String content,
      {bool error = false}) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        error
            ? Navigator.of(context).pop()
            : Navigator.popUntil(context, ModalRoute.withName('/home'));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildCustomAppBar('Home > HOD > Add Course', widget.model, context),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Add Course",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildCustomTextField(
                  branchCode, TextInputType.emailAddress, "Branch Code"),
              buildCustomTextField(
                  courseCode, TextInputType.text, "Course Code"),
              buildCustomTextField(
                  courseName, TextInputType.text, "Course Name"),
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              width: 100,
                              height: 200,
                              child: YearPicker(
                                  firstDate:
                                      DateTime(DateTime.now().year - 5, 1),
                                  lastDate:
                                      DateTime(DateTime.now().year + 5, 1),
                                  initialDate: DateTime.now(),
                                  selectedDate: selectedYear,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedYear = val;
                                      yearSelected = val.year.toString();
                                    });
                                    Navigator.pop(context);
                                  }),
                            ),
                          );
                        });
                  },
                  child: Text(
                    yearSelected == "None" ? "Select Batch" : yearSelected,
                  ),
                ),
              ),
              buildCustomTextField(coordinatorEmail, TextInputType.emailAddress,
                  "Coordinator Email"),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: _isloading
                      ? Center(child: CircularProgressIndicator())
                      : Text("Add Course"),
                  onPressed: () async {
                    bool errorStatus = false;
                    if (courseCode.text == "" ||
                        courseName.text == "" ||
                        coordinatorEmail.text == "" ||
                        yearSelected == "None" ||
                        branchCode.text == "") {
                      errorStatus = true;
                    }

                    if (errorStatus) {
                      showAlertDialog(
                        context,
                        'Input Error',
                        'Missing Value Error: One or more of the values are missing. All values are required to add a course.',
                        error: true,
                      );
                    } else {
                      setState(() {
                        _isloading = true;
                      });
                      bool result = await widget.model.addCourse(
                          courseCode.text,
                          yearSelected,
                          courseName.text,
                          coordinatorEmail.text,
                          int.parse(branchCode.text));
                      if (result) {
                        showAlertDialog(
                          context,
                          'Course Added',
                          'The course ${courseName.text} with ${courseCode.text} for the batch $yearSelected is successfully added.',
                        );
                      } else {
                        print("Error");
                      }
                      setState(() {
                        courseCode.text = "";
                        courseName.text = "";
                        coordinatorEmail.text = "";
                        yearSelected = "None";
                        _isloading = false;
                        branchCode.text = "";
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomTextField(
      TextEditingController controller, TextInputType inputType, String label,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          hintText: "Enter " + label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
