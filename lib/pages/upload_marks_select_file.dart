import 'package:co_attainment_platform/widgets/appbar.dart';
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

  showAlertDialog(BuildContext context, String title, String content) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.popUntil(context, ModalRoute.withName('/home'));
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar("Select File and Mid", widget.model, context),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xff9a9a9a),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, bottom: 25.0, left: 30, right: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        'Select Mid Exam',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 24),
                    Container(
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF9A9A9A),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _mid,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),

                          items: <String>['1', '2']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text("Mid " + value),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _mid = value ?? '1';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150,
                      child: Text(
                        'Select Section',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 24),
                    Container(
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF9A9A9A),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _section,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),

                          items: <String>['A', 'B', 'C', 'D']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text("Sec " + value),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _section = value ?? '1';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        withData: true,
                      );

                      var fileBytes = result?.files.single.bytes;

                      Iterable<int>? fileIntList = fileBytes?.toList();

                      bool status = await widget.model.uploadData(
                        String.fromCharCodes(fileIntList!),
                        _mid,
                        _section,
                      );

                      if (status) {
                        showAlertDialog(
                          context,
                          'Data Uploaded',
                          'The data for the given mid and section has been successfully updated.',
                        );
                      } else {
                        showAlertDialog(
                          context,
                          'Upload Error',
                          'Error encountered whil uploading data. Contact Administrator for help.',
                        );
                      }
                    },
                    icon: Icon(Icons.upload_file),
                    label: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text("Choose a File"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
