import 'package:delivery_app/models/order.dart';
import 'package:delivery_app/providers/DeliveryProvider.dart';
import 'package:delivery_app/widgets/DataGridSources/deliveryTableGrid.dart';
import 'package:delivery_app/widgets/AlertBox/alertbox.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:delivery_app/widgets/AlertBox/showAll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

late DeliveryTableGridSource _orderTableGridSource;
late DeliveryProvider _deliveryProvider;

class DeliveryList extends StatefulWidget {
  const DeliveryList({ Key? key }) : super(key: key);

  @override
  _DeliveryListState createState() => _DeliveryListState();
}

class _DeliveryListState extends State<DeliveryList> {
 late Future<List<Delivery>>deliveryList;
 List<Delivery>? productList ;
 @override
  void initState() {
    super.initState();
    _deliveryProvider = Provider.of<DeliveryProvider>(context, listen: false);
    deliveryList = _deliveryProvider.fetchAllDeliverys();
    deliveryList.then((value) => productList);
  }

  @override
  Widget build(BuildContext context) {
    _deliveryProvider = Provider.of<DeliveryProvider>(context);
    return FutureBuilder<List<Delivery>> (
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
                          return Row(
                            children: [
                             IconButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (_) => ShowAll(
                              order: productList![rowIndex]
                              )
                            );
                           }, 
                      icon: Icon(
                        Icons.zoom_in,
                        color: Colors.blue,
                        )
                      ),
                if(productList![rowIndex].status!.contains('UNCONFIRMED'))
                            IconButton(
                              onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertBox(
                                    header: 'confirmed', 
                                      onpress: (){
                                        setState(() {
                                           _deliveryProvider
                                      .changeStatusToConfirm(
                                        productList![rowIndex]);
                                        productList![rowIndex].status = 'CONFIRMED';
                                        _orderTableGridSource.buildDataGridRow();
                                        });
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
              productList![rowIndex].status!.contains('CONFIRMED') 
              &&  productList![rowIndex].status!.toString().length < 10)
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertBox(
                                          header: 'delivered', 
                                          onpress: (){
                                            setState(() {
                                              _deliveryProvider
                                            .changeStatusToDelivered(
                                              productList![rowIndex]);
                                              productList![rowIndex].status = 'DELIVERED';
                                            _orderTableGridSource.buildDataGridRow();
                                            });
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
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertBox(
                                    header: 'deleted', 
                                    onpress: (){
                                      setState(() {
                                        _deliveryProvider
                                      .deleteSpecificDelivery(
                                        productList![rowIndex]);
                                        productList!.removeAt(rowIndex);
                                        _orderTableGridSource.buildDataGridRow();
                                      });
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
                          );
                        },
                          columns: getColumns(deliveryColumnName,deliveryHeaders),
                          allowSorting: true,
                          allowEditing: true,
                          allowMultiColumnSorting: true,
                          selectionMode: SelectionMode.single,
                          );
                   } 
                  return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        );
                },
                future: deliveryList,
              );
  }
}
