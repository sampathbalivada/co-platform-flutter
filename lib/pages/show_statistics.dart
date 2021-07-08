import 'package:co_attainment_platform/widgets/appbar.dart';
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
          buildCustomCell('SEC - A', isHead: true),
          buildCustomCell(''),
          buildCustomCell('SEC - B', isHead: true),
          buildCustomCell(''),
          buildCustomCell('SEC - C', isHead: true),
          buildCustomCell(''),
          buildCustomCell('SEC - D', isHead: true),
          buildCustomCell(''),
          buildCustomCell('Total', isHead: true),
          buildCustomCell(''),
        ],
      ),
      TableRow(
        children: [
          buildCustomCell('Course Outcomes', isHead: true),
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

      rowChildren.add(buildCustomCell('CO ${i + 1}', isHead: true));

      var sections = ['A', 'B', 'C', 'D', 'total'];

      for (var section in sections) {
        data[section]![len - 1] == 0
            ? addDataToRow(rowChildren)
            : addDataToRow(
                rowChildren,
                A: data[section]![i].toString(),
                NA: (100 - data[section]![i]).toString(),
              );
      }

      rows.add(TableRow(
        children: rowChildren,
      ));
    }
  }

  // ignore: non_constant_identifier_names
  void addDataToRow(List<TableCell> children,
      {String A = '-', String NA = '-'}) {
    children.add(buildCustomCell(A));
    children.add(buildCustomCell(NA));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
          'Statistics for ' +
              model.currentCourse.courseName +
              ' - ' +
              model.currentCourse.courseCode +
              ' - Mid ' +
              model.midSelected,
          model.emailId),
      //  AppBar(
      //   title: Text(
      //     'Statistics for ' +
      //         model.currentCourse.courseName +
      //         ' - ' +
      //         model.currentCourse.courseCode +
      //         ' - Mid ' +
      //         model.midSelected,
      //   ),
      // ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(color: Colors.grey),
            children: rows,
          ),
        ),
      ),
    );
  }

  TableCell buildCustomCell(String data, {bool isHead = false}) {
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
              color: isHead ? Colors.blue : Colors.black),
        ),
      ),
    );
  }
}
