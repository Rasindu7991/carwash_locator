import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'package:carwash_locator/services/Authentication.dart';


class LandingPage extends StatefulWidget{
  final BaseAuth auth;
  LandingPage({this.auth});
  State createState()=>landingPageState();
}


class landingPageState extends State<LandingPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "CARWASH LOCATOR",
                    style: TextStyle(color: Colors.blue,fontSize: 40.0),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(0.0, 135.0, 0.0, 0.0),
                child:
                new Divider(
                  color: Colors.white70,
                  indent: 110,
                  endIndent: 110,
                  thickness: 3,
                ),
              ),

              Container(
                  padding: EdgeInsets.fromLTRB(50.0, 540.0, 0.0, 0.0),
                  constraints: BoxConstraints(minWidth: 320),
//                    width: 180.0,
//                    height: 120.0,
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.white),
                    highlightedBorderColor: Colors.blueAccent,
                    color: Colors.blueAccent,
                    shape: StadiumBorder(),
                    child: Text('LOGIN/SIGNUP',style: TextStyle(fontSize: 25,foreground: Paint() ..color=Colors.white)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(auth: widget.auth)));
                    },
                  )
              )
            ],
          ),
        ) /* add child content here */,
      ),
    );
  }
}