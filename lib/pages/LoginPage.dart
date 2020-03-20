import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        body: Container(
          child:Container(
              child: Container(
                child:Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
                      child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold, foreground: Paint() ..color=Colors.black)
                      ),
                    ),
                  ],
                ),
              )
          ),
        )
    );
  }
}