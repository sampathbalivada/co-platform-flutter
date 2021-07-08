import 'package:co_attainment_platform/widgets/appbar.dart';
import 'package:flutter/material.dart';

class SelectMidAndCalculateStats extends StatefulWidget {
  final model;

  SelectMidAndCalculateStats({@required this.model});

  @override
  _SelectMidAndCalculateStatsState createState() =>
      _SelectMidAndCalculateStatsState();
}

class _SelectMidAndCalculateStatsState
    extends State<SelectMidAndCalculateStats> {
  String _mid = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar("Calculate Statistics"),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9a9a9a),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25, left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        'Select Mid Exam',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 24),
                    Container(
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF9A9A9A),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _mid,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),

                          items: <String>['1', '2']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text("Mid " + value),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _mid = value ?? '1';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.15,
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await widget.model.calculateStistics(_mid);

                      if (result) {
                        //Todo: Popup
                        print('Yes');
                      } else {
                        print('No');
                      }
                    },
                    child: Text(
                      'Calculate Statistics',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
