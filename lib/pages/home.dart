import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final model;

  HomePage({@required this.model});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String show = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vignan\'s Institute of Information Technology'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Perform a Task"),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text(widget.model.roles[index]),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int taskIndex) {
                        return Text(widget.model
                            .tasks["${widget.model.roles[index]}"][taskIndex]);
                      },
                      itemCount: widget
                          .model.tasks["${widget.model.roles[index]}"].length,
                    )
                  ],
                );
              },
              itemCount: widget.model.roles.length,
            )
          ],
        ),
      ),
    );
  }
}
