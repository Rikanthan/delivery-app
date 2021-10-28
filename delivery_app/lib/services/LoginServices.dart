import 'package:http/http.dart' as http;
import '/global/global.dart';
import 'dart:convert';

class UsersService
{
  Future<http.Response> checkLogin(String username,String password)
  {
     return http.post(
      Uri.parse(url+'/order/login'),
     headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*',
        'Accept': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password' : password
      })
    );
  }
}