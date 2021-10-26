import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '/models/order.dart';
import '/services/DeliveryServices.dart';

class DeliveryProvider with ChangeNotifier{
  List<Delivery> _orders = [];

  List<Delivery> get deliveryDeliverys => _orders;

  Future<List<Delivery>> fetchAllDeliverys() async {
    await DeliveryService().getAllDeliverys().then((res){
      if(res.statusCode == 200)
      {
        List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
        List<Delivery>  order = result.map((dynamic e)=> Delivery.fromJson(e)).toList();
        _orders = order.reversed.toList();
      }
    });
    return _orders;
  }

  Future changeStatusToDelivered(Delivery order) async {
    await DeliveryService().changeToDelivered(order).then((res){
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

  Future changeStatusToConfirm(Delivery order) async {
    await DeliveryService().changeToConfirm(order).then((res){
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

  Future  deleteSpecificDelivery(Delivery order) async {
    await DeliveryService().deleteDelivery(order).then((res){
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