import 'package:delivery_app/page/admin.dart';
import 'package:delivery_app/providers/LoginProvider.dart';
import 'package:delivery_app/widgets/button.dart';
import 'package:delivery_app/widgets/text_input.dart' as T;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late UsersProvider _usersProvider;

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  String token = "";
  bool error = false;
  
    @override
    void initState() { 
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
                child: Image.asset('assets/Images/lara-logo.png'),
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
                  T.TextInput(
                    controller: _usernameController,
                    hideText: false, 
                    hintText: 'Username', 
                    iconData: Icons.person,
                    inputAction: TextInputAction.next,
                    ),
                    T.TextInput(
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