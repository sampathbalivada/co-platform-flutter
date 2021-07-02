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
      appBar: AppBar(
        title: Text('Vignan\'s Institute of Information Technology'),
      ),
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
                        "Perform a Task",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
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
                                    if (taskName == "Assign CO Threshold") {
                                      bool result = await widget.model
                                          .getAssignedCoursesForCoordinator();
                                      // print(result);
                                      if (result) {
                                        Navigator.pushNamed(
                                          context,
                                          "/" +
                                              taskName
                                                  .replaceAll(' ', '_')
                                                  .toLowerCase(),
                                        );
                                      } else {
                                        print("error");
                                      }
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        "/" +
                                            taskName
                                                .replaceAll(' ', '_')
                                                .toLowerCase(),
                                      );
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
                              itemCount: widget.model
                                  .tasks["${widget.model.roles[index]}"].length,
                            )
                          ],
                        );
                      },
                      itemCount: widget.model.roles.length,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
