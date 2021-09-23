import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  const TextInput({
   required this.hideText,
   required this.hintText,
   required this.iconData,
   required this.inputAction
  });
  final IconData iconData;
  final bool hideText;
  final String hintText;
  final TextInputAction inputAction;

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(top:30),
      child: Container(
        color: Colors.white,
        height: 56,
        width: 300,
        child: TextFormField(
                        textInputAction: widget.inputAction,
                        obscureText: widget.hideText && isHide ,
                        decoration: InputDecoration(
                        fillColor: Color(0xFF1878cc),
                        prefixIcon: Icon(
                          widget.iconData,
                          color: Colors.white,
                          size: 15,
                          ),
                          suffix: IconButton(
                            onPressed: (){
                              setState(() {
                               isHide = !isHide;
                              });
                            },
                            icon: Icon(
                              widget.hideText && isHide ? Icons.visibility : Icons.visibility_off,
                              color: widget.hideText ? Colors.white: Color(0xFF1878cc) ,
                              ),
                          ),
                          labelStyle:  TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                  fontSize: 15
                                  ),
                        filled: true,
                         hintText:widget.hintText,
                            hintStyle: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                  fontSize: 15
                                  ),
                        enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color(0xFF858585),
                        width: 2.0,
                      ),
                    ),
                  ),
                   style: TextStyle(color: Colors.white),
                ),
      ),
    );
  }
}