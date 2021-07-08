import 'package:co_attainment_platform/widgets/appbar.dart';
import 'package:flutter/material.dart';

import '../widgets/text_field.dart';

class COQuestionMapping extends StatefulWidget {
  final model;

  COQuestionMapping({@required this.model});

  @override
  _COQuestionMappingState createState() => _COQuestionMappingState();
}

class _COQuestionMappingState extends State<COQuestionMapping> {
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 12; i++) {
      _questionController.add(TextEditingController());
      _COController.add('1');
    }
  }

  TextEditingController _numberOfQuestionsController = TextEditingController();

  List<TextEditingController> _questionController = [];
  // ignore: non_constant_identifier_names
  List<String> _COController = [];

  int _numberOfQuestions = 0;

  String _mid = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar('CO Question Mapping'),
      body: Center(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: buildCustomTextField(
                      _numberOfQuestionsController,
                      TextInputType.number,
                      'Number of Questions',
                      'Enter the number of questions', onChanged: (value) {
                    setState(() {
                      int numberOfQuestions = 0;
                      if (value == "") {
                        numberOfQuestions = 0;
                      } else {
                        numberOfQuestions = int.parse(value);
                      }
                      _numberOfQuestions =
                          numberOfQuestions >= 12 ? 12 : numberOfQuestions;
                    });
                  }),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select Mid Exam',
                      style: TextStyle(fontSize: 18),
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
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 250.0, right: 175),
                  child: Divider(
                    color: Color(0xFF9A9A9A),
                    thickness: 1,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        'Question Number',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        'CO Assigned',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    SizedBox(width: 12),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Text(
                        'Max Marks for Question',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _numberOfQuestions,
                  itemBuilder: (context, index) {
                    return Align(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text(
                              'Question ${index + 1}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 12),
                          DropdownButtonHideUnderline(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF9A9A9A)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              child: DropdownButton<String>(
                                value: _COController[index],
                                //elevation: 5,
                                style: TextStyle(color: Colors.black),

                                items: <String>[
                                  '1',
                                  '2',
                                  '3',
                                  '4'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                        child: Text('Course Outcome ' + value)),
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
                                    _COController[index] = value ?? '1';
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: buildCustomTextField(
                                _questionController[index],
                                TextInputType.number,
                                'Question ${index + 1}',
                                'Enter Max Marks'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                _numberOfQuestions == 0
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            List<int> _coControl = [];
                            List<int> _marksControl = [];
                            for (int i = 0; i < _numberOfQuestions; i++) {
                              _marksControl
                                  .add(int.parse(_questionController[i].text));
                              _coControl.add(int.parse(_COController[i]));
                            }
                            widget.model.storeCOMapping(
                              _numberOfQuestions,
                              _coControl,
                              _marksControl,
                              int.parse(_mid),
                            );

                            Navigator.pushNamed(
                                context, "/update_co_threshold");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Map Questions to CO',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
