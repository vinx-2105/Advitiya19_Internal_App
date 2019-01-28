import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';


class CAFetchData extends StatefulWidget {
  @override
  _CAFetchDataState createState() => _CAFetchDataState();
}
class _CAFetchDataState extends State<CAFetchData> {
  //two variables
  List list = List();
  var isLoading = false;
  //fetch the CA data from the API

  _callCA(String phone) async {
  
  String url = "tel://"+phone;
  try{

  
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $phone';
    }
  }
  catch(e){
    print(e);
  }
}

  _fetchCA() async {
    setState(() {
      isLoading = true;
    });
    try{

      final response =
          await http.get("http://advitiya.in/cr/api/tc/collegerep/?limit=0&json=true&api_key=0f6a90934a3b8991679dd986ab3e287a76bf5927&username=advitiya");
      if (response.statusCode == 200) {
        
        list = json.decode(response.body)['objects'] as List;
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load CA');
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
        title: Text("Advitiya-19 Campus Ambassadors"),
      ),

      bottomNavigationBar: Padding(
        padding:const EdgeInsets.all(8.0),
        child: RaisedButton(
          child: Text("Fetch Campus Ambassadors"),
          onPressed: _fetchCA,
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
                leading: IconButton(
                  icon: Icon(Icons.call),
                  onPressed:()=> _callCA(list[index]['phone']),
                ),
                title: Text(list[index]['college']),
                subtitle: Text(list[index]['phone']),
                trailing: Text(list[index]['user']),
              );
            }
          )
    );
  }
}


class CAScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return CAFetchData();
  }
}
