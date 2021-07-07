import 'package:flutter/material.dart';

class SelectMidAndCheckStatistics extends StatefulWidget {
  final model;

  SelectMidAndCheckStatistics({@required this.model});

  @override
  _SelectMidAndCheckStatisticsState createState() =>
      _SelectMidAndCheckStatisticsState();
}

class _SelectMidAndCheckStatisticsState
    extends State<SelectMidAndCheckStatistics> {
  String _mid = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Mid Exam:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 24),
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
                onChanged: (String? value) {
                  setState(() {
                    _mid = value ?? '1';
                  });
                },
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () async {
                final result = await widget.model.calculateStistics(_mid);

                if (result) {
                  print('Yes');
                } else {
                  print('No');
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Check Statistics for Selected Course and Mid',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
