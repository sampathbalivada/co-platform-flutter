import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckStatistics extends StatefulWidget {
  final model;
  CheckStatistics({@required this.model});

  @override
  _CheckStatisticsState createState() => _CheckStatisticsState();
}

class _CheckStatisticsState extends State<CheckStatistics> {
  int _selectedBranch = 0;
  @override
  void initState() {
    print(widget.model.branchCodes);
    _selectedBranch = widget.model.branchCodes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Statistics"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  width: MediaQuery.of(context).size.width * 0.25,
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: DropdownButton<int>(
                    value: _selectedBranch,
                    //elevation: 5,
                    style: TextStyle(color: Colors.black),

                    items: widget.model.branchCodes
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Container(child: Text('Branch Code $value')),
                      );
                    }).toList(),

                    onChanged: (int? value) {
                      setState(() {
                        _selectedBranch = value ?? widget.model.branchCodes[0];
                      });
                    },
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () async {
                    widget.model.setBranchCode(_selectedBranch);
                    bool result = await widget.model.getAllCoursesForBranch();

                    if (result) {
                      Navigator.pushNamed(
                          context, "/select_course_for_statistics");
                    } else {
                      print('Error');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select Course and Mid',
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
}
