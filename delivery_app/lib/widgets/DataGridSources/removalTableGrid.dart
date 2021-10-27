import 'package:delivery_app/models/removal.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RemovalTableGridSource extends DataGridSource {
  RemovalTableGridSource(
    this.context,
    this.productlist
    ) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<int> rowIndex = [];
 final List<Removal> productlist;
 final BuildContext context;
  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(
        cells: [
        DataGridCell<int>(columnName: 'orderID', value: dataGridRow.orderID),
        DataGridCell<String>(
            columnName: 'ownerName', value: dataGridRow.ownerName),
        DataGridCell<String>(
            columnName: 'stockAddress', value: dataGridRow.stockAddress),
        DataGridCell<String>(
            columnName: 'deliveryAddress', value: dataGridRow.deliveryAddress),
        DataGridCell<String>(columnName: 'ownerEmail', value: dataGridRow.ownerEmail),
         DataGridCell<String>(
            columnName: 'ownerPhone', value: dataGridRow.ownerPhone),
        DataGridCell<String>(columnName: 'ServiceType', value: dataGridRow.serviceType),  
        DataGridCell<String>(columnName: 'description', value: dataGridRow.description),
        DataGridCell<String>(
            columnName: 'status', value: dataGridRow.status),
        DataGridCell<String>(columnName: 'orderdate', value: dataGridRow.orderDate),
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
        for(int i = 0 ; i < 6 ; i++)
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[i].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[6].value.toString().contains("home")
                  ? "Home" : 
                  row.getCells()[6].value.toString().contains("Local")
                  ? "Local" :
                  row.getCells()[6].value.toString().contains("Office")
                  ? "Office" :
                  "Interstate",
            overflow: TextOverflow.ellipsis,
          ),
          color: row.getCells()[6].value.toString().contains("home")
                  ? Colors.cyan : 
                  row.getCells()[6].value.toString().contains("Local")
                  ? Colors.orangeAccent :
                  row.getCells()[6].value.toString().contains("Office")
                  ? Colors.blue : 
                  Colors.pink,  
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8.0),
          color: row.getCells()[8].value.toString().contains('UNCONFIRMED') 
                  ? Colors.orange 
                  : row.getCells()[8].value.toString().contains('DELIVERED') ?
                  Colors.blue : Colors.green,
          child: Text(
           row.getCells()[8].value.toString().toLowerCase(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[9].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
       Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[7].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }
}