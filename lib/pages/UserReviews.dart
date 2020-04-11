import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../listModel/ReviewModel.dart';
import 'StarRating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserReviews extends StatefulWidget{

  UserReviews({Key key}) : super(key: key);

  @override
  _UserReviewsState createState() => _UserReviewsState();
}


class _UserReviewsState extends State<UserReviews> {

  double rating = 3.0;
  String name,description,date;
  String userId = "user123";


  List<ReviewModel> reviews = [

    ReviewModel(name: 'Hohn Wick', description: "Great app.Performance is very good",rating: 4, date: '2019-08-21'),
    ReviewModel(name: 'soup112', description: "Bad App. slow and low performernce.Takes too much battery",rating: 2, date: '2019-07-21'),
    ReviewModel(name: 'Ninjas', description: "Great app.Can Manage task very easily. Low cost too.",rating: 5, date: '2019-08-25'),
    ReviewModel(name: 'catanddog', description: "The app is okay but could use more features and improvments",rating: 3, date: '2019-06-15'),
  ];

  _UserReviewsState(){}

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
        body:StreamBuilder(
            stream: Firestore.instance.collection('reviews').where("id", isEqualTo: userId).snapshots(),
            builder: (context, snapshot){
//            if(!snapshot.hasData){
//              return Text('Loading');
//             }
//            else{
              if(snapshot.data == null) return CircularProgressIndicator();
              return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot myReviews = snapshot.data.documents[index];
                            int ratingdb = myReviews['rating'].toInt();
                            FullScreenDialog _myDialog = new FullScreenDialog(reviews: myReviews,);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                              child: Card(
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
                                                    padding: EdgeInsets.only(right: 8.0),
                                                    child: IconButton(
                                                      icon: Icon(Icons.android),
                                                      color: Colors.blue,
                                                      onPressed: () {},
                                                    )
                                                ),

                                                Text( '${myReviews['name']}')
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 8.0),
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(right: 8.0),
                                                  child: Row(children: _stars((ratingdb))),
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
                                              FlatButton(
                                                onPressed: () =>  Navigator.push(context, new MaterialPageRoute(
                                                  builder: (BuildContext context) => _myDialog,
                                                  fullscreenDialog: true,
                                                )),
                                                child: Text('Update', style: TextStyle(color: Colors.white)),
                                                color: Colors.green,
                                              ),
                                              SizedBox(width: 8),
                                              FlatButton(
                                                onPressed: () => deleteData(myReviews),
                                                child: Text('Delete'),
                                                color: Colors.red,
                                              ),
                                            ],
                                          )
                                        ],
                                      ))

                              ),
                            );
                          }
              );



              //}
            }

        )

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

void updateData(DocumentSnapshot doc,String description,double rating) async {
  final db = Firestore.instance;
  int ratingInt = rating.toInt();
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  String dateString = date.toString();
  await db.collection('reviews').document(doc.documentID).updateData({'description': description, 'date': dateString, 'rating': ratingInt});
}

void deleteData(DocumentSnapshot doc) async {
  final db = Firestore.instance;
  await db.collection('reviews').document(doc.documentID).delete();
 // setState(() => id = null);
}

class FullScreenDialog extends StatefulWidget {
  String _skillOne = "You have";
  String _skillTwo = "not Added";
  String _skillThree = "any skills yet";

  final  DocumentSnapshot reviews;

  FullScreenDialog({Key key, @required this.reviews}) : super(key: key);


  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {


   double rating = 4.0;

  @override
  Widget build(BuildContext context) {
    TextEditingController _skillTwoController = new TextEditingController(text: widget.reviews['description']);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Write your review"),
        ),
        body: new Padding(child: new ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(115.0, 25.0, 0.0, 10.0),
              child: StarRating(
                rating: rating ,  //widget.reviews['rating'].toDouble()
                onRatingChanged: (rating) => setState(() => this.rating = rating),
              ),
            ),
            new TextField(controller: _skillTwoController,keyboardType: TextInputType.multiline,maxLines: null),

            new Row(
              children: <Widget>[
                new Expanded(child: new RaisedButton(onPressed: () {

                  String description = _skillTwoController.text;
                  updateData(widget.reviews, description, rating);
                  Navigator.pop(context);
                }, child: new Text("Save"),))
              ],
            )
          ],
        ), padding: const EdgeInsets.symmetric(horizontal: 20.0),)
    );
  }


}


