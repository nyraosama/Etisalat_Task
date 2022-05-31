import 'package:flutter/material.dart';
import 'Registration Screen.dart';
import 'Login Screen.dart';
import 'Home Screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id='Welcome Screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:<Widget> [
            FlatButton(
              color: Colors.greenAccent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text('Register',style: TextStyle(fontSize: 18),),
              onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),

            FlatButton(
              color: Colors.greenAccent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text('Login',style: TextStyle(fontSize: 18),),
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),

            TextButton(
              child: Text('Continue as a guest',
                style: TextStyle(
                  color: Colors.greenAccent,
                    fontSize: 18,
                  decoration: TextDecoration.underline),
              ),
              onPressed: (){
                Navigator.pushNamed(context, HomeScreen.id);
              },
            ),

          ],
        ),
      ),

    );
  }
}
