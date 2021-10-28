import 'package:delivery_app/models/cleaning.dart';
import 'package:flutter/material.dart';

class ShowCleaning extends StatelessWidget {
  const ShowCleaning({ Key? key,required this.order }) : super(key: key);
  final Cleaning order;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cleaning order Details'),
      content: Column(
        children: [
          Text('Delivery id: ${order.orderID}'),
          Text('Name: ${order.name}'),
          Text('Email: ${order.email}'),
          Text('Phone: ${order.phone}'),
          Text('Stock Address: ${order.address}'),
          Text('Delivery Date: ${order.orderDate}'),
          Text('Description: ${order.description}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
           child: Text(
             "Ok",
             style: TextStyle(
               color: Colors.green
             ),
             )
           ),
    
      ],
    );
  }
}