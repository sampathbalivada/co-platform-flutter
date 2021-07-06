import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadMarks extends StatefulWidget {
  final model;

  UploadMarks({@required this.model});

  @override
  _UploadMarksState createState() => _UploadMarksState();
}

class _UploadMarksState extends State<UploadMarks> {
  var path = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home > Upload Marks'),
      ),
      body: Column(
        children: [
          OutlinedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                withData: true,
              );

              var fileBytes = result?.files.single.bytes;

              Iterable<int>? fileIntList = fileBytes?.toList();

              print(String.fromCharCodes(fileIntList!));
            },
            child: Text("Pick a File"),
          ),
        ],
      ),
    );
  }
}
