import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadMarks extends StatelessWidget {
  final model;

  UploadMarks({@required this.model});
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
                withData: true,
              );
              if (result != null) {
                PlatformFile file = result.files.single;
                print(file.name);
                print(file.bytes);
                print(file.path);
              } else {
                print("error");
              }
            },
            child: Text("Pick a File"),
          ),
        ],
      ),
    );
  }
}
