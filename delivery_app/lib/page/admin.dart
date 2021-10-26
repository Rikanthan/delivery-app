import 'package:delivery_app/models/removal.dart';
import 'package:delivery_app/models/transport.dart';
import 'package:delivery_app/providers/CleaningProvider.dart';
import 'package:delivery_app/providers/DeliveryProvider.dart';
import 'package:delivery_app/providers/RemovalProvider.dart';
import 'package:delivery_app/providers/TransportProvider.dart';
import 'package:delivery_app/widgets/DataGridSources/deliveryTableGrid.dart';
import 'package:delivery_app/widgets/DataGridSources/removalTableGrid.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:delivery_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../models/order.dart';
import 'package:flutter/services.dart';

 DeliveryProvider? orderProvider;
 RemovalProvider? removalProvider;
 TransportProvider? transportProvider;
 CleaningProvider? cleaningProvider;
 ServicesClicked servicesClicked = ServicesClicked.removal;
class DeliveryTableGrid extends StatefulWidget {
  @override
  _DeliveryTableGridState createState() => _DeliveryTableGridState();
  
}

class _DeliveryTableGridState extends State<DeliveryTableGrid> {
  final DataGridController _dataGridController = DataGridController();
  final DataGridController _removalGridController = DataGridController();
  late DeliveryTableGridSource _orderTableGridSource;
  late RemovalTableGridSource _removalTableGridSource;
 late Future<List<Delivery>> deliveryList;
 List<Delivery>? productList ;
 late Future<List<Removal>> removalList;
 List<Removal>? rProductList ;
 @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
    orderProvider = Provider.of<DeliveryProvider>(context, listen: false);
    deliveryList = orderProvider!.fetchAllDeliverys();
    deliveryList.then((value) => productList);
    removalProvider = Provider.of<RemovalProvider>(context, listen: false);
    removalList = removalProvider!.fetchAllRemovals();
    removalList.then((value) => rProductList);
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of<DeliveryProvider>(context);
    removalProvider = Provider.of<RemovalProvider>(context);
      double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivery details'),
      ),
      drawer: Drawer(
        child:ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 170,
            color: Colors.blue,
            child: Center(child: Text('Lara Admin')) ,
          ),
          ListTile(
            selected: servicesClicked == ServicesClicked.delivery ? true : false,
            selectedTileColor: Colors.cyan[100],
            leading: Icon(Icons.car_rental),
            title: const Text('Delivery Service'),
            onTap: () {
              setState(() {
                servicesClicked = ServicesClicked.delivery;
              });
            },
          ),
          ListTile(
            selected: servicesClicked == ServicesClicked.removal ? true : false,
            selectedTileColor: Colors.cyan[100],
            leading: Icon(Icons.home_repair_service),
            title: const Text('Removal Service'),
            onTap: () {
              setState(() {
                servicesClicked = ServicesClicked.removal;
              });
            },
          ),
          ListTile(
             selected: servicesClicked == ServicesClicked.transport ? true : false,
            selectedTileColor: Colors.cyan[100],
            leading: Icon(Icons.local_shipping),
            title: const Text('Transport Service'),
            onTap: () {
             setState(() {
                servicesClicked = ServicesClicked.transport;
              });
            },
          ),
          ListTile(
             selected: servicesClicked == ServicesClicked.cleaning ? true : false,
            selectedTileColor: Colors.cyan[100],
            leading: Icon(Icons.cleaning_services),
            title: const Text('Cleaning Service'),
            onTap: () {
              setState(() {
                servicesClicked = ServicesClicked.cleaning;
              });
            },
          ),
        ],
      ),
    ),
      body: SingleChildScrollView(
        child: Container(
          height: height - 83,
            child: servicesClicked == ServicesClicked.delivery ?
            FutureBuilder<List<Delivery>> (
                builder: (BuildContext context, snapshot) {
                   if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
                   {
                     productList = snapshot.data!;
                     _orderTableGridSource = DeliveryTableGridSource(context, productList!);
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
                          columns: getColumns(deliveryColumnName,deliveryHeaders),
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
              ) :
              servicesClicked == ServicesClicked.removal ?
            FutureBuilder<List<Removal>> (
                builder: (BuildContext context, snapshot) {
                   if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
                   {
                     rProductList = snapshot.data!;
                      _removalTableGridSource = RemovalTableGridSource(context, rProductList!);
                      return SfDataGrid(
                        allowPullToRefresh: true,
                        allowSwiping: true,
                          source: _removalTableGridSource,
                          endSwipeActionsBuilder:
                            (BuildContext context, DataGridRow row, int rowIndex) {
                          return GestureDetector(
                              onTap: () {
                                _removalTableGridSource.dataGridRows.toList().removeAt(rowIndex);
                                _removalTableGridSource.buildDataGridRow();
                              },
                              child: Container(
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Icon(Icons.delete),
                                  )));
                        },
                          columns: getColumns(removalColumnName,removalHeaders),
                          allowSorting: true,
                          allowEditing: true,
                          allowMultiColumnSorting: true,
                          selectionMode: SelectionMode.single,
                          controller: _removalGridController,
                          );
                   } 
                  return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        );
                },
                future: removalList,
              ) : null
          ),      
      ),
    );
  }  
}



