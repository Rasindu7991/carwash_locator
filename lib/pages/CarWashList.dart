import 'package:carwash_locator/pages/CarwashDirection.dart';
import 'package:carwash_locator/pages/MyReviews.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../listModel/ListModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CarWashList extends StatefulWidget {
  @override
  _CarWashListState createState() => _CarWashListState();
}

class _CarWashListState extends State<CarWashList> {

  List<ListModel> locations = [

    ListModel(shopName: 'Shop A', location: 'Pita Kotte', rating: 3, icon: 'carwash1.jpg'),
    ListModel(shopName: 'Shop B', location: 'Koswatta', rating: 5, icon: 'carwash2.jpg'),
    ListModel(shopName: 'Shop C', location: 'Malabe', rating: 4, icon: 'carwash3.jpg'),
    ListModel(shopName: 'Shop D', location: 'Maharagama', rating: 2, icon: 'carwash4.jpg'),
  ];

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
      body: StreamBuilder(
        stream: Firestore.instance.collection('carwashlist').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            const Text('Loading');
            return null;
          }
          else{
            return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot myShopList = snapshot.data.documents[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      child: CustomListItem(
                        shopid: myShopList['shopid'],
                        location: myShopList['location'],
                        rating: myShopList['rating'],
                        thumbnail: Container(
                            child:  Image.asset(
                              'assets/images/${myShopList['image']}',

                            )
                        ),
                        shopName: myShopList['name'],
                      ),
                    ),
                  );
                }
            );
          }
        },
      )
    );
  }

}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    this.thumbnail,
    this.shopName,
    this.location,
    this.rating,
    this.shopid
  });

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
          Expanded(
            flex: 2,
            child:thumbnail ,
          ),
          Expanded(
            flex: 3,
            child: _ShopDescription(
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

class _ShopDescription extends StatelessWidget {
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
          Row(children: <Widget>[
            Text(
              'Rating - ',
              style: const TextStyle(fontSize: 15.0),
            ),
             Row(children: _stars(rating))
          ],),
          Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //child: Padding(
                      //padding: const EdgeInsets.only(left: 4.0),
                      child: RaisedButton(
                        child: Text("Review", style: TextStyle(color: Colors.white),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyReviews(shopid: shopid )));
                        },
                        color: Colors.blue,
                      ),
                   // ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: RaisedButton(
                        child: Text("Directions", style: TextStyle(color:  Colors.white),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CarwashDirection(shopid:shopid,shopname:shopName,)));
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

List<Container> _stars(int count) {
  return List.generate(count, (i) => Container(
      child: Icon(
    FontAwesomeIcons.solidStar,
        color: Colors.amber,
    size: 13.0))).toList(); // replace * with your rupee or use Icon instead
}
