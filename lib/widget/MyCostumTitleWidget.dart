import 'package:flutter/material.dart';

class MyCostumTitle extends StatefulWidget {

  // ignore: non_constant_identifier_names
  String MyTitle;
  double size;
  MyCostumTitle({this.MyTitle, this.size});

  @override
  _MyCostumTitleState createState() => _MyCostumTitleState();
}

class _MyCostumTitleState extends State<MyCostumTitle> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        widget.MyTitle,
        style: TextStyle(
            color: Color(0xFFAF8F61),
            fontSize: widget.size,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
