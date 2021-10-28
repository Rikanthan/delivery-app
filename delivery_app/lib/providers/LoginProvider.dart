import 'dart:convert';
import 'dart:core';
import 'package:delivery_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import '/services/LoginServices.dart';

class UsersProvider with ChangeNotifier{

   Future<bool> checkUser(String username,String password) async {
     bool b = false;
    await UsersService().checkLogin(username, password).then((res){
     try{
       if(res.statusCode == 200 && res.body.isNotEmpty)
      {  
          b = true;
      }
     }
      catch(e)
      {
        print(e);
      }
    });
    return b;
  }
}