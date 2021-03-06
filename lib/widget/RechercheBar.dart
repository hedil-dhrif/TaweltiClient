import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tawelticlient/recherche/filter.dart';
import 'package:tawelticlient/recherche/filtrage.dart';

import '../constants.dart';

class RechercherBar extends StatelessWidget {
  final TextEditingController editingController;
  final Function changed;

  RechercherBar({Key key, this.changed,this.editingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.75,
         padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: TextField(
            controller: editingController,
            onChanged: changed,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(
                color: KBlue,
                fontSize: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: KBlue, width: 1),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: KBlue,
                size: 24,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {

          },
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.pin_drop,
              size: 30,
              color: KBlue,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => FilterPage()));
          },
          child: Image.asset(
            'assets/filtre.png',
            height: 25,
            width: 25,
          ),
        )
      ],
    );
  }
}
