import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadMarksSelectFile extends StatefulWidget {
  final model;

  UploadMarksSelectFile({@required this.model});

  @override
  _UploadMarksSelectFileState createState() => _UploadMarksSelectFileState();
}

class _UploadMarksSelectFileState extends State<UploadMarksSelectFile> {
  String _mid = '1';
  String _section = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select File'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('Mid'),
                DropdownButton<String>(
                  value: _mid,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),

                  items: <String>['1', '2']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _mid = value ?? '1';
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Section'),
                DropdownButton<String>(
                  value: _section,
                  //elevation: 5,
                  style: TextStyle(color: Colors.black),

                  items: <String>['A', 'B', 'C', 'D']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _section = value ?? 'A';
                    });
                  },
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  withData: true,
                );

                var fileBytes = result?.files.single.bytes;

                Iterable<int>? fileIntList = fileBytes?.toList();

                widget.model.uploadData(
                  String.fromCharCodes(fileIntList!),
                  _mid,
                  _section,
                );
              },
              child: Text("Pick a File"),
            ),
          ],
        ),
      ),
    );
  }
}
