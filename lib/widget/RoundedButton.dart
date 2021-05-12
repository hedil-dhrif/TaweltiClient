import 'package:flutter/material.dart';

import '../constants.dart';

class RoundedButton extends StatefulWidget {

  final String text;

  const RoundedButton({Key key, this.text}) : super(key: key);

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.275,
      height: MediaQuery.of(context).size.height*0.05,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: KBeige, width: 1),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: KBlue,
            fontSize: 20
          ),
        ),
      ),
    );
  }
}
