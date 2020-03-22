import 'package:carwash_locator/pages/CarWashList.dart';
import 'package:carwash_locator/pages/MyReviews.dart';
import 'package:flutter/material.dart';
import 'CarWashList.dart';
import 'SearchCarWash.dart';

import 'dart:async';

class HomePage extends StatefulWidget{
  State createState()=>homePageState();
}


class homePageState extends State<HomePage>{
  int _selectedPage=0;
  final _pageOptions=[
    CarWashList(),
    SearchCarWash(),
    MyReviews(),
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
         title: Text('Carwash Locator'),
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