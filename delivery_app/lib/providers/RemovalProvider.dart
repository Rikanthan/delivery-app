import 'dart:convert';
import 'package:delivery_app/models/removal.dart';
import 'package:flutter/cupertino.dart';
import '/services/RemovalServices.dart';

class RemovalProvider with ChangeNotifier{
  List<Removal> _orders = [];

  List<Removal> get deliveryRemovals => _orders;

  Future<List<Removal>> fetchAllRemovals() async {
    await RemovalService().getAllRemovals().then((res){
      print(res.statusCode);
      if(res.statusCode == 200)
      {
        List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
        List<Removal>  order = result.map((dynamic e)=> Removal.fromJson(e)).toList();
        _orders = order.reversed.toList();
      }
    });
    return _orders;
  }

  Future changeStatusToDelivered(Removal order) async {
    await RemovalService().changeToDelivered(order).then((res){
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

  Future changeStatusToConfirm(Removal order) async {
    await RemovalService().changeToConfirm(order).then((res){
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

  Future  deleteSpecificRemoval(Removal order) async {
    await RemovalService().deleteRemoval(order).then((res){
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