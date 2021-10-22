import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '/models/order.dart';
import '/services/OrderServices.dart';

class OrderProvider with ChangeNotifier{
  List<Order> _orders = [];

  Future<List<Order>> fetchAllOrders() async {
    await OrderService().getAllOrders().then((res){
      if(res.statusCode == 200)
      {
        List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
        List<Order>  order = result.map((dynamic e)=> Order.fromJson(e)).toList();
        _orders = order.reversed.toList();
      }
    });
    return _orders;
  }

  Future<List<Order>> changeStatusToDelivered(Order order) async {
    await OrderService().changeToDelivered(order).then((res){
      try{
          if(res.statusCode == 200)
        {
          List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
          List<Order>  order = result.map((dynamic e)=> Order.fromJson(e)).toList();
          _orders = order.reversed.toList();
        }
      }
      catch(e)
      {
        print(e);
      }
      
    });
    notifyListeners();
    return _orders;
  }

  Future<List<Order>> changeStatusToConfirm(Order order) async {
    await OrderService().changeToConfirm(order).then((res){
      try{
          if(res.statusCode == 200)
        {
          List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
          List<Order>  order = result.map((dynamic e)=> Order.fromJson(e)).toList();
          _orders = order.reversed.toList();
        }
      }
      catch(e)
      {
        print(e);
      }
     
    });
    notifyListeners();
    return _orders;
  }

  Future<List<Order>> deleteSpecificOrder(Order order) async {
    await OrderService().deleteOrder(order).then((res){
      try{
          if(res.statusCode == 200)
      {
        List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
        List<Order>  order = result.map((dynamic e)=> Order.fromJson(e)).toList();
        _orders = order.reversed.toList();
      }
    }
    catch(e)
    {
      print(e);
    }
      
    });
    notifyListeners();
    return _orders;
  }

}