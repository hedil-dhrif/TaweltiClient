import 'package:flutter/material.dart';

class ImageBox extends StatefulWidget {
  @override
  _ImageBoxState createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/events.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
