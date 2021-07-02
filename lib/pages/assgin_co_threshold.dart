import 'package:flutter/material.dart';

class AssignCOThresholdPage extends StatefulWidget {
  final model;
  AssignCOThresholdPage({@required this.model});

  @override
  _AssignCOThresholdPageState createState() => _AssignCOThresholdPageState();
}

class _AssignCOThresholdPageState extends State<AssignCOThresholdPage> {
  String yearDropDown = "";
  var subjDropDown = "Subj1";
  List<String> years = [];
  @override
  void initState() {
    years = widget.model.coursesAssigned.keys.toList();
    for (var i = 0; i < years.length; i++) {
      years[i] = years[i] + " year";
    }
    yearDropDown = years[0];
    super.initState();
  }

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
            items: years.map<DropdownMenuItem<String>>((String value) {
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
