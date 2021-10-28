import 'package:delivery_app/models/cleaning.dart';
import 'package:delivery_app/widgets/customContainer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CleaningTableGridSource extends DataGridSource {
  CleaningTableGridSource(this.context,this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
 final List<Cleaning> productlist;
 final BuildContext context;
  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(
        cells: [
        DataGridCell<int>(columnName: 'orderID', value: dataGridRow.orderID),
        DataGridCell<String>(
            columnName: 'name', value: dataGridRow.name),
        DataGridCell<String>(
            columnName: 'email', value: dataGridRow.email),
        DataGridCell<String>(
            columnName: 'phone', value: dataGridRow.phone),
        DataGridCell<String>(columnName: 'address', value: dataGridRow.address),
         DataGridCell<String>(
            columnName: 'description', value: dataGridRow.description),
        DataGridCell<String>(columnName: 'orderDate', value: dataGridRow.orderDate),
        DataGridCell<String>(columnName: 'status', value: dataGridRow.status),
      ]);
    }).toList(growable: false);
  }
  
  @override
  List<DataGridRow> get rows => dataGridRows;
    @override
  Future<void> handleRefresh() async {
    await Future.delayed(Duration(seconds: 5));
    buildDataGridRow();
    notifyListeners();
  }
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: [
        for(int i = 0 ; i < 7 ; i++)
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[i].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      CustomContainer(
        header: row.getCells()[7].value.toString(),
        )
    ]);
  }
}