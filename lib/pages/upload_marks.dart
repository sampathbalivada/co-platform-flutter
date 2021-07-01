import 'package:flutter/material.dart';

class UploadMarks extends StatelessWidget {
  final model;

  UploadMarks({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Marks'),
      ),
    );
  }
}
