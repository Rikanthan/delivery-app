import 'dart:io';

import 'package:delivery_app/models/order.dart';
import 'package:http/http.dart' as http;
import '/global/global.dart';
import 'dart:convert';

class OrderService
{
  Future<http.Response> getAllOrders()
  {
     return http.get(
        Uri.parse(url+'/getAllOrder')   
    );
  }


  Future<http.Response> changeToConfirm(Order order)
  {
     return http.post(
      Uri.parse(url+'/setConfirm'),
     headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'orderId': order.orderID.toString(),
        'ownerName': order.ownerName.toString(),
        'stockAddress': order.stockAddress.toString(),
        'deliveryAddress': order.deliveryAddress.toString(),
        'ownerEmail': order.ownerEmail.toString(),
        'ownerPhoneNumber': order.ownerPhone.toString(),
        'status': order.status.toString(),
        'orderDate': order.orderDate.toString(),
        'description' : order.description.toString()
      })
    );
  }

  Future<http.Response> changeToDelivered(Order order)
  {
     return http.post(
      Uri.parse(url + '/deliveredOrder'),
       headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'orderId': order.orderID.toString(),
        'ownerName': order.ownerName.toString(),
        'stockAddress': order.stockAddress.toString(),
        'deliveryAddress': order.deliveryAddress.toString(),
        'ownerEmail': order.ownerEmail.toString(),
        'ownerPhoneNumber': order.ownerPhone.toString(),
        'status': order.status.toString(),
        'orderDate': order.orderDate.toString(),
        'description' : order.description.toString()
      }),
     
    ); 
  }

   Future<http.Response> deleteOrder(Order order)
  {
     return http.post(
      Uri.parse(url + '/deleteOrder'),
      headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.allowHeader: '*',
        },
      body: jsonEncode(<String, dynamic>{
        'orderId': order.orderID.toString(),
        'ownerName': order.ownerName.toString(),
        'stockAddress': order.stockAddress.toString(),
        'deliveryAddress': order.deliveryAddress.toString(),
        'ownerEmail': order.ownerEmail.toString(),
        'ownerPhoneNumber': order.ownerPhone.toString(),
        'status': order.status.toString(),
        'orderDate': order.orderDate.toString(),
        'description' : order.description.toString()
      })
    ); 
  }
  
}