import 'package:flutter/material.dart';

import '../constants.dart';

class DisabledInputBox extends StatefulWidget {
  String label;
  String inputHint;
  Color color;
  TextEditingController controller;

  DisabledInputBox({this.label, this.inputHint, this.color,this.controller});
  @override
  _DisabledInputBoxState createState() => _DisabledInputBoxState();
}

class _DisabledInputBoxState extends State<DisabledInputBox> {
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
                fontSize: 20,
                color: Color(0xff8f9db5),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: widget.color , width: 1),
            ),
            child: TextFormField(
              enabled: false,
              controller: widget.controller,
              style: TextStyle(
                  fontSize: 20,
                  color: KBlue,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                enabled: true,
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
                    color: Colors.grey[350],
                  ),
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
