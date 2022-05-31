import 'package:flutter/cupertino.dart';

class Repo{
  final String full_name;
  final String avatar_url;


  const Repo({required this.full_name,required this.avatar_url});

  static Repo fromJson(json)=>Repo(
  full_name: json['full_name'],
  avatar_url: json['owner']['avatar_url'],
  );

  Map<String,dynamic>toJson(){
    return{
      'full_name':full_name,
      'avatar_url':avatar_url,
    };
  }
}

