//IT17051644- ILLANDARA T.S
//View shop Reviews and add new review
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../listModel/ReviewModel.dart';
import 'StarRating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyReviews extends StatefulWidget {
  final String shopid;

  MyReviews({Key key, @required this.shopid}) : super(key: key);

  @override
  _MyReviewsState createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
  //initializing variables
  double rating = 3.0;
  String name, description, date;
  String uid;
  FirebaseUser user;

  _MyReviewsState() {
    super.initState();
    getUserData();
  }

  getDescription(description) {
    this.description = description;
  }
//get current user data
  Future<void> getUserData() async {
    FirebaseUser userdata = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userdata;
    });
  }

//function to create new shop review
  createData() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    String dateString = date.toString();
    DocumentReference ds =
        Firestore.instance.collection('reviews').document(name);
    Map<String, dynamic> reviewmap = {
      "name": "user",
      "description": description,
      "rating": rating,
      "id": user.uid,
      "date": dateString,
      "shopid": widget.shopid
    };

    ds.setData(reviewmap).whenComplete(() {
      print("review created");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Ratings and Reviews'),
          centerTitle: true,
          elevation: 0,
        ),
        body: StreamBuilder(                   //Stream builder is used to initialize firebase instance
            stream: Firestore.instance
                .collection('reviews')
                .where("shopid", isEqualTo: widget.shopid)
                .snapshots(),                                //retrieve shop reviews of selected shop from db
            builder: (context, snapshot) {
//            if(!snapshot.hasData){
//              return Text('Loading');
//             }
//            else{
              if (snapshot.data == null) return CircularProgressIndicator();
              return Column(children: <Widget>[
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.documents.length,           //snapshot count
                      itemBuilder: (context, index) {
                        DocumentSnapshot myReviews =                      //snapshots of each index
                            snapshot.data.documents[index];
                        int ratingdb = myReviews['rating'].toInt();           //convert rating from db to int
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 4.0),
                          child: Card(                                            //card view for each shop review
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 4.0),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8.0),
                                                child: IconButton(
                                                  icon: Icon(Icons.android),
                                                  color: Colors.blue,
                                                  onPressed: () {},
                                                )),
                                            Text('${myReviews['name']}')
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Row(
                                                  children: _stars((ratingdb))),
                                            ),
                                            Text('${myReviews['date']}')
                                          ],
                                        ),
                                      ),
                                      Text('${myReviews['description']}')
                                    ],
                                  ))),
                        );
                      }),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(135.0, 25.0, 0.0, 0.0),
                              child: StarRating(                                     //Rate the shop
                                rating: rating,
                                onRatingChanged: (rating) =>
                                    setState(() => this.rating = rating),
                              ),
                            ),
                            TextField(                                              //write a review
                              onChanged: (String description) {
                                getDescription(description);
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write Review'),
                            ),
                            Padding(                                              //submit review
                              padding: EdgeInsets.only(top: 25.0),
                              child: RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  createData();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ]);
              //}
            }));
  }
}

List<Container> _stars(int countdb) {                                     //initialize rating bar
  //int count = countdb.toInt();
  return List.generate(
          countdb,
          (i) => Container(
              child: Icon(FontAwesomeIcons.solidStar,
                  color: Colors.amber, size: 13.0)))
      .toList(); // replace * with your rupee or use Icon instead
}
