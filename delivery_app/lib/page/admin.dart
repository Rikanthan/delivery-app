import 'package:delivery_app/widgets/Lists/DeliveryList.dart';
import 'package:delivery_app/widgets/Lists/RemovalList.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 ServicesClicked servicesClicked = ServicesClicked.removal;
class DeliveryTableGrid extends StatefulWidget {
  @override
  _DeliveryTableGridState createState() => _DeliveryTableGridState();
  
}

class _DeliveryTableGridState extends State<DeliveryTableGrid> {

 @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
  }

  @override
  Widget build(BuildContext context) {
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
             DeliveryList():
              servicesClicked == ServicesClicked.removal ?
           RemovalList() : null
          ),      
      ),
    );
  }  
}



