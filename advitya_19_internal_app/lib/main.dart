import 'package:flutter/material.dart';
import 'package:advitya_19_internal_app/ca.dart';
import 'package:advitya_19_internal_app/user.dart';



class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Advitiya-19 Internal'),
      ),
      body: Center(
        child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Users'),
            onPressed: (){
              Navigator.pushNamed(context, '/user');
            },
          ),
          RaisedButton(
            child: Text('Campus Ambassadors'),
            onPressed: (){
              Navigator.pushNamed(context, '/ca');
            },
          )
        ],
      ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Advitiya-19 Internal',
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => HomeScreen(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/ca': (context) => CAScreen(),
      '/user':(context) =>UserScreen(),
    },
  ));
}

