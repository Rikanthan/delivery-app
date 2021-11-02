import 'package:delivery_app/models/removal.dart';
import 'package:flutter/material.dart';

class ShowRemoval extends StatelessWidget {
  const ShowRemoval({ Key? key,required this.order }) : super(key: key);
  final Removal order;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Removal Details'),
      contentPadding: EdgeInsets.all(8),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Delivery id: ${order.orderID}'),
            Text('Name: ${order.ownerName}'),
            Text('Stock Address: ${order.stockAddress}'),
            Text('Delivery Address: ${order.deliveryAddress}'),
            Text('Email: ${order.ownerEmail}'),
            Text('Phone: ${order.ownerPhone}'),
            Text('Service Type:${order.serviceType}'),
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