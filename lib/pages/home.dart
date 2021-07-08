import 'package:co_attainment_platform/widgets/appbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final model;

  HomePage({@required this.model});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildCustomAppBar('Vignan\'s Institute of Information Technology'),
      body: Center(
        child: _isloading
            ? CircularProgressIndicator()
            : Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Available Tasks",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF9A9A9A)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ExpansionTile(
                            title: Text(
                              widget.model.roles[index],
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                itemBuilder:
                                    (BuildContext context, int taskIndex) {
                                  var taskName = widget.model
                                          .tasks["${widget.model.roles[index]}"]
                                      [taskIndex];

                                  return OutlinedButton(
                                    style: ButtonStyle(
                                      alignment: Alignment.centerLeft,
                                    ),
                                    onPressed: () async {
                                      bool result = false;

                                      if (taskName == "Assign CO Threshold") {
                                        result = await widget.model
                                            .getAssignedCoursesForCoordinator();
                                      } else if (taskName == "Upload Marks") {
                                        result = await widget.model
                                            .getAssignedCoursesForFaculty();
                                      } else if (taskName ==
                                          "Calculate Statistics") {
                                        result = await widget.model
                                            .getAssignedCoursesForHOD();
                                      } else if (taskName ==
                                          "Check Statistics") {
                                        result = await widget.model
                                            .getAvailableBranchCodes();
                                      }
                                      if (result) {
                                        Navigator.pushNamed(
                                          context,
                                          "/" +
                                              taskName
                                                  .replaceAll(' ', '_')
                                                  .toLowerCase(),
                                        );
                                      } else {
                                        print('error');
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        taskName,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: widget
                                    .model
                                    .tasks["${widget.model.roles[index]}"]
                                    .length,
                              )
                            ],
                          );
                        },
                        itemCount: widget.model.roles.length,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
