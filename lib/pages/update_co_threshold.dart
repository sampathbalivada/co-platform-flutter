import 'package:flutter/material.dart';

class UpdateCOThresholdPage extends StatefulWidget {
  final model;

  UpdateCOThresholdPage({@required this.model});

  @override
  _UpdateCOThresholdPageState createState() => _UpdateCOThresholdPageState();
}

class _UpdateCOThresholdPageState extends State<UpdateCOThresholdPage> {
  String _mid = "1";
  TextEditingController _thresholdForCO1 = TextEditingController();
  TextEditingController _thresholdForCO2 = TextEditingController();
  TextEditingController _thresholdForCO3 = TextEditingController();
  TextEditingController _thresholdForCO4 = TextEditingController();

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
        title: Text(
          'Update CO Threshold > ' +
              widget.model.currentCourse.courseName +
              " (" +
              widget.model.currentCourse.courseCode +
              ")",
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Select Mid Exam:',
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: _mid,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),

                    items: <String>['1', '2']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a langauage",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _mid = value ?? '1';
                      });
                    },
                  ),
                ],
              ),
              buildCustomTextField(
                _thresholdForCO1,
                TextInputType.number,
                'CO1 Threshold',
                'Enter the threshold for CO1',
              ),
              buildCustomTextField(
                _thresholdForCO2,
                TextInputType.number,
                'CO2 Threshold',
                'Enter the threshold for CO2',
              ),
              buildCustomTextField(
                _thresholdForCO3,
                TextInputType.number,
                'CO3 Threshold',
                'Enter the threshold for CO3',
              ),
              buildCustomTextField(
                _thresholdForCO4,
                TextInputType.number,
                'CO4 Threshold',
                'Enter the threshold for CO4',
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    print('HI');
                    print(
                      _thresholdForCO1.text +
                          _thresholdForCO2.text +
                          _thresholdForCO3.text +
                          _thresholdForCO4.text,
                    );
                    var result = await widget.model.updateCOThreshold([
                      int.parse(_thresholdForCO1.text),
                      int.parse(_thresholdForCO2.text),
                      int.parse(_thresholdForCO3.text),
                      int.parse(_thresholdForCO4.text),
                    ], int.parse(_mid));

                    if (result) {
                      showAlertDialog(context, 'CO Threshold Updated',
                          'The CO Threshold for Mid $_mid of course ${widget.model.currentCourse.courseName} with course code ${widget.model.currentCourse.courseCode} have been updated.');
                    } else {
                      showAlertDialog(context, 'Threshold Update Error',
                          'Unable to update CO Threshold. Contact admin for further assistance.');
                    }

                    _thresholdForCO1.text = '';
                    _thresholdForCO2.text = '';
                    _thresholdForCO3.text = '';
                    _thresholdForCO4.text = '';
                    _mid = '1';
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Update Threshold',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomTextField(TextEditingController controller,
      TextInputType inputType, String label, String hintText,
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
