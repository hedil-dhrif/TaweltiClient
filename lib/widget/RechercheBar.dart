import 'dart:async';

import 'package:flutter/material.dart';
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
          width: MediaQuery.of(context).size.width * 0.85,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Filtrage()));
          },
          child: Image.asset(
            'assets/filtre.png',
            height: 24,
            width: 24,
          ),
        )
      ],
    );
  }
}
