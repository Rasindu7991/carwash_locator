import 'package:carwash_locator/pages/SpalshScreen.dart';
import 'package:flutter/material.dart';
import 'pages/SpalshScreen.dart';

void main(){
  runApp(new MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue,accentColor: Colors.white ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

