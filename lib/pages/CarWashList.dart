//IT17051644- ILLANDARA T.S

import 'package:carwash_locator/pages/CarwashDirection.dart';
import 'package:carwash_locator/pages/MyReviews.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../listModel/ListModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarWashList extends StatefulWidget {                             //carwashlist is a stateful widget
  @override
  _CarWashListState createState() => _CarWashListState();
}

class _CarWashListState extends State<CarWashList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose a Location'),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder(                                                    // Stream builder is used to stream a firebase instance
          stream: Firestore.instance.collection('carwashlist').snapshots(),     // snapshots related to carwashlist collection are retrieved from the DB
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              const Text('Loading');
              return null;
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,                    //no of snapshots
                  itemBuilder: (context, index) {
                    DocumentSnapshot myShopList =
                        snapshot.data.documents[index];                         //snapshot belonging to each index
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: Card(                                                      //each item in the list contains a card
                        child: CustomListItem(                                          // the card contains a custom layout which gets called for each index and snapshot details are sent to this.
                          shopid: myShopList['shopid'],
                          location: myShopList['location'],
                          rating: myShopList['rating'],
                          thumbnail: Container(
                              child: Image.asset(
                            'assets/images/${myShopList['image']}',
                          )),
                          shopName: myShopList['name'],
                        ),
                      ),
                    );
                  });
            }
          },
        ));
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem(
      {this.thumbnail, this.shopName, this.location, this.rating, this.shopid});              // initialize snapshots data in the customlistitem class

  final Widget thumbnail;
  final String shopName;
  final String location;
  final int rating;
  final String shopid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(                                                         //child widget to display the shop image
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _ShopDescription(                                        //custom layout to show the shop details
              shopid: shopid,
              shopName: shopName,
              location: location,
              rating: rating,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopDescription extends StatelessWidget {                              //custom layout class to show the shop details
  const _ShopDescription({
    Key key,
    this.shopid,
    this.shopName,
    this.location,
    this.rating,
  }) : super(key: key);

  final String shopName;
  final String location;
  final int rating;
  final String shopid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            shopName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            location,
            style: const TextStyle(fontSize: 20.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Row(
            children: <Widget>[
              Text(
                'Rating - ',
                style: const TextStyle(fontSize: 15.0),
              ),
              Row(children: _stars(rating))                                      //rating bar
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                //child: Padding(
                //padding: const EdgeInsets.only(left: 4.0),
                child: RaisedButton(                                               //button to check shop reviews
                  child: Text(
                    "Review",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyReviews(shopid: shopid)));
                  },
                  color: Colors.blue,
                ),
                // ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RaisedButton(                                             //button to check directions for the shop
                    child: Text(
                      "Directions",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CarwashDirection(
                                    shopid: shopid,
                                    shopname: shopName,
                                  )));
                    },
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
//function to initialize rating bar
List<Container> _stars(int count) {
  return List.generate(
          count,
          (i) => Container(
              child: Icon(FontAwesomeIcons.solidStar,
                  color: Colors.amber, size: 13.0)))
      .toList(); // replace * with your rupee or use Icon instead
}
