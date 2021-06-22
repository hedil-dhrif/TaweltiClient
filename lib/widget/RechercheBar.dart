import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tawelticlient/recherche/filtrage.dart';

import '../constants.dart';

class RechercherBar extends StatelessWidget {
  final TextEditingController editingController = TextEditingController();
  final Function changed;

  RechercherBar({Key key, this.changed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: TextField(
            controller: editingController,
            onChanged: changed,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(
                color: KBlue,
                fontSize: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: KBlue, width: 1),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: KBlue,
                size: 30,
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
            height: 40,
            width: 40,
          ),
        )
      ],
    );
  }
}
