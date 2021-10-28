import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({ Key? key,required this.servicesClicked}) : super(key: key);
  final ServicesClicked servicesClicked;
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.of(context)
              .push(MaterialPageRoute(builder: (_)=> AdminPage()));
            },
          ),
          ListTile(
            selected: servicesClicked == ServicesClicked.removal ? true : false,
            selectedTileColor: Colors.blue,
            focusColor: Colors.blue,
            leading: Icon(Icons.home_repair_service),
            title: const Text('Removal Service'),
            onTap: () {
              
            },
          ),
          ListTile(
             selected: servicesClicked == ServicesClicked.transport ? true : false,
            selectedTileColor: Colors.blue,
            focusColor: Colors.blue,
            leading: Icon(Icons.local_shipping),
            title: const Text('Transport Service'),
            onTap: () {
             
            },
          ),
          ListTile(
             selected: servicesClicked == ServicesClicked.cleaning ? true : false,
            selectedTileColor: Colors.blue,
            focusColor: Colors.blue,
            leading: Icon(Icons.cleaning_services),
            title: const Text('Cleaning Service'),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}