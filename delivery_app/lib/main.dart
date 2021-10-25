import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/page/login.dart';
import 'package:delivery_app/providers/OrderProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_important',
  'Important notifications',
  'This is description for this channel',
  importance: Importance.high,
  playSound: true
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
  FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try{
    await Firebase.initializeApp();
    print('Background msg: ${message.messageId}');
  }
    on FirebaseException catch(e){
      rethrow;
    }
  }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try
  {
    await Firebase.initializeApp();
  }
  catch(e)
  {
    rethrow;
  }
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderProvider>.value(value: OrderProvider())
    ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      )
    );
  }
}


