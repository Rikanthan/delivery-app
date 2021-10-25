import 'package:delivery_app/models/order.dart';
import 'package:flutter/material.dart';

class ShowAll extends StatelessWidget {
  const ShowAll({ Key? key,required this.order }) : super(key: key);
  final Order order;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delivery Details'),
      content: Column(
        children: [
          Text('Order id: ${order.orderID}'),
          Text('Name: ${order.ownerName}'),
          Text('Stock Address: ${order.stockAddress}'),
          Text('Delivery Address: ${order.deliveryAddress}'),
          Text('Email: ${order.ownerEmail}'),
          Text('Phone: ${order.ownerPhone}'),
          Text('Order Date: ${order.orderDate}'),
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