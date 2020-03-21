import 'package:flutter/material.dart';
import 'pages/LandingPage.dart';

void main(){
  runApp(new MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue,accentColor: Colors.white ),
    debugShowCheckedModeBanner: false,
    home: LandingPage(),
  ));
}

