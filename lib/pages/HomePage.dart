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
  State createState()=>homePageState();
}


class homePageState extends State<HomePage>{
  String userName;
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
    getUserName();
  }


  Future<void> getUserName() async {
    FirebaseUser userdata= await FirebaseAuth.instance.currentUser();
    setState(() {
      userName=userdata.email;
    });
  }

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
       drawer: NavDrawer(auth : widget.auth, username: userName,),
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