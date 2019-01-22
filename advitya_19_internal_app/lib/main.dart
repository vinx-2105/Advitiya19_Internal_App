import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';




Future<List<User>> fetchUserList() async{
  final response = await http.get('http://advitiya.in/cr/api/tc/user/?format=json');

  if(response.statusCode == 200){
    return User.fromJson(json.decode(response.body));
  }
  else{
    throw Exception('Could not fetch user data');
  }
}

List<User> parseUsers(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>();
  return parsed.map<User>((json)=>User.fromJson(json)).toList();
}


class User{
  final String email;
  final String firstName;
  final String lastName;

  User({this.email, this.firstName, this.lastName});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      email: json['email'],
      firstName : json['first_name'],
      lastName: json['last_name']
    );
  }
}
class CollegeAmbassador{
  final int id;
  final int points;
  final String college;
  final String past_xp;

  CollegeAmbassador({this.id, this.points, this.college, this.past_xp});

  factory CollegeAmbassador.fromJson(Map<String, dynamic> json) {
    return CollegeAmbassador(
      id: json['id'],
      points: json['points'],
      college: json['college'],
      past_xp: json['past_xp'],
    );
  }
}

class MyApp extends StatelessWidget{
  

  MyApp({Key key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Advitiya Internal App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title:Text('Advitiya Inernal App')
        ),
        body: Center(
          child: FutureBuilder<List<User>>(
            future: fetchUserList(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return ListViewUsers(users:snapshot.data);
              }
              else if(snapshot.hasError){
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }
          ),
        )
      )
    );
  }
}

class ListViewUsers extends StatelessWidget{
  final List<User> users;

  ListViewUsers({users:users});
}

void main(){
  runApp(MyApp(ca: fetchCollegeAmbassador()));
  
}

