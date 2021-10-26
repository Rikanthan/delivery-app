import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/widgets/button.dart';
import 'package:delivery_app/widgets/text_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_important',
  'Important notifications',
  'This is description for this channel',
  importance: Importance.high,
  playSound: true
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
  FlutterLocalNotificationsPlugin();

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  bool isLoading = false;
  String token = "";
  late FirebaseMessaging messaging;
    @override
    void initState() { 
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      token = value.toString();
        print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      RemoteNotification? notification = message.notification;
      AndroidNotification? android =  message.notification?.android;
      if(notification != null && android != null)
      {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher'
            )
          )
        );
      }
    });
  }
   
    
      _saveDeviceToken() async {
    // Get the current user
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String? fcmToken = await messaging.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('devicetokens')
          .doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp()// optional
      });
    }
  }
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
                    controller: _usernameController,
                    hideText: false, 
                    hintText: 'Username', 
                    iconData: Icons.person,
                    inputAction: TextInputAction.next,
                    ),
                    TextInput(
                    controller: _passwordController,
                    hideText: true, 
                    hintText: 'Password', 
                    iconData: Icons.lock,
                    inputAction: TextInputAction.go,
                    ),
                    CustomButton(
                      buttonText: 'Login', 
                      onPress:(){
                        try{
                          _saveDeviceToken();
                          WidgetsBinding.instance!.addPostFrameCallback((_) 
                          { 
                            Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_)=> DeliveryTableGrid()
                              ));
                          });
                          print("the token is- "+token);
                         //_auth.signInWithEmailAndPassword(email: _usernameController.text, 
                          //password: _passwordController.text);
                          //  final User? user = (await _auth.signInWithEmailAndPassword(
                          // email: _usernameController.text, password: _passwordController.text
                          // )).user;
                          // if(user != null)
                          // {
                          //   setState(() {
                          //     isLoading = true;
                          //   });
                          //   Navigator.of(context)
                          //                       .push(MaterialPageRoute(builder: (_)=>
                          //                       JsonDataGrid()));
                          // }
                        }
                        catch(e)
                        {
                          print(e);
                        }
                      
                        }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [

                        ],
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