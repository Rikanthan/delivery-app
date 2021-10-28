import 'package:delivery_app/models/transport.dart';
import 'package:delivery_app/providers/TransportProvider.dart';
import 'package:delivery_app/widgets/DataGridSources/transportTableGrid.dart';
import 'package:delivery_app/widgets/AlertBox/ShowTransport.dart';
import 'package:delivery_app/widgets/AlertBox/alertbox.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

  late TransportProvider removalProvider;
  late TransportTableGridSource _removalTableGridSource;

class TransportList extends StatefulWidget {
   TransportList({ Key? key
   }) : super(key: key);
  
  @override
  _TransportListState createState() => _TransportListState();
}

class _TransportListState extends State<TransportList> {
 late Future<List<Transport>> removalList;
 List<Transport>? rProductList ;
 @override
  void initState() {
    super.initState();
    removalProvider = Provider.of<TransportProvider>(context, listen: false);
    removalList = removalProvider.fetchAllTransports();
    removalList.then((value) => rProductList);
  }

  @override
  Widget build(BuildContext context) {
    removalProvider = Provider.of<TransportProvider>(context);
    return FutureBuilder<List<Transport>> (
                builder: (BuildContext context, snapshot) {
                   if(snapshot.hasData && snapshot.connectionState 
                        == ConnectionState.done)
                   {
                     rProductList = snapshot.data!;
                      _removalTableGridSource = TransportTableGridSource(context, rProductList!);
                      return SfDataGrid(
                        allowPullToRefresh: true,
                        allowSwiping: true,
                          source: _removalTableGridSource,
                          endSwipeActionsBuilder:
                            (BuildContext context, DataGridRow row, int rowIndex) {
                          return Row(
                            children: [
                                  IconButton(
                                    onPressed: (){                                    
                                        showDialog(
                                          context: context,
                                           builder: (_) =>
                                           ShowTransport(order: rProductList![rowIndex])
                                           );                           
                                    },
                                     icon: Icon(
                                       Icons.zoom_in,
                                       color: Colors.blue,
                                       )
                                     ),
                                  if(rProductList![rowIndex].status!.contains('UNCONFIRMED'))
                                  IconButton(
                                    onPressed: (){
                                      showDialog(
                                        context: context, 
                                        builder: (_) => 
                                        AlertBox(
                                          header: "confirmed", 
                                        onpress: (){
                                          setState(() {
                                      removalProvider.changeStatusToConfirm(
                                                            rProductList![rowIndex]);
                                      rProductList![rowIndex].status = 'CONFIRMED';
                                    _removalTableGridSource.buildDataGridRow();
                                              }
                                            );
                                            Navigator.of(context).pop();
                                            },
                                          )
                                      );
                                    }, 
                                    icon: Icon(
                                      Icons.local_shipping,
                                      color: Colors.grey,
                                      ),
                                    ),
                                  if(rProductList![rowIndex].status!.contains('CONFIRMED') && 
                                      rProductList![rowIndex].status!.length<10)
                                      IconButton(
                                        onPressed: (){
                                            showDialog(
                                              context: context, 
                                              builder: (_) =>
                                              AlertBox(
                                              header: 'delivered',
                                              onpress: (){
                                                setState(() {
                                                removalProvider.changeStatusToDelivered(
                                                                      rProductList![rowIndex]);
                                                rProductList![rowIndex].status = 'DELIVERED';                      
                                              _removalTableGridSource.buildDataGridRow();
                                              });  
                                              Navigator.of(context).pop();
                                            },
                                           )
                                          );
                                        },
                                         icon: Icon(
                                           Icons.check_circle,
                                           color: Colors.green,
                                           )
                                         ),
                                  IconButton(
                                    onPressed: (){
                                       showDialog(
                                         context: context,
                                        builder: (_) =>
                                        AlertBox(header: 'deleted',
                                       onpress: (){
                                          setState(() {
                                      removalProvider.deleteSpecificTransport(
                                                            rProductList![rowIndex]);
                                                            rProductList!.removeAt(rowIndex);
                                      _removalTableGridSource.dataGridRows.toList().removeAt(rowIndex);                     
                                    _removalTableGridSource.buildDataGridRow();
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
                                     )
                            ],
                          );
                        },
                          columns: getColumns(transportColumnName,transportHeaders),
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
                future: removalList,
              );
  }
}