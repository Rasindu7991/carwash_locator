import 'package:flutter/material.dart';
import '../listModel/ReviewModel.dart';
import 'StarRating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyReviews extends StatefulWidget{
  @override
  _MyReviewsState createState() => _MyReviewsState();

}

class _MyReviewsState extends State<MyReviews> {

  double rating = 3.5;

  List<ReviewModel> reviews = [

    ReviewModel(name: 'Hohn Wick', description: "Great app.Performance is very good",rating: 4, date: '2019-08-21'),
    ReviewModel(name: 'soup112', description: "Bad App. slow and low performernce.Takes too much battery",rating: 2, date: '2019-07-21'),
    ReviewModel(name: 'Ninjas', description: "Great app.Can Manage task very easily. Low cost too.",rating: 5, date: '2019-08-25'),
    ReviewModel(name: 'catanddog', description: "The app is okay but could use more features and improvments",rating: 3, date: '2019-06-15'),
  ];




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
      body:Column(
        children: <Widget> [
          Expanded(
            flex: 7,
            child:ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: reviews.length,
                itemBuilder: (context, index) {
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

                                      Text( '${reviews[index].name}')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Row(children: _stars(reviews[index].rating)),
                                      ),

                                      Text('${reviews[index].date}')
                                    ],
                                  ),
                                ),
                                Text('${reviews[index].description}')
                              ],
                            ))

                    ),
                  );
                }
            ),
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
                      padding: EdgeInsets.fromLTRB(135.0, 25.0, 0.0, 0.0),
                      child: StarRating(
                        rating: rating,
                        onRatingChanged: (rating) => setState(() => this.rating = rating),
                      ),
                    ),

                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write Review'
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: RaisedButton(
                        color:  Colors.blue,
                        child: Text('Submit', style: TextStyle(color: Colors.white),),
                        onPressed: () {},

                      ),
                    )


                  ],
                ),
              ),
          )
        )


        ]
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

