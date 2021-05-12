import 'package:flutter/material.dart';

import '../constants.dart';

class RestaurantCard extends StatefulWidget {

  final String image;
  final String title;
  final String soustitle;
  final Function choose;

  const RestaurantCard({Key key, this.image, this.title, this.choose, this.soustitle}) : super(key: key);


  @override
  _RestaurantCardState createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.25,
      width: MediaQuery.of(context).size.width*0.45,
      decoration: BoxDecoration(
          color: Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.45,
            height: MediaQuery.of(context).size.height*0.125,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15)
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: KBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.soustitle,
                  style: TextStyle(
                    color: KBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
