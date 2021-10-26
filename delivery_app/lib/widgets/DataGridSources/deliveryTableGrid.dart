import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/widgets/alertbox.dart';
import 'package:delivery_app/widgets/showAll.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DeliveryTableGridSource extends DataGridSource {
  DeliveryTableGridSource(this.context,this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<int> rowIndex = [];
 final List<Delivery> productlist;
 final BuildContext context;
  void buildDataGridRow() {
   int getIndex(int? id)
    {
      int i;
      for(i= 0; i<productlist.length ;i++)
      {
        Delivery order = productlist[i];
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
        DataGridCell<String>(
            columnName: 'status', value: dataGridRow.status),
        DataGridCell<String>(columnName: 'orderdate', value: dataGridRow.orderDate),
        DataGridCell<String>(columnName: 'description', value: dataGridRow.description),
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
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        color: row.getCells()[6].value.toString().contains('UNCONFIRMED') 
                ? Colors.orange 
                : row.getCells()[6].value.toString().contains('DELIVERED') ?
                Colors.blue : Colors.green,
        child: Text(
         row.getCells()[6].value.toString(),
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
        child: Text(
          row.getCells()[8].value.toString(),
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
                   builder: (_) => ShowAll(
                     order: productlist[row.getCells()[9].value]
                     )
                   );
              }, 
              icon: Icon(
                Icons.zoom_in,
                color: Colors.blue,
                )
              ),
            if(row.getCells()[6].value.toString().contains('UNCONFIRMED'))
            IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                   builder: (_) => AlertBox(
                     header: 'confirmed', 
                      onpress: (){
                       orderProvider!.changeStatusToConfirm(productlist[row.getCells()[9].value]);
                       print(row.getCells()[9].value);
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
              row.getCells()[6].value.toString().contains('CONFIRMED') 
              &&  row.getCells()[6].value.toString().length<10)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                   builder: (_) => AlertBox(
                     header: 'delivered', 
                     onpress: () async{
                       orderProvider!
                       .changeStatusToDelivered(productlist[row.getCells()[9].value]);
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
              row.getCells()[6].value.toString().contains('ED'))
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                   builder: (_) => AlertBox(
                     header: 'deleted', 
                     onpress: () async{
                      orderProvider!
                       .deleteSpecificDelivery(productlist[row.getCells()[9].value]);
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