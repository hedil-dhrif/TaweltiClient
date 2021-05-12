import 'package:flutter/material.dart';

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double bottomradious;
  final double topradious;
  final Function press;
  final Color textcolor;
  final Color conatinercolor;

  const TwoSideRoundedButton({
    Key key,
    this.text,
    this.bottomradious,
    this.press,
    this.topradious,
    this.textcolor,
    this.conatinercolor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: conatinercolor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(bottomradious),
            topLeft: Radius.circular(topradious),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: textcolor,
            fontSize: 20
          ),
        ),
      ),
    );
  }
}