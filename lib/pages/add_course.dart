import 'package:flutter/material.dart';

class AddCoursePage extends StatelessWidget {
  final model;

  AddCoursePage({@required this.model});

  @override
  Widget build(BuildContext context) {
    TextEditingController courseCode = TextEditingController();
    TextEditingController courseName = TextEditingController();
    TextEditingController batch = TextEditingController();
    TextEditingController coordinatorEmail = TextEditingController();
    var selectedYear = DateTime(2021);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home > HOD > Add Course'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCustomTextField(
                  courseCode, TextInputType.number, "Course Code"),
              buildCustomTextField(
                  courseName, TextInputType.text, "Course Name"),
              ElevatedButton(
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
                                    selectedYear = val;
                                    Navigator.pop(context);
                                  }),
                            ),
                          );
                        });
                  },
                  child: Text("Select Batch")),
              buildCustomTextField(coordinatorEmail, TextInputType.emailAddress,
                  "Coordinator Email"),
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
