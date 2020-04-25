import 'package:carwash_locator/pages/CarWashList.dart';
import 'package:carwash_locator/pages/MyReviews.dart';
import 'package:carwash_locator/pages/NavDrawer.dart';
import 'package:carwash_locator/pages/UserReviews.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CarWashList.dart';
import 'SearchCarWash.dart';
import 'package:carwash_locator/services/Authentication.dart';


import 'dart:async';

class HomePage extends StatefulWidget{
  HomePage({this.auth});

  final BaseAuth auth;
  String userName;
  State createState()=>homePageState();
}


class homePageState extends State<HomePage>{
  int _selectedPage=0;
  final _pageOptions=[
    CarWashList(),
    SearchCarWash(),
    UserReviews(),
  ];

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), ()=>print("Timeout"));
//    setUserName();
  }
//
//  setUserName() async {
//    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    widget.userName=user.uid.toString();
//  }

  @override
  Widget build(BuildContext context) {
   return MaterialApp (
     debugShowCheckedModeBanner: false,
     title: 'Carwash Locator',
     theme:ThemeData(
       primarySwatch: Colors.blue,
     ),
     home: Scaffold(
       appBar: AppBar(
         title: Text('Carwash Locator'),
       ),
       body: _pageOptions[_selectedPage],
       drawer: NavDrawer(auth : widget.auth),
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
               icon: Icon(Icons.map),
               title: Text('Search')
           ),
           BottomNavigationBarItem(
               icon: Icon(Icons.rate_review),
               title: Text('My Reviews')
           ),
         ],
       ) ,
     ),
   );

  }
}