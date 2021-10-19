import 'package:delivery_app/providers/OrderProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../models/order.dart';

class OrderTableGrid extends StatefulWidget {
  @override
  _OrderTableGridState createState() => _OrderTableGridState();
}

class _OrderTableGridState extends State<OrderTableGrid> {
  late _OrderTableGridSource jsonDataGridSource ;
  late OrderProvider orderProvider;
 Future<List<Order>>? productlist;
 @override
  void initState() {
    super.initState();
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    productlist = orderProvider.fetchAllOrders();
  }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        allowSorting: true,
        columnName: 'orderID',
        width: 70,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Order ID',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'ownerName',
        width: 65,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Name',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'stockAddress',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Stock Address',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'deliveryAddress',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Delivery Address',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'ownerEmail',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Owner Email',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        allowSorting: true,
        columnName: 'ownerPhone',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Phone No',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'status',
        width: 95,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Status',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'orderDate',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Order Date',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'actions',
        width: 170,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Actions',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      )
    ]);
    return columns;
  }


  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
            child: FutureBuilder(
                future: productlist,
                builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
                   if(snapshot.hasData)
                   {
                      return SfDataGrid(
                          source: jsonDataGridSource, 
                          columns: getColumns(),
                          allowSorting: true,
                          allowMultiColumnSorting: true,
                          );
                   } 
                  return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        );
                })),
      ),
    );
  }
}



class _OrderTableGridSource extends DataGridSource {
  _OrderTableGridSource(this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<Order> productlist = [];

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
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
        DataGridCell(columnName: 'actions', value: "")
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
         row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[5].value.toString(),
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
        child: Row(
          children: [
            IconButton(
              onPressed: (){

              }, 
              icon: Icon(
                Icons.zoom_in,
                color: Colors.blue,
                )
              ),
            if(row.getCells()[6].value.toString().contains('UNCONFIRMED'))
            IconButton(
              onPressed: (){
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
              onPressed: (){
              }, 
              icon: Icon(
                Icons.check_circle,
                color: Colors.blue,
                )
              ),
              if(
              row.getCells()[6].value.toString().contains('ED'))
            IconButton(
              onPressed: (){
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