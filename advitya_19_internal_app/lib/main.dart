import 'package:http/http.dart';
import 'package:flutter/material.dart';

Future<http.Response> fetchCollegeAmbassador() {
  return http.get('http://advitiya.in/cr/api/tc/collegerep/2/?format=json&api_key=0f6a90934a3b8991679dd986ab3e287a76bf5927&username=advitiya');
}

class CollegeAmbassador{
  final String college;
  final int user_num;
  final String past_xp;
  final String why_cr;
  final int points;
  final String phone;
  final String first_name;
  final String last_name;
  final String email;

  CollegeAmbassador({this.college, this.past_xp, this.phone, this.points, this.user_num, this.why_cr, this.email, this.first_name, this.last_name});

  factory CollegeAmbassador.fromJson(Map<String, dynamic> json) {
    return CollegeAmbassador(
      college: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}