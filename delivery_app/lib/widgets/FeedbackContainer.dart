import 'dart:math';
import 'package:delivery_app/widgets/Icons/GredientIcon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:delivery_app/models/feedback.dart';
import 'package:flutter/material.dart';

class FeedbackItem extends StatelessWidget {
  const FeedbackItem({ Key? key,
  required this.feedback,
  required this.index }) : super(key: key);
  final Feedbacks feedback;
  final int index; 
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.6;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/64/64572.png'),
                  backgroundColor: Colors.transparent,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  RatingBarIndicator(
                        rating: feedback.rating!.toDouble(),
                        itemBuilder: (context, index) => GredientIcon(
                          Icons.star, 50
                          ),
                        itemCount: 5,
                        itemSize: 50.0,
                        direction: Axis.horizontal,
                    ),
                 
                   Text(
                      feedback.name.toString().capitalize(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22
                        ),
                    ),
                  Text(
                  toSplit(feedback.message.toString()),
                  style: TextStyle(
                    color: Colors.white
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          borderRadius: BorderRadius.circular(15.0)
        ),
      ),
    );
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
   
}

String toSplit(String s)
{
  int m = 40;
  String split = "";
  int n = s.length;
  int i = 0;
  while(n > m)
  {
   
    if(n > m)
    {
      split = split+ s.substring(i*m,i*m + m)+ "\n";
    }
    i++;
    n = n - m;  
  }
  split = split+ s.substring(i*m,i*m+n)+ "\n";
  return split;
}