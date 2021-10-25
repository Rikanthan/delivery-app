import 'package:delivery_app/providers/OrderProvider.dart';
import 'package:delivery_app/widgets/alertbox.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:delivery_app/widgets/showAll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../models/order.dart';
import 'package:flutter/services.dart';

 OrderProvider? orderProvider;
class OrderTableGrid extends StatefulWidget {
  @override
  _OrderTableGridState createState() => _OrderTableGridState();
  
}

class _OrderTableGridState extends State<OrderTableGrid> {
  final DataGridController _dataGridController = DataGridController();
  late OrderTableGridSource _orderTableGridSource;
  
 late Future<List<Order>> deliveryList;
 List<Order>? productList ;
 @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    deliveryList = orderProvider!.fetchAllOrders();
    deliveryList.then((value) => productList);
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of<OrderProvider>(context);
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
                     productList = snapshot.data!;
                     _orderTableGridSource = OrderTableGridSource(context, productList!);
                      return SfDataGrid(
                        allowPullToRefresh: true,
                        allowSwiping: true,
                          source: _orderTableGridSource,
                          endSwipeActionsBuilder:
                            (BuildContext context, DataGridRow row, int rowIndex) {
                          return GestureDetector(
                              onTap: () {
                                _orderTableGridSource.dataGridRows.toList().removeAt(rowIndex);
                                _orderTableGridSource.buildDataGridRow();
                              },
                              child: Container(
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Icon(Icons.delete),
                                  )));
                        },
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
  Future<void> handleRefresh() async {
    await Future.delayed(Duration(seconds: 5));
    buildDataGridRow();
    notifyListeners();
  }
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: [
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

