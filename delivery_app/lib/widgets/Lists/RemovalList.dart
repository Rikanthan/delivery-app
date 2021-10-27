import 'package:delivery_app/models/removal.dart';
import 'package:delivery_app/providers/RemovalProvider.dart';
import 'package:delivery_app/widgets/DataGridSources/removalTableGrid.dart';
import 'package:delivery_app/widgets/alertbox.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:delivery_app/widgets/showRemoval.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

  late RemovalProvider removalProvider;
  late RemovalTableGridSource _removalTableGridSource;

class RemovalList extends StatefulWidget {
   RemovalList({ Key? key
   }) : super(key: key);
  
  @override
  _RemovalListState createState() => _RemovalListState();
}

class _RemovalListState extends State<RemovalList> {
 late Future<List<Removal>> removalList;
 List<Removal>? rProductList ;
 @override
  void initState() {
    super.initState();
    removalProvider = Provider.of<RemovalProvider>(context, listen: false);
    removalList = removalProvider.fetchAllRemovals();
    removalList.then((value) => rProductList);
  }

  @override
  Widget build(BuildContext context) {
    removalProvider = Provider.of<RemovalProvider>(context);
    return FutureBuilder<List<Removal>> (
                builder: (BuildContext context, snapshot) {
                   if(snapshot.hasData && snapshot.connectionState 
                        == ConnectionState.done)
                   {
                     rProductList = snapshot.data!;
                      _removalTableGridSource = RemovalTableGridSource(context, rProductList!);
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
                                           ShowRemoval(order: rProductList![rowIndex])
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
                                      removalProvider.deleteSpecificRemoval(
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
                          columns: getColumns(removalColumnName,removalHeaders),
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