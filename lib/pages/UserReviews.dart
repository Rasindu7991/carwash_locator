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
                                                  child: Row(children: _stars((reviews[index].rating))),
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

void updateData(DocumentSnapshot doc,String description) async {
  final db = Firestore.instance;
  await db.collection('reviews').document(doc.documentID).updateData({'description': description});
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

  final DocumentSnapshot reviews;

  FullScreenDialog({Key key, @required this.reviews}) : super(key: key);


  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  TextEditingController _skillOneController = new TextEditingController();
  TextEditingController _skillTwoController = new TextEditingController();

  TextEditingController _skillThreeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Update your review"),
        ),
        body: new Padding(child: new ListView(
          children: <Widget>[
            new TextField(controller: _skillOneController,),
            new TextField(controller: _skillTwoController,),
            new TextField(controller: _skillThreeController,),
            new Row(
              children: <Widget>[
                new Expanded(child: new RaisedButton(onPressed: () {
//                  widget._skillThree = _skillThreeController.text;
//                  widget._skillTwo = _skillTwoController.text;
//                  widget._skillOne = _skillOneController.text;
                  String description = _skillOneController.text + _skillTwoController.text + _skillThreeController.text;
                  updateData(widget.reviews, description );
                  Navigator.pop(context);
                }, child: new Text("Save"),))
              ],
            )
          ],
        ), padding: const EdgeInsets.symmetric(horizontal: 20.0),)
    );
  }


}