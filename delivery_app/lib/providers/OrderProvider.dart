import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '/models/order.dart';
import '/services/OrderServices.dart';

class OrderProvider with ChangeNotifier{
  List<Order> _orders = [];

  List<Order> get deliveryOrders => _orders;

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

  Future changeStatusToDelivered(Order order) async {
    await OrderService().changeToDelivered(order).then((res){
      try{
          if(res.statusCode == 200)
        {
          print("success");
          notifyListeners();
        }
      }
      catch(e)
      {
        print(e);
      } 
    });   
  }

  Future changeStatusToConfirm(Order order) async {
    await OrderService().changeToConfirm(order).then((res){
      try{
          if(res.statusCode == 200)
        {
          print("success");
        }
      }
      catch(e)
      {
        print(e);
      }
    });
    notifyListeners();
  }

  Future  deleteSpecificOrder(Order order) async {
    await OrderService().deleteOrder(order).then((res){
      try{
          if(res.statusCode == 200)
      {
        print('success');
      }
    }
    catch(e)
    {
      print(e);
    }
    });
    notifyListeners();
  }
}