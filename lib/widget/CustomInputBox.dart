import 'package:flutter/material.dart';
import 'package:tawelticlient/constants.dart';

class MyCustomInputBox extends StatefulWidget {
  String label;
  String inputHint;
  Color color;
  TextEditingController textController;

  MyCustomInputBox({this.label, this.inputHint, this.color, this.textController});
  @override
  _MyCustomInputBoxState createState() => _MyCustomInputBoxState();
}

class _MyCustomInputBoxState extends State<MyCustomInputBox> {
  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, bottom: 8),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Product Sans',
                fontSize: 15,
                color: Color(0xff8f9db5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: TextFormField(
            obscureText: widget.label == 'Password' ? true : false,
            onChanged: (value) {
              setState(() {
                isSubmitted = true;
              });
            },
            controller: widget.textController,
            style: TextStyle(
                fontSize: 20,
                color: KBlue,
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: widget.inputHint,
              hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w600),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              focusColor: widget.color,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: widget.color),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: widget.color,
                ),
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
