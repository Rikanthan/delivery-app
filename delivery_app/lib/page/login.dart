import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/providers/LoginProvider.dart';
import 'package:delivery_app/widgets/button.dart';
import 'package:delivery_app/widgets/text_input.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late UsersProvider _usersProvider;

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
  bool error = false;
  late FirebaseMessaging messaging;
    @override
    void initState() { 
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value){
      token = value.toString();
       _usersProvider = Provider.of<UsersProvider>(context,listen:false);
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
    String? fcmToken = await messaging.getToken();

    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db
          .collection('devicetokens')
          .doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        // optional
      });
      setState(() {
        isLoading = true;
        // error = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    _usersProvider = Provider.of<UsersProvider>(context);
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
                    if(error)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left:30.0,top: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.report,
                              color: Colors.red,
                            ),
                            Text(
                              " Username or Password error",
                              style: TextStyle(
                                color: Colors.red
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                      buttonText: 'Login', 
                      onPress:() async{
                          _saveDeviceToken();
                          _usersProvider
                          .checkUser(
                            _usernameController.text,
                            _passwordController.text)
                            .then((value) async {
                              if(value == true)
                              {
                                SharedPreferences preferences = await SharedPreferences.getInstance();
                                preferences
                                .setString("username",_usernameController.text);
                                setState(() {
                                  error = false;
                                });
                                WidgetsBinding.instance!.addPostFrameCallback((_) 
                                { 
                                  Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_)=> AdminPage()
                                    ));
                                });
                              }
                            else{
                              setState(() {
                                isLoading = false;
                                error = true;
                              });
                            }
                          });                      
                        }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if(isLoading)
                      Center(
                        child: CircularProgressIndicator()
                        ),
                      
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