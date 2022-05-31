import 'package:flutter/material.dart';
import 'package:etisalat_task/Utilities/constants.dart';
import 'Home Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id='Login Screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  bool showspinner=false;
  String email='';
  String password='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration:KTextFieldDecoration.copyWith(hintText: 'Enter Your Email '),
              ),

              SizedBox(
                height: 8.0,
              ),

              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration: KTextFieldDecoration.copyWith(hintText: 'Enter Your Password '),
              ),

              SizedBox(
                height: 24.0,
              ),

              FlatButton(
                color: Colors.greenAccent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text('Login',style: TextStyle(fontSize: 18),),
                onPressed: () async{
                  setState(() {
                    showspinner=true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if(user!=null){
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      showspinner=false;
                    });
                  }
                  catch(e){
                    print(e);
                  }
                },
              ),

            ],

          ),
        ),
      ),
    );
  }
}
