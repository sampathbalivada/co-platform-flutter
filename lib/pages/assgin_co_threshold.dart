import 'package:flutter/material.dart';

class AssignCOThresholdPage extends StatefulWidget {
  final model;
  AssignCOThresholdPage({@required this.model});

  @override
  _AssignCOThresholdPageState createState() => _AssignCOThresholdPageState();
}

class _AssignCOThresholdPageState extends State<AssignCOThresholdPage> {
  var yearDropDown = "1st Year";
  var subjDropDown = "Subj1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vignan's Institute of Information Technology"),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: yearDropDown,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                yearDropDown = newValue!;
              });
            },
            items: <String>['1st Year', '2nd Year', '3rd Year', '4th Year']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: subjDropDown,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            onChanged: (String? newValue) {
              setState(() {
                subjDropDown = newValue!;
              });
            },
            items: <String>['Subj1', 'Subj2', 'Subj3', 'Sub4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
