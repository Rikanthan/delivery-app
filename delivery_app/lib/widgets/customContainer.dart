import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({ 
    Key? key,required this.header
     }) : super(key: key);
  final String header;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8.0),
        child: Text(
          header.toLowerCase().contains("removal") ? 
          header.toLowerCase().replaceAll("removal", "").capitalize()
          : header.toLowerCase().capitalize(),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        decoration: BoxDecoration(
          color: header.toLowerCase().contains("unconfirmed") ? Colors.orange :
                header.toLowerCase().contains("confirmed") ? Colors.green :
                header.toLowerCase().contains("delivered") ? Colors.blue[800] :
                header.toLowerCase().contains("local") ? Colors.orangeAccent : 
                header.toLowerCase().contains("inter") ? Colors.pink : 
                header.toLowerCase().contains("home") ? Colors.blue
                : Colors.cyan,
          borderRadius: BorderRadius.circular(5.0)
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