import 'package:flutter/material.dart';

import 'package:flutter_rating/flutter_rating.dart';

class StarRatingWidget extends StatefulWidget {

  final double rating;

  const StarRatingWidget({super.key, required this.rating});

  @override

  _StarRatingWidgetState createState() => _StarRatingWidgetState();

}

class _StarRatingWidgetState extends State<StarRatingWidget> {


  int starCount = 5;

  @override

  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(

      width: size.width * .190,

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[

          Center(

            child: StarRating(

              size: 14,

              rating: widget.rating,

              color: Colors.orange,

              borderColor: Colors.grey,

              allowHalfRating: true,

              starCount: starCount,

              onRatingChanged: (rating) => setState(() {

              }),

            ),

          ),

        ],

      ),

    );

  }

}

