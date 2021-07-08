import 'package:co_attainment_platform/widgets/appbar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        "Home > Common > Check Statistics > Select Course > Select Mid",
        widget.model,
        context,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Select Mid",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF9A9A9A)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: Text("${widget.model.currentCourse.courseName}"),
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: OutlinedButton(
                      onPressed: () async {
                        final result =
                            await widget.model.getDataForStatistics("1");

                        if (result) {
                          Navigator.pushNamed(context, '/show_statistics');
                        } else {
                          print('No');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Mid 1",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: OutlinedButton(
                      onPressed: () async {
                        final result =
                            await widget.model.getDataForStatistics("2");

                        if (result) {
                          Navigator.pushNamed(context, '/show_statistics');
                        } else {
                          print('No');
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Mid 2",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
