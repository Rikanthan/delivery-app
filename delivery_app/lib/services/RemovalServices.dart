import 'dart:io';
import 'package:delivery_app/models/removal.dart';
import 'package:http/http.dart' as http;
import '/global/global.dart';
import 'dart:convert';

class RemovalService
{
  Future<http.Response> getAllRemovals()
  {
     return http.get(
        Uri.parse(url+'/removal/getAllRemoval')   
    );
  }


  Future<http.Response> changeToConfirm(Removal order)
  {
     return http.post(
      Uri.parse(url+'/removal/setConfirm'),
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
        'serviceType': order.serviceType.toString(),
        'description' : order.description.toString()
      })
    );
  }

  Future<http.Response> changeToDelivered(Removal order)
  {
     return http.post(
      Uri.parse(url + '/removal/deliveredRemoval'),
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
        'serviceType': order.serviceType.toString(),
        'description' : order.description.toString()
      }),
     
    ); 
  }

   Future<http.Response> deleteRemoval(Removal order)
  {
     return http.post(
      Uri.parse(url + '/removal/deleteRemoval'),
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
        'serviceType': order.serviceType.toString(),
        'description' : order.description.toString()
      })
    ); 
  }
  
}