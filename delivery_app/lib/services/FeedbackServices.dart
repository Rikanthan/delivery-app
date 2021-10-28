import 'dart:io';
import 'package:delivery_app/models/feedback.dart';
import 'package:http/http.dart' as http;
import '/global/global.dart';
import 'dart:convert';

class FeedbacksService
{
  Future<http.Response> getAllFeedbacks()
  {
     return http.get(
        Uri.parse(url+'/feedback/getFeedback')   
    );
  }

   Future<http.Response> deleteFeedbacks(Feedbacks feedback)
  {
     return http.post(
      Uri.parse(url + '/feedback/deleteFeedback'),
      headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.allowHeader: '*',
        },
      body: jsonEncode(<String, dynamic>{
        'feedbackId': feedback.feedbackId.toString(),
        'name' : feedback.name.toString(),
        'phoneNumber':feedback.phoneNumber.toString(),
        'email' : feedback.email.toString(),
        'message' : feedback.message.toString(),
        'rating' : feedback.rating.toString(),
        'sentDate' : feedback.sendDate.toString()
      })
    ); 
  }
  
}