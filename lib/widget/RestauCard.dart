import 'package:flutter/material.dart';

import '../constants.dart';

class RestauCard extends StatefulWidget {

  final String image;
  final String title;
  final Function choose;

  const RestauCard({Key key, this.image, this.title, this.choose}) : super(key: key);


  @override
  _RestauCardState createState() => _RestauCardState();
}

class _RestauCardState extends State<RestauCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
      width: MediaQuery.of(context).size.width*0.275,
      decoration: BoxDecoration(
        color: KBlue,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.25,
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15)
            ),
          ),
          Text(
              widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.5,
            ),
          ),
        ],
      ),
    );
  }
}
