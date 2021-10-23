import 'package:delivery_app/providers/OrderProvider.dart';
import 'package:delivery_app/widgets/alertbox.dart';
import 'package:delivery_app/widgets/showAll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../models/order.dart';
import 'package:flutter/services.dart';

class OrderTableGrid extends StatefulWidget {
  @override
  _OrderTableGridState createState() => _OrderTableGridState();
  
}

class _OrderTableGridState extends State<OrderTableGrid> {
  final DataGridController _dataGridController = DataGridController();
  late OrderProvider orderProvider;
 Future<List<Order>>? deliveryList;
 @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    deliveryList = orderProvider.fetchAllOrders();
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
        columnName: 'description',
        width: 100,
        label: Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            'Description',
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
    ]
    );
    return columns;
  }


  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery details'),
      ),
      drawer: Drawer(
        child:  ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Services'),
      ),
      ListTile(
        title: const Text('Delivery Service'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
      ListTile(
        title: const Text('Removal Service'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
       ListTile(
        title: const Text('Cleaning Service'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
       ListTile(
        title: const Text('Transport Service'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
        ),
      body: SingleChildScrollView(
        child: Container(
          height: height - 83,
            child: FutureBuilder<List<Order>> (
                builder: (BuildContext context, snapshot) {
                   if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
                   {
                     List<Order>? data = snapshot.data;
                      return SfDataGrid(
                          source: OrderTableGridSource(
                            context,
                            data!
                            ), 
                          columns: getColumns(),
                          allowSorting: true,
                          allowEditing: true,
                          allowMultiColumnSorting: true,
                          selectionMode: SelectionMode.single,
                          controller: _dataGridController,
                          );
                   } 
                  return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        );
                },
                future: deliveryList,
              )
          ),
                
      ),
    );
  }
  
}

class OrderTableGridSource extends DataGridSource {
  OrderTableGridSource(this.context,this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<int> rowIndex = [];
 final List<Order> productlist;
 final BuildContext context;
  void buildDataGridRow() {
   int getIndex(int? id)
    {
      int i;
      for(i= 0; i<productlist.length ;i++)
      {
        Order order = productlist[i];
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
                       Provider.of<OrderProvider>(context,listen: false)
                       .changeStatusToConfirm(productlist[row.getCells()[9].value]);
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
                     onpress: (){
                       Provider.of<OrderProvider>(context,listen: false)
                       .changeStatusToDelivered(productlist[row.getCells()[9].value]);
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
                     onpress: (){
                       Provider.of<OrderProvider>(context,listen: false)
                       .deleteSpecificOrder(productlist[row.getCells()[9].value]);
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

