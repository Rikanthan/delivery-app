import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  const AlertBox({ Key? key,@required this.header,@required this.onpress }) : super(key: key);
  final String? header;
  final Function()? onpress;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you want to make $header?'),
      actions: [
        TextButton(
          onPressed:
            onpress,
           child: Text(
             "Ok",
             style: TextStyle(
               color: Colors.green
             ),
             )
           ),
           TextButton(
          onPressed: (){
             Navigator.pop(context);
          },
           child: Text(
             "Cancel",
             style: TextStyle(
               color: Colors.red
                ),
             )
           )
      ],
    );
  }
}