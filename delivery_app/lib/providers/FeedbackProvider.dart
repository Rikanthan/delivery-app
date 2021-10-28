import 'dart:convert';
import 'package:delivery_app/models/feedback.dart';
import 'package:flutter/cupertino.dart';
import '/services/FeedbackServices.dart';

class FeedbacksProvider with ChangeNotifier{
  List<Feedbacks> _feedbacks = [];

  List<Feedbacks> get deliveryFeedbackss => _feedbacks;

  Future<List<Feedbacks>> fetchAllFeedbacks() async {
    await FeedbacksService().getAllFeedbacks().then((res){
      if(res.statusCode == 200)
      {
        List<dynamic> result = json.decode(res.body).cast<Map<String,dynamic>>();
        List<Feedbacks>  order = result.map((dynamic e)=> Feedbacks.fromJson(e)).toList();
        _feedbacks = order.reversed.toList();
      }
    });
    return _feedbacks;
  }

  Future  deleteSpecificFeedbacks(Feedbacks order) async {
    await FeedbacksService().deleteFeedbacks(order).then((res){
      print(res.statusCode);
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