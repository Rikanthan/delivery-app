import 'dart:io';
import 'package:delivery_app/models/cleaning.dart';
import 'package:http/http.dart' as http;
import '/global/global.dart';
import 'dart:convert';

class CleaningService
{
  Future<http.Response> getAllCleanings()
  {
     return http.get(
        Uri.parse(url+'/getAllCleaning')   
    );
  }


  Future<http.Response> changeToConfirm(Cleaning order)
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
        'name' : order.name.toString(),
        'email':order.email.toString(),
        'address' : order.address.toString(),
        'description' : order.description.toString(),
        'orderDate' : order.orderDate.toString(),
        'status' : order.status.toString(),
        'phone':order.phone.toString(),
      })
    );
  }

  Future<http.Response> changeToDelivered(Cleaning order)
  {
     return http.post(
      Uri.parse(url + '/deliveredCleaning'),
       headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
       'orderId': order.orderID.toString(),
        'name' : order.name.toString(),
        'email':order.email.toString(),
        'address' : order.address.toString(),
        'description' : order.description.toString(),
        'orderDate' : order.orderDate.toString(),
        'status' : order.status.toString(),
        'phone':order.phone.toString(),
      }),
     
    ); 
  }

   Future<http.Response> deleteCleaning(Cleaning order)
  {
     return http.post(
      Uri.parse(url + '/deleteCleaning'),
      headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.allowHeader: '*',
        },
      body: jsonEncode(<String, dynamic>{
        'orderId': order.orderID.toString(),
        'name' : order.name.toString(),
        'email':order.email.toString(),
        'address' : order.address.toString(),
        'description' : order.description.toString(),
        'orderDate' : order.orderDate.toString(),
        'status' : order.status.toString(),
        'phone':order.phone.toString(),
      })
    ); 
  }
  
}