import 'dart:io';
import 'package:delivery_app/models/transport.dart';
import 'package:http/http.dart' as http;
import '/global/global.dart';
import 'dart:convert';

class TransportService
{
  Future<http.Response> getAllTransports()
  {
     return http.get(
        Uri.parse(url+'/transport/getAllTransport')   
    );
  }


  Future<http.Response> changeToConfirm(Transport order)
  {
     return http.post(
      Uri.parse(url+'/transport/setConfirm'),
     headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'orderId': order.orderID.toString(),
        'email':order.email.toString(),
        'phone':order.phone.toString(),
        'frightTo': order.frightTo.toString(),
        'address' : order.address.toString(),
        'description' : order.description.toString(),
        'status' : order.status.toString(),
        'name' : order.name.toString(),
        'orderDate' : order.orderDate.toString(),
        'frightfrom': order.frightFrom.toString()
      })
    );
  }

  Future<http.Response> changeToDelivered(Transport order)
  {
     return http.post(
      Uri.parse(url + '/transport/deliveredTransport'),
       headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
       'orderId': order.orderID.toString(),
        'email':order.email.toString(),
        'phone':order.phone.toString(),
        'frightTo': order.frightTo.toString(),
        'address' : order.address.toString(),
        'description' : order.description.toString(),
        'status' : order.status.toString(),
        'name' : order.name.toString(),
        'orderDate' : order.orderDate.toString(),
        'frightfrom': order.frightFrom.toString()
      }),
     
    ); 
  }

   Future<http.Response> deleteTransport(Transport order)
  {
     return http.post(
      Uri.parse(url + '/transport/deleteTransport'),
      headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.allowHeader: '*',
        },
      body: jsonEncode(<String, dynamic>{
        'orderId': order.orderID.toString(),
        'email':order.email.toString(),
        'phone':order.phone.toString(),
        'frightTo': order.frightTo.toString(),
        'address' : order.address.toString(),
        'description' : order.description.toString(),
        'status' : order.status.toString(),
        'name' : order.name.toString(),
        'orderDate' : order.orderDate.toString(),
        'frightfrom': order.frightFrom.toString()
      })
    ); 
  }
  
}