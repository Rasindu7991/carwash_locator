import 'package:carwash_locator/pages/LandingPage.dart';
import 'package:carwash_locator/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carwash_locator/services/Authentication.dart';


class NavDrawer extends StatelessWidget {
//  NavDrawer({this.auth});
  NavDrawer({this.auth,this.username});
  final BaseAuth auth;
  String username;

    @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
              Text(
              'Car Wash Locator',
              style: TextStyle(color: Colors.white, fontSize: 27),
            ),
//                Text(
//                  username,
//                  style: TextStyle(color: Colors.blueAccent, fontSize: 25),
//                ),
              ],
            ),
//            child: Text(
//              'Car Wash Locator',
//              style: TextStyle(color: Colors.white, fontSize: 25),
//            ),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/carwash3.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.account_circle,size: 50,),
            title: Text(username,style: TextStyle(fontSize: 20),),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('About'),
            onTap: (){
              Navigator.of(context).pushReplacement(
                  new MaterialPageRoute(builder: (BuildContext context) => new LoginPage())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (){
                showAlertDialog(context);
            }
          ),
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context){
      Widget yesButton= FlatButton(
        child: Text('Yes'),
        onPressed: () async {
          await auth.signOut();
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (BuildContext context) => new LandingPage(auth: this.auth,))
          );
        },
      );
      Widget noButton= FlatButton(
        child: Text('No'),
        onPressed: (){
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      );
      AlertDialog alert =AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you want to sign out?'),
        actions: <Widget>[yesButton,noButton],
      );
      showDialog(
        context: context,
        builder: (BuildContext bcontext){
          return alert;
        },
      );
    }


}