import 'package:delivery_app/models/removal.dart';
import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/widgets/alertbox.dart';
import 'package:delivery_app/widgets/showRemoval.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RemovalTableGridSource extends DataGridSource {
  RemovalTableGridSource(this.context,this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<int> rowIndex = [];
 final List<Removal> productlist;
 final BuildContext context;
  void buildDataGridRow() {
   int getIndex(int? id)
    {
      int i;
      for(i= 0; i<productlist.length ;i++)
      {
        Removal order = productlist[i];
        if(id == order.orderID)
        {
          break;  
        }
      }
      return i;
    }
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
        
        DataGridCell<int>(columnName: 'actions', value: getIndex(dataGridRow.orderID))
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
              //  decoration: BoxDecoration(
              //    border: Border.all(color: Colors.white),
              //    borderRadius: BorderRadius.circular(5.0)
              //    ),   
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
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                   builder: (_) => ShowRemoval(
                     order: productlist[row.getCells()[10].value]
                     )
                   );
              }, 
              icon: Icon(
                Icons.zoom_in,
                color: Colors.blue,
                )
              ),
            if(row.getCells()[8].value.toString().contains('UNCONFIRMED'))
            IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                   builder: (_) => AlertBox(
                     header: 'confirmed', 
                      onpress: (){
                       removalProvider!
                       .changeStatusToConfirm(
                         productlist[row.getCells()[10].value]);
                       print(row.getCells()[10].value);
                       Navigator.of(context).pop();
                      }
                     )
                   ); 
              }, 
              icon: Icon(
                Icons.local_shipping,
                color: Colors.grey,
                )
              ),
            if(
              row.getCells()[8].value.toString().contains('CONFIRMED') 
              &&  row.getCells()[8].value.toString().length<10)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                   builder: (_) => AlertBox(
                     header: 'delivered', 
                     onpress: () async{
                       removalProvider!
                       .changeStatusToDelivered(
                         productlist[row.getCells()[10].value]);
                       buildDataGridRow();
                       Navigator.of(context).pop();
                      }
                     )
                   );
              }, 
              icon: Icon(
                Icons.check_circle,
                color: Colors.blue,
                )
              ),
              if(
              row.getCells()[8].value.toString().contains('ED'))
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                   builder: (_) => AlertBox(
                     header: 'deleted', 
                     onpress: () async{
                      removalProvider!
                       .deleteSpecificRemoval(
                         productlist[row.getCells()[10].value]);
                       Navigator.of(context).pop();
                      }
                     )
                   );
              }, 
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                )
              ),
          ],
        )
      )
    ]);
  }
}