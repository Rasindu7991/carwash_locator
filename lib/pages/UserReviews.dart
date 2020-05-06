/*
IT17051644- ILLANDARA T.S - Delete Reviews
IT17006644 - DAYASENA B.R.D -Update Reviews
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../listModel/ReviewModel.dart';
import 'StarRating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserReviews extends StatefulWidget {
  UserReviews({Key key}) : super(key: key);

  @override
  _UserReviewsState createState() => _UserReviewsState();
}

class _UserReviewsState extends State<UserReviews> {
  //initializing the variables
  double rating = 3.0;
  String name, description, date;
  String userId;

  //FireBase user object to set the currently logged in user.
  FirebaseUser user;


  _UserReviewsState() {
    super.initState();
    getUserData();
  }

/*This function is used to get the currently logged in users instance and set
 it to the previously created FireBaseUser Object
 */
  Future<void> getUserData() async {
    FirebaseUser userdata = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userdata;
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
        body: StreamBuilder(                                   //Stream builder is used to initialize firebase instance
            stream: Firestore.instance
                .collection('reviews')
                .where("id", isEqualTo: user.uid)
                .snapshots(),                                  // Getting all records belonging to logged in user
            builder: (context, snapshot) {
              if (snapshot.data == null) return CircularProgressIndicator();            //check for null values
              return ListView.builder(                                                  // initializing listview
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot myReviews = snapshot.data.documents[index];
                    double ratingdb = myReviews['rating'].toDouble();                   //converting rating value from database to double value
                    FullScreenDialog _myDialog = new FullScreenDialog(                 //initializing fullscreen dialog object
                      reviews: myReviews,
                      rating: ratingdb,
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: Card(                                                    //card view
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Row(
                                              children:
                                                  _stars((ratingdb.toInt()))),
                                        ),
                                        Text('${myReviews['date']}')
                                      ],
                                    ),
                                  ),
                                  Text('${myReviews['description']}'),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(                                               //update button. When it is clicked the fullscreendialog widget is used.
                                        onPressed: () => Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  _myDialog,
                                              fullscreenDialog: true,
                                            )),
                                        child: Text('Update',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 8),
                                      FlatButton(                               // Delete Button
                                        onPressed: () => deleteData(myReviews),
                                        child: Text('Delete'),
                                        color: Colors.red,
                                      ),
                                    ],
                                  )
                                ],
                              ))),
                    );
                  });
            }));
  }
}

//this function is used to generate the stars for the Rating value
List<Container> _stars(int count) {
  return List.generate(
          count,
          (i) => Container(
              child: Icon(FontAwesomeIcons.solidStar,
                  color: Colors.amber, size: 13.0)))
      .toList(); //
}

//This function is used to Update the user Reviews Data in the FireStore Database
void updateData(DocumentSnapshot doc, String description, double rating) async {
  final db = Firestore.instance;
  int ratingInt = rating.toInt();
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  String dateString = date.toString();
  await db.collection('reviews').document(doc.documentID).updateData(
      {'description': description, 'date': dateString, 'rating': ratingInt});
}
//This function is used to delete the selected user review
void deleteData(DocumentSnapshot doc) async {
  final db = Firestore.instance;
  await db.collection('reviews').document(doc.documentID).delete();
  // setState(() => id = null);
}

//FullScreenDialog to perform the Update Function
//review snapshots from firebase are sent to this widget
class FullScreenDialog extends StatefulWidget {
  final DocumentSnapshot reviews;
  double rating;

  FullScreenDialog({Key key, @required this.reviews, this.rating})
      : super(key: key);

  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}
//This class defines the interface that updates user reviews
class FullScreenDialogState extends State<FullScreenDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _skillTwoController =
        new TextEditingController(text: widget.reviews['description']);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Update your review"),
        ),
        body: new Padding(
          child: new ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(115.0, 25.0, 0.0, 10.0),
                child: StarRating(
                  rating: widget.rating, //widget.reviews['rating'].toDouble()
                  onRatingChanged: (rating) =>
                      setState(() => widget.rating = rating),
                ),
              ),
              new TextField(
                  controller: _skillTwoController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null),
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: new RaisedButton(
                    onPressed: () {
                      String description = _skillTwoController.text;
                      updateData(widget.reviews, description, widget.rating);
                      Navigator.pop(context);
                    },
                    child: new Text("Save"),
                  ))
                ],
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
        ));
  }
}
