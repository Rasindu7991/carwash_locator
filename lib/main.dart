import 'package:carwash_locator/pages/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue, accentColor: Colors.white),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
