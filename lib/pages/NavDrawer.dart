/*
IT17006644 - DAYASENA B.R.D
REFERENCE - https://medium.com/flutter-community/flutter-vi-navigation-drawer-flutter-1-0-3a05e09b0db9
 */
import 'package:carwash_locator/pages/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:carwash_locator/services/Authentication.dart';

class NavDrawer extends StatelessWidget {
//  NavDrawer({this.auth});
  NavDrawer({this.auth, this.username});

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
                  style: TextStyle(color: Colors.black, fontSize: 27),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/navdrawerimage.jpg'))),
          ),
          ListTile(
            leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user.png'),
                radius: 26,
                backgroundColor: Colors.transparent),
            title: Text(
              username,
              style: TextStyle(fontSize: 20),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
              leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logout.png'),
                  radius: 26,
                  backgroundColor: Colors.transparent),
              title: Text('Logout', style: TextStyle(fontSize: 20)),
              onTap: () {
                showAlertDialog(context);
              }),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget yesButton = FlatButton(
      child: Text('Yes'),
      onPressed: () async {
        await auth.signOut();
        Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new LandingPage(
                  auth: this.auth,
                )));
      },
    );
    Widget noButton = FlatButton(
      child: Text('No'),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you want to sign out?'),
      actions: <Widget>[yesButton, noButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext bcontext) {
        return alert;
      },
    );
  }
}
