import 'package:flutter/material.dart';

class AddFacultyToCourse extends StatefulWidget {
  final model;
  AddFacultyToCourse({@required this.model});
  @override
  _AddFacultyToCourseState createState() => _AddFacultyToCourseState();
}

class _AddFacultyToCourseState extends State<AddFacultyToCourse> {
  bool _isloading = false;
  TextEditingController courseCode = TextEditingController();
  TextEditingController branchCode = TextEditingController();

  TextEditingController facultyEmail = TextEditingController();
  String yearSelected = "None";
  DateTime selectedYear = DateTime(2021);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home > HOD > Add Faculty to Course'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCustomTextField(
                  courseCode, TextInputType.text, "Course Code"),
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
              buildCustomTextField(
                  branchCode, TextInputType.emailAddress, "Branch Code"),
              buildCustomTextField(facultyEmail, TextInputType.emailAddress,
                  "Coordinator Email"),
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: _isloading
                      ? Center(child: CircularProgressIndicator())
                      : Text("Add Faculty to Course"),
                  onPressed: () async {
                    setState(() {
                      _isloading = true;
                    });
                    //add a function here
                    bool result = await widget.model.newFunction(
                        courseCode.text,
                        yearSelected,
                        facultyEmail.text,
                        int.parse(branchCode.text));
                    if (result) {
                      showAlertDialog(
                        context,
                        'Added Faculty',
                        'Sucessfully added ${facultyEmail.text} as faculty to the course ${courseCode.text} of batch $yearSelected and branch ${branchCode.text}',
                      );
                      setState(() {
                        courseCode.text = "";
                        facultyEmail.text = "";
                        yearSelected = "None";
                        _isloading = false;
                        branchCode.text = "";
                      });
                    } else {
                      setState(() {
                        courseCode.text = "";
                        facultyEmail.text = "";
                        yearSelected = "None";
                        _isloading = false;
                        branchCode.text = "";
                      });
                      print("Error");
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
