import 'dart:convert';
import 'package:delivery_app/models/cleaning.dart';
import 'package:flutter/material.dart';
import '/services/CleaningServices.dart';

class CleaningProvider with ChangeNotifier{
  List<Cleaning> _orders = [];

  List<Cleaning> get deliveryCleanings => _orders;

  Future<List<Cleaning>> fetchAllCleanings() async {
    await CleaningService().getAllCleanings().then((res){
      if(res.statusCode == 200)
      {
        List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
        List<Cleaning>  order = result.map((dynamic e)=> Cleaning.fromJson(e)).toList();
        _orders = order.reversed.toList();
      }
    });
    return _orders;
  }

  Future changeStatusToDelivered(Cleaning order) async {
    await CleaningService().changeToDelivered(order).then((res){
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

  Future changeStatusToConfirm(Cleaning order) async {
    await CleaningService().changeToConfirm(order).then((res){
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

  Future  deleteSpecificCleaning(Cleaning order) async {
    await CleaningService().deleteCleaning(order).then((res){
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