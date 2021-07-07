import 'package:flutter/material.dart';

class ShowStatistics extends StatelessWidget {
  final model;

  List<TableRow> rows = [];

  Map<String, List<double>> data = {};

  ShowStatistics({@required this.model}) {
    rows = [
      TableRow(
        children: [
          buildCustomCell(''),
          buildCustomCell('SEC - A'),
          buildCustomCell(''),
          buildCustomCell('SEC - B'),
          buildCustomCell(''),
          buildCustomCell('SEC - C'),
          buildCustomCell(''),
          buildCustomCell('SEC - D'),
          buildCustomCell(''),
          buildCustomCell('Total'),
          buildCustomCell(''),
        ],
      ),
      TableRow(
        children: [
          buildCustomCell('Course Outcomes'),
          buildCustomCell('A (%)'),
          buildCustomCell('NA (%)'),
          buildCustomCell('A (%)'),
          buildCustomCell('NA (%)'),
          buildCustomCell('A (%)'),
          buildCustomCell('NA (%)'),
          buildCustomCell('A (%)'),
          buildCustomCell('NA (%)'),
          buildCustomCell('A (%)'),
          buildCustomCell('NA (%)'),
        ],
      ),
    ];

    data = model.statistics;
    var len = data['total']!.length;
    for (int i = 0; i < len - 1; ++i) {
      List<TableCell> rowChildren = [];

      rowChildren.add(buildCustomCell('CO ${i + 1}'));

      rowChildren.add(buildCustomCell(data['A']![i].toString()));
      rowChildren.add(buildCustomCell((100 - data['A']![i]).toString()));
      rowChildren.add(buildCustomCell(data['B']![i].toString()));
      rowChildren.add(buildCustomCell((100 - data['B']![i]).toString()));
      rowChildren.add(buildCustomCell(data['C']![i].toString()));
      rowChildren.add(buildCustomCell((100 - data['C']![i]).toString()));
      rowChildren.add(buildCustomCell(data['D']![i].toString()));
      rowChildren.add(buildCustomCell((100 - data['D']![i]).toString()));
      rowChildren.add(buildCustomCell(data['total']![i].toString()));
      rowChildren.add(buildCustomCell((100 - data['total']![i]).toString()));

      rows.add(TableRow(
        children: rowChildren,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics for ' +
              model.currentCourse.courseName +
              ' - ' +
              model.currentCourse.courseCode +
              ' - Mid ' +
              model.midSelected,
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(),
            children: rows,
          ),
        ),
      ),
    );
  }

  TableCell buildCustomCell(String data) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
