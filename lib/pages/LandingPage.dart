import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';

class LandingPage extends StatefulWidget{
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
            image: AssetImage("assets/images/carwash.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(60.0, 50.0, 0.0, 0.0),
                child: Text(
                    'Car Wash Locator v.1.0',
                    style: TextStyle(
                        fontSize: 40.0, fontWeight: FontWeight.bold, foreground: Paint() ..color=Colors.black)
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
                child:
                new Divider(
                  color: Colors.black,
                  indent: 130,
                  endIndent: 130,
                  thickness: 2,
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(50.0, 450.0, 0.0, 0.0),
                  constraints: BoxConstraints(minWidth: 320),
//                    width: 180.0,
//                    height: 120.0,
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.lightGreen),
                    highlightedBorderColor: Colors.red,
                    color: Colors.amberAccent,
                    shape: StadiumBorder(),
                    child: Text('SIGNUP',style: TextStyle(fontSize: 25,foreground: Paint() ..color=Colors.black)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                    },
                  )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150.0, 510.0, 0.0, 0.0),
                child: Text(
                    'OR SKIP',
                    style: TextStyle(
                        fontSize: 18.0, foreground: Paint() ..color=Colors.black38)
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(50.0, 540.0, 0.0, 0.0),
                  constraints: BoxConstraints(minWidth: 320),
//                    width: 180.0,
//                    height: 120.0,
                  child: OutlineButton(
                    borderSide: BorderSide(color: Colors.white),
                    highlightedBorderColor: Colors.red,
                    color: Colors.amberAccent,
                    shape: StadiumBorder(),
                    child: Text('LOGIN',style: TextStyle(fontSize: 25,foreground: Paint() ..color=Colors.black)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
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