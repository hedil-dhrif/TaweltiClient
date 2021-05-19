import 'package:flutter/material.dart';

import '../constants.dart';
class RoundedButton extends StatefulWidget {

  final Function ontap;
  final String text;
  final String image;

  const RoundedButton({Key key, this.ontap, this.text, this.image});

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width*0.65,
        height: MediaQuery.of(context).size.height*0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 1)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
