import 'package:flutter/material.dart';
import 'HomePage.dart';
class CarWashList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Text('car Wash 1'),
              ),
              ListTile(
                title: Text('car Wash 2'),
              ),
              ListTile(
                title: Text('car Wash 3'),
              ),
              ListTile(
                title: Text('car Wash 4'),
              ),
              ListTile(
                title: Text('car Wash 5'),
              ),
              ListTile(
                title: Text('car Wash 6'),
              ),
              ListTile(
                title: Text('car Wash 7'),
              ),
              ListTile(
                title: Text('car Wash 8'),
              ),
              ListTile(
                title: Text('car Wash 9'),
              ),
              ListTile(
                title: Text('car Wash 10'),
              ),
              ListTile(
                title: Text('car Wash 11'),
              ),
            ],
          ).toList(),
        )
    );
  }
}