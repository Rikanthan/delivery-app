import 'dart:io';
import 'package:delivery_app/models/order.dart';
import 'package:http/http.dart' as http;
import '/global/global.dart';
import 'dart:convert';

class DeliveryService
{
  Future<http.Response> getAllDeliverys()
  {
     return http.get(
        Uri.parse(url+'/order/getAllOrder')   
    );
  }


  Future<http.Response> changeToConfirm(Delivery order)
  {
     return http.post(
      Uri.parse(url+'/order/setConfirm'),
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

  Future<http.Response> changeToDelivered(Delivery order)
  {
     return http.post(
      Uri.parse(url + '/order/deliveredOrder'),
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

   Future<http.Response> deleteDelivery(Delivery order)
  {
     return http.post(
      Uri.parse(url + '/order/deleteOrder'),
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