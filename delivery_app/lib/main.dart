import 'package:delivery_app/widgets/button.dart';
import 'package:delivery_app/widgets/text_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black12,
          child: Column(
            children: [
              Center(
                child: Padding(
                padding: const EdgeInsets.only(
                  top: 50
                ),
                child: Image.asset('assets/images/lara-logo.png'),
                )
              ),
              Card(
                elevation: 5.0,
                shadowColor: Colors.black,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Center(
                child : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lara Login',
                    style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                      ),
                    ),
                ),
                 ),
                  TextInput(
                    hideText: false, 
                    hintText: 'Username', 
                    iconData: Icons.person,
                    inputAction: TextInputAction.next,
                    ),
                    TextInput(
                    hideText: true, 
                    hintText: 'Password', 
                    iconData: Icons.lock,
                    inputAction: TextInputAction.go,
                    ),
                    CustomButton(
                      buttonText: 'Login', 
                      onPress: (){}
                      ),
                      SizedBox(
                        height: 15,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
