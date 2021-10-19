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

  //https://laraexpress.herokuapp.com/order/deliveredOrder
    //https://laraexpress.herokuapp.com/order/setConfirm
    //https://laraexpress.herokuapp.com/order/deleteOrder

  Future<http.Response> changeToConfirm(Order order)
  {
     return http.post(
      Uri.parse(url + '/setConfirm'),
      body: jsonEncode(<String, String>{
        "orderId": order.orderID.toString(),
        "ownerName": order.ownerName.toString(),
        "stockAddress": order.stockAddress.toString(),
        "deliveryAddress": order.deliveryAddress.toString(),
        "ownerEmail": order.ownerEmail.toString(),
        "ownerPhoneNumber": order.ownerPhone.toString(),
        "status": order.ownerName.toString(),
        "orderDate": order.orderDate.toString()
      }),
    );
  }

  Future<http.Response> changeToDelivered(Order order)
  {
     return http.post(
      Uri.parse(url + '/deliveredOrder'),
      body: jsonEncode(<String, String>{
        "orderId": order.orderID.toString(),
        "ownerName": order.ownerName.toString(),
        "stockAddress": order.stockAddress.toString(),
        "deliveryAddress": order.deliveryAddress.toString(),
        "ownerEmail": order.ownerEmail.toString(),
        "ownerPhoneNumber": order.ownerPhone.toString(),
        "status": order.ownerName.toString(),
        "orderDate": order.orderDate.toString()
      }),
    ); 
  }

   Future<http.Response> deleteOrder(Order order)
  {
     return http.post(
      Uri.parse(url + '/deleteOrder'),
      body: jsonEncode(<String, String>{
        "orderId": order.orderID.toString(),
        "ownerName": order.ownerName.toString(),
        "stockAddress": order.stockAddress.toString(),
        "deliveryAddress": order.deliveryAddress.toString(),
        "ownerEmail": order.ownerEmail.toString(),
        "ownerPhoneNumber": order.ownerPhone.toString(),
        "status": order.ownerName.toString(),
        "orderDate": order.orderDate.toString()
      }),
    ); 
  }
  
}