import 'package:flutter/material.dart';


class SignUpPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration (image: DecorationImage(
                image: AssetImage('assets/images/signup.jpg'),
                fit: BoxFit.fill
            )
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(60.0, 40.0, 0.0, 0.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/logo.jpg'),
                    ),
                    Text(
                      "  CarWash Locator v.1.0",
                      style: TextStyle(
                        fontSize: 23.0, foreground: Paint() ..color=Colors.black
                        ,fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minWidth: 350.0),
                padding: EdgeInsets.fromLTRB(10.0, 130.0, 0.0, 0.0),
                child: FlatButton.icon(
                  shape: StadiumBorder(),
                  color: Colors.blue,
                  icon: Image.asset('assets/images/facebook48.png'), //`Icon` to display
                  label: Text('Login With Facebook'), //`Text` to display
                  onPressed: () {
                    //Code to execute when Floating Action Button is clicked
                    //...
                  },
                ),
              ),
              Container(
                constraints: BoxConstraints(minWidth: 350.0),
                padding: EdgeInsets.fromLTRB(10.0, 190.0, 0.0, 0.0),
                child: FlatButton.icon(
                  shape: StadiumBorder(),
                  color: Colors.white70,
                  icon: Image.asset('assets/images/google48.png'), //`Icon` to display
                  label: Text('Login With Google'), //`Text` to display
                  onPressed: () {
                    //Code to execute when Floating Action Button is clicked
                    //...
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(170.0, 250.0, 0.0, 0.0),
                child: Text(
                    'OR',
                    style: TextStyle(
                        fontSize: 20.0, foreground: Paint() ..color=Colors.white)
                ),
              ),

              Container(
                width: 340,
                padding: EdgeInsets.fromLTRB(23.0, 280.0, 0.0, 0.0),
                child:TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
//    icon: Icon(Icons.person),
                    prefixIcon: Icon(Icons.email),
                  ),
                ) ,
              ),
              Container(
                width: 340,
                padding: EdgeInsets.fromLTRB(23.0, 335.0, 0.0, 0.0),
                child:TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
//    icon: Icon(Icons.person),
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ) ,
              ),
              Container(
                width: 340,
                padding: EdgeInsets.fromLTRB(23.0, 390.0, 0.0, 0.0),
                child:TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Re-Enter Password",
                    filled: true,
                    fillColor: Colors.white,
//    icon: Icon(Icons.person),
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ) ,
              ),
              Container(
                constraints: BoxConstraints(minWidth: 320.0,minHeight: 220.0),
                padding: EdgeInsets.fromLTRB(50.0, 450.0, 0.0, 0.0),
                child: FlatButton(
                  shape: StadiumBorder(),
                  color: Colors.deepPurple,
                  child: Text('SignUp',style: TextStyle(fontSize: 22,foreground: Paint() ..color=Colors.white)), //`Text` to display
                  onPressed: () {
                    //Code to execute when Floating Action Button is clicked
                    //...
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

