import 'package:flutter/material.dart';

class MyReviews extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.directions_car, size: 50),
                title: Text('Car wash 1'),
                subtitle: Text('galle'),
                trailing: Text('good place!!!'),
              ),

              const ListTile(
                leading: Icon(Icons.directions_car, size: 50),
                title: Text('Car wash 2'),
                subtitle: Text('colombo'),
                trailing: Text('good place!!!'),
              ),

              const ListTile(
                leading: Icon(Icons.directions_car, size: 50),
                title: Text('Car wash 3'),
                subtitle: Text('kandy'),
                trailing: Text('good place!!!'),
              ),
            ],
          ),
        ),

    );
  }
}