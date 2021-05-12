import 'package:flutter/material.dart';

class SubmiButton extends StatefulWidget {
  const SubmiButton({
    Key key,
    @required this.scrWidth,
    @required this.scrHeight,
    @required this.size,
    @required this.tap,
    @required this.title,
    @required this.color,
    @required this.bcolor,
  }) : super(key: key);

  final double scrWidth;
  final double scrHeight;
  final double size;
  final Function tap;
  final String title;
  final Color color;
  final Color bcolor;

  @override
  _SubmiButtonState createState() => _SubmiButtonState();
}

class _SubmiButtonState extends State<SubmiButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.tap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: widget.scrWidth * 0.8,
        height: widget.scrHeight*0.08,
        decoration: BoxDecoration(
          color: widget.bcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: widget.size,
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
