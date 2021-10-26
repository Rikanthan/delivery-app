import 'dart:convert';
import 'package:delivery_app/models/transport.dart';
import 'package:flutter/material.dart';
import '/services/TransportServices.dart';

class TransportProvider with ChangeNotifier{
  List<Transport> _orders = [];

  List<Transport> get deliveryTransports => _orders;

  Future<List<Transport>> fetchAllTransports() async {
    await TransportService().getAllTransports().then((res){
      if(res.statusCode == 200)
      {
        List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
        List<Transport>  order = result.map((dynamic e)=> Transport.fromJson(e)).toList();
        _orders = order.reversed.toList();
      }
    });
    return _orders;
  }

  Future changeStatusToDelivered(Transport order) async {
    await TransportService().changeToDelivered(order).then((res){
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

  Future changeStatusToConfirm(Transport order) async {
    await TransportService().changeToConfirm(order).then((res){
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

  Future  deleteSpecificTransport(Transport order) async {
    await TransportService().deleteTransport(order).then((res){
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