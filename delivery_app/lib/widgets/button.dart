import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.buttonText,
    required this.onPress
  });
  final String buttonText;
  final Function() onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                  child:TextButton(
                   child: Text(
                      buttonText,
                      style:TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    onPressed: onPress,
                   style:ButtonStyle(
                      backgroundColor: MaterialStateColor
                                                      .resolveWith(
                                                                (states) => Colors.black 
                                                                  ),
                      padding:  MaterialStateProperty
                                                    .resolveWith(
                                                                (states) => EdgeInsets.only(
                                                                                      left:36,
                                                                                      right:36,
                                                                                      top:20,
                                                                                      bottom:20
                                                                                      )
                                                                                  ),
                      shape: MaterialStateProperty
                                            .all(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                                ),
                    ),                
                  )
              )
        )
    );
  }
}