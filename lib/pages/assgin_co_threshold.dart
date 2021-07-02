import 'package:co_attainment_platform/models/model.dart';
import 'package:flutter/material.dart';

class AssignCOThresholdPage extends StatefulWidget {
  final model;

  AssignCOThresholdPage({this.model});

  @override
  _AssignCOThresholdPageState createState() => _AssignCOThresholdPageState();
}

class _AssignCOThresholdPageState extends State<AssignCOThresholdPage> {
  List<Widget> generateExpansionTiles() {
    Map<String, List<Course>> coursesAssigned = widget.model.coursesAssigned;

    List<Widget> expansionTiles = [];

    for (var batch in coursesAssigned.keys) {
      expansionTiles.add(
        ExpansionTile(
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
                      '/update_co_threshold',
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
      appBar: AppBar(
        title: Text('Home > Course Coordinator > Assign CO Threshold'),
      ),
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
