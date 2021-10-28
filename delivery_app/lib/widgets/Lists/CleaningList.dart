import 'package:delivery_app/models/cleaning.dart';
import 'package:delivery_app/providers/CleaningProvider.dart';
import 'package:delivery_app/widgets/DataGridSources/cleaningTableGrid.dart';
import 'package:delivery_app/widgets/AlertBox/ShowCleaning.dart';
import 'package:delivery_app/widgets/AlertBox/alertbox.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:delivery_app/widgets/AlertBox/showAll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

late CleaningTableGridSource _orderTableGridSource;
late CleaningProvider _deliveryProvider;


class CleaningList extends StatefulWidget {
  const CleaningList({ Key? key }) : super(key: key);

  @override
  _CleaningListState createState() => _CleaningListState();
}

class _CleaningListState extends State<CleaningList> {
 late Future<List<Cleaning>>deliveryList;
 List<Cleaning>? productList ;
 @override
  void initState() {
    super.initState();
    _deliveryProvider = Provider.of<CleaningProvider>(context, listen: false);
    deliveryList = _deliveryProvider.fetchAllCleanings();
    deliveryList.then((value) => productList);
  }

  @override
  Widget build(BuildContext context) {
    _deliveryProvider = Provider.of<CleaningProvider>(context);
    return FutureBuilder<List<Cleaning>> (
                builder: (BuildContext context, snapshot) {
                   if(snapshot.hasData && snapshot.connectionState == ConnectionState.done)
                   {
                     productList = snapshot.data!;
                     _orderTableGridSource = CleaningTableGridSource(context, productList!);
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
                            builder: (_) => ShowCleaning(
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
                                              productList![row.getCells()[9].value]);
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
                                      .deleteSpecificCleaning(
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
                          columns: getColumns(cleaningColumnName,cleaningHeaders),
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
