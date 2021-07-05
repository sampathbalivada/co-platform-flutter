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
  List<String> _COController = [];

  int _numberOfQuestions = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CO Question Mapping'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: buildCustomTextField(
                  _numberOfQuestionsController,
                  TextInputType.number,
                  'Number of Questions',
                  'Enter the number of questions', onChanged: (value) {
                setState(() {
                  int numberOfQuestions = int.parse(value);
                  _numberOfQuestions =
                      numberOfQuestions >= 12 ? 12 : numberOfQuestions;
                });
              }),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    'Question Number',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    'CO Assigned',
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Text(
                    'Question Number',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
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
                        ),
                      ),
                      SizedBox(width: 12),
                      DropdownButtonHideUnderline(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: MediaQuery.of(context).size.width * 0.25,
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: DropdownButton<String>(
                            value: _COController[index],
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),

                            items: <String>['1', '2', '3', '4']
                                .map<DropdownMenuItem<String>>((String value) {
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
            _numberOfQuestions == 0
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {},
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
      ),
    );
  }
}
