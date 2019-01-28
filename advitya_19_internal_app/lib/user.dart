import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';


class UserFetchData extends StatefulWidget {
  @override
  _UserFetchDataState createState() => _UserFetchDataState();
}
class _UserFetchDataState extends State<UserFetchData> {
  //two variables
  List list = List();
  var isLoading = false;
  //fetch the CA data from the API


  _fetchUser() async {
    setState(() {
      isLoading = true;
    });
    try{

      final response =
          await http.get("http://advitiya.in/cr/api/tc/user/?format=json");
      if (response.statusCode == 200) {
        list = json.decode(response.body)['objects'] as List;
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load Users');
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Advitiya-19 Users"),
      ),

      bottomNavigationBar: Padding(
        padding:const EdgeInsets.all(8.0),
        child: RaisedButton(
          child: Text("Fetch Users"),
          onPressed: _fetchUser,
        ),
      ),
      body: isLoading
          ?Center(
            child:CircularProgressIndicator(),
          )
          :
          ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title: Text(list[index]['first_name']+' '+list[index]['last_name']),
                subtitle: Text(list[index]['id'].toString()),
                trailing: Text(list[index]['username']),
              );
            }
          )
    );
  }
}


class UserScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return UserFetchData();
  }
}
