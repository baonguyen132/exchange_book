import 'package:flutter/material.dart';

DataColumn cellTitleTable(String title) {
  return DataColumn(
    label: Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

DataCell cellData(String data , Color color) {
  return DataCell(
    Text(
      data,
      style: TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
DataRow rowData(List<dynamic> data, Color color , int point) {
  return DataRow(
    cells: [
      cellData(data[0].toString() , color),
      cellData(data[1] , color),
      cellData(data[2] , color),
      cellData(point.toString() , color),

    ],
  );
}
