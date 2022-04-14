import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/page/login.dart';
import 'package:delivery_app/providers/CleaningProvider.dart';
import 'package:delivery_app/providers/DeliveryProvider.dart';
import 'package:delivery_app/providers/FeedbackProvider.dart';
import 'package:delivery_app/providers/LoginProvider.dart';
import 'package:delivery_app/providers/RemovalProvider.dart';
import 'package:delivery_app/providers/TransportProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = preferences.getString("username");
  }
  catch(e)
  {
    rethrow;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DeliveryProvider>.value(value: DeliveryProvider()),
        ChangeNotifierProvider<RemovalProvider>.value(value: RemovalProvider()),
        ChangeNotifierProvider<TransportProvider>.value(value: TransportProvider()),
        ChangeNotifierProvider<CleaningProvider>.value(value: CleaningProvider()),
        ChangeNotifierProvider<FeedbacksProvider>.value(value: FeedbacksProvider()),
        ChangeNotifierProvider<UsersProvider>.value(value: UsersProvider()),
    ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user == null ? LoginPage() : AdminPage(),
      )
    );
  }
}


