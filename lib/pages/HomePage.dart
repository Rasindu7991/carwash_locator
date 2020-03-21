
import 'package:carwash_locator/pages/LandingPage.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'LandingPage.dart';

import 'dart:async';

class HomePage extends StatefulWidget{
  State createState()=>homePageState();
}


class homePageState extends State<HomePage>{
  int _selectedPage=0;
  final _pageOptions=[
    LoginPage(),
    LandingPage(),
    SignUpPage(),
  ];

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), ()=>print("Timeout"));
  }

  @override
  Widget build(BuildContext context) {
   return MaterialApp (
     title: 'Carwash Locator',
     theme:ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: Scaffold(
       appBar: AppBar(
         title: Text('Home'),
       ),
       body: _pageOptions[_selectedPage],
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: _selectedPage,
         onTap: (int index){
           setState(() {
             _selectedPage=index;
           });
         },
         items: [
           BottomNavigationBarItem(
               icon: Icon(Icons.home),
               title: Text('Home')
           ),
           BottomNavigationBarItem(
               icon: Icon(Icons.work),
               title: Text('Work')
           ),
           BottomNavigationBarItem(
               icon: Icon(Icons.laptop),
               title: Text('Lap')
           ),
         ],
       ) ,
     ),
   );

  }
}