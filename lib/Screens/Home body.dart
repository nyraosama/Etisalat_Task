import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etisalat_task/Utilities/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:etisalat_task/Models/Repos.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  TextEditingController _controller = TextEditingController();
  Future<List<Repo>>? Users;
  List<bool> _checked=List.filled(100,false);


  static Future<List<Repo>> getUsers(String username) async {
    final response = await http.get(
      Uri.parse('https://api.github.com/users/${username}/repos'),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body.map<Repo>(Repo.fromJson).toList();
    } else {
      throw Exception('Failed to Fetch Repos');
    }
  }

  saveData(String fn,String ao)async{
    final Map<String, String> item = Map<String, String>();
    item['avatar_url']=ao;
    item['full_name']=fn;

    SharedPreferences prefs=await SharedPreferences.getInstance();
    List<String>? userRepos = prefs.getStringList("userRepos");
    if (userRepos == null) userRepos = [];
    userRepos.add(jsonEncode(item));
    prefs.setStringList("userRepos", userRepos);
    print(userRepos);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: (Users == null)
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: buildColumn(),
                  )
                : FutureBuilder<List<Repo>>(
                    future: Users,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        final users = snapshot.data!;
                        return buildUsers(users);
                      } else {
                        return const Text('No user data. ');
                      }
                    },
                  )));
  }

  Widget buildUsers(List<Repo> users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(user.avatar_url),
              ),
              title: Text(user.full_name),
              trailing: Checkbox(
                value: _checked[index],
                activeColor: Colors.greenAccent,
                onChanged: (newvalue){
                  setState(() {
                    _checked[index]=newvalue!;
                    if(_checked[index]==true){
                      saveData(user.full_name, user.avatar_url);
                    }
                  });
                },
              ),

            ),
          );
        },
      );

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CircleAvatar(
          radius: 50,
          child: ClipOval(
            child: Image.asset('images/githubicon.png'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'Github',
            style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _controller,
          textAlign: TextAlign.center,
          decoration:
              KTextFieldDecoration.copyWith(hintText: 'Github username'),
        ),
        SizedBox(
          height: 10,
        ),
        FlatButton(
          color: Colors.greenAccent,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Text(
            'Search',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () {
            setState(() {
              Users = getUsers(_controller.text);
            });
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
