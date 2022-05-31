import 'package:etisalat_task/Screens/Favourites%20Screen.dart';
import 'package:etisalat_task/Screens/Home%20Screen.dart';
import 'package:etisalat_task/Screens/Login%20Screen.dart';
import 'package:etisalat_task/Screens/Registration%20Screen.dart';
import 'package:etisalat_task/Screens/Welcome%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Task());
}



class Task extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        LoginScreen.id:(context) =>LoginScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        FavouritesScreen.id:(context)=>FavouritesScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
      },
    );
  }
}
