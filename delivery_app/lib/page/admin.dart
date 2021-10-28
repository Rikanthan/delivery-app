import 'package:delivery_app/page/login.dart';
import 'package:delivery_app/widgets/Lists/CleaningList.dart';
import 'package:delivery_app/widgets/Lists/DeliveryList.dart';
import 'package:delivery_app/widgets/Lists/FeedbackList.dart';
import 'package:delivery_app/widgets/Lists/RemovalList.dart';
import 'package:delivery_app/widgets/Lists/TransportList.dart';
import 'package:delivery_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminPage extends StatefulWidget {
  // AdminPage({required this.servicesClicked});
  // final ServicesClicked servicesClicked;
  @override
  _AdminPageState createState() => _AdminPageState();
  
}

class _AdminPageState extends State<AdminPage> {
 @override
  void initState() {
    super.initState();
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
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
            color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:30.0,bottom: 10.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/64/64572.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(
                  'Lara Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontSize: 18
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                          onPressed: () async{
                            SharedPreferences preferences = await SharedPreferences.getInstance();
                            preferences.remove("username");
                            Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (_) => LoginPage()
                                ));
                          }, 
                          icon: Icon(Icons.logout)
                          ),
                  ],
                )
              ],
            ) ,
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
          ListTile(
             selected: servicesClicked == ServicesClicked.feedback ? true : false,
            selectedTileColor: Colors.cyan[100],
            leading: Icon(Icons.feedback),
            title: const Text('Feedbacks'),
            onTap: () {
              Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (_)=>FeedbackList()));
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
           RemovalList() : 
           servicesClicked == ServicesClicked.transport ? 
           TransportList() : 
           CleaningList() 
          ),      
      ),
    );
  }  
}



