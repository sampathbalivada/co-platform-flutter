import 'package:co_attainment_platform/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:co_attainment_platform/models/model.dart';

class SelectCourseForStatistics extends StatefulWidget {
  final model;

  SelectCourseForStatistics({@required this.model});

  @override
  _SelectCourseForStatisticsState createState() =>
      _SelectCourseForStatisticsState();
}

class _SelectCourseForStatisticsState extends State<SelectCourseForStatistics> {
  List<Widget> generateExpansionTiles() {
    Map<String, List<Course>> coursesAssigned = widget.model.coursesAssigned;

    List<Widget> expansionTiles = [
      Text(
        "Select Course",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ];

    for (var batch in coursesAssigned.keys) {
      expansionTiles.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFF9A9A9A),
            ),
          ),
          child: ExpansionTile(
            title: Text(
              "Batch " + batch,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: coursesAssigned[batch]?.length,
                itemBuilder: (context, index) {
                  var course = coursesAssigned[batch]?[index];

                  return OutlinedButton(
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      widget.model.setCurrentCourse(course);
                      Navigator.pushNamed(
                        context,
                        '/select_mid_and_check_statistics',
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        course?.courseName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    return expansionTiles;
  }

  List<Widget> generateExpansionTileWidgets(List<Course>? courses) {
    List<Widget> expansionTileWidgets = [];

    for (var course in courses ?? []) {
      expansionTileWidgets.add(
        OutlinedButton(
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
          ),
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              course.courseName,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ),
      );
    }

    return expansionTileWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
          "Home > Common > Check Statistics > Select Course", widget.model, context),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: generateExpansionTiles(),
          ),
        ),
      ),
    );
  }
}
