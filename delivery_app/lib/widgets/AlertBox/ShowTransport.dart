import 'package:delivery_app/models/transport.dart';
import 'package:flutter/material.dart';

class ShowTransport extends StatelessWidget {
  const ShowTransport({ Key? key,required this.order }) : super(key: key);
  final Transport order;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transport Details'),
      contentPadding: EdgeInsets.all(8),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Delivery id: ${order.orderID}'),
            Text('Name: ${order.name}'),
            Text('Address: ${order.address}'),
            Text('Email: ${order.email}'),
            Text('Phone: ${order.phone}'),
            Text('Freight From: ${order.frightFrom}'),
            Text('Freight To:${order.frightTo}'),
            Text('Delivery Date: ${order.orderDate}'),
            Text('Description: ${order.description}'),
          ],
        ),
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