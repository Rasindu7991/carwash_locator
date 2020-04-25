import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'LandingPage.dart';
import 'dart:async';
import 'package:carwash_locator/services/Authentication.dart';

enum AuthStatus{
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN
}

class SplashScreen extends StatefulWidget{
  final BaseAuth auth;
  SplashScreen({this.auth});
  State createState()=>SplashScreenState();
}


class SplashScreenState extends State<SplashScreen>{
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((user){
      setState(() {
        if(user!=null){
          _userId=user?.uid;
        }
        authStatus=user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });

  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }
  Widget buildWaitingScreen() {
      return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50.0,
                            child: Icon(
                              Icons.directions_car,
                              color: Colors.blue,
                              size: 50.0,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10.0),
                          ),
                          Text(
                            "CarWash Locator v.1",
                            style: TextStyle(color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        Text(
                          "one click! locate car wash!!",
                          style: TextStyle(color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          )
      );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LandingPage(auth: widget.auth,);
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(auth: widget.auth,);
        } else
          return  buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}