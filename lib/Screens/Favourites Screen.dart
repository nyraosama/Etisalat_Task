import 'dart:convert';
import 'package:etisalat_task/Models/Repos.dart';
import 'package:etisalat_task/Screens/Home%20body.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavouritesScreen extends StatefulWidget {
  static const String id='Favourites Screen';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<Map<String, dynamic>> listItems = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    final userRepos = prefs.getStringList("userRepos")!;
    setState(() {
      userRepos.forEach((item) {
        listItems.add(jsonDecode(item));
      });

    });
    print(listItems);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
        child: Center(
          child:
            ListView.builder(
                itemCount: listItems.length, itemBuilder: buildList),
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(listItems[index]["avatar_url"]!),
        ),
        title: Text(listItems[index]["full_name"]!),
      ),
    );
  }

}
