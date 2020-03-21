import 'package:flutter/material.dart';
import 'HomePage.dart';
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
                      width: 340,
                      padding: EdgeInsets.fromLTRB(23.0, 100.0, 0.0, 0.0),
                      child:TextField(
                        style: new TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.blueAccent,
//    icon: Icon(Icons.person),

                          prefixIcon: Icon(Icons.email),
                        ),
                      ) ,
                    ),
                    Container(
                      width: 340,
                      padding: EdgeInsets.fromLTRB(23.0, 150.0, 0.0, 0.0),
                      child:TextField(
                        style: new TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.blueAccent,
//    icon: Icon(Icons.person),
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                      ) ,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(100.0, 200.0, 0.0, 0.0),
                      child: Text(
                          'Not Have Account? Sign up',
                          style: TextStyle(
                              fontSize: 17.0, foreground: Paint() ..color=Colors.black)
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(minWidth: 320.0,minHeight: 220.0),
                      padding: EdgeInsets.fromLTRB(50.0, 250.0, 0.0, 0.0),
                      child: FlatButton(
                        shape: StadiumBorder(),
                        color: Colors.deepPurple,
                        child: Text('Login',style: TextStyle(fontSize: 22,foreground: Paint() ..color=Colors.white)), //`Text` to display
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        },
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