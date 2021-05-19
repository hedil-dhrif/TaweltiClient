import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/widget/DisabledInputbox.dart';

import '../constants.dart';
import 'ReservationList.dart';

class DetailReservation extends StatefulWidget {
  @override
  _DetailReservationState createState() => _DetailReservationState();
}

class _DetailReservationState extends State<DetailReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReservationtList()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Center(
            child: Text(
              'Detail reservation',
              style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w100),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.08),
            child: Divider(
              thickness: 2,
              color: KBeige,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              DisabledInputBox(
                label: 'Reservation code: ',
                inputHint: '123',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Guest name: ',
                inputHint: 'Jhon Doe',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Phone number: ',
                inputHint: '223698514',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Guest numbers: ',
                inputHint: '5',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Time: ',
                inputHint: '20:00',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Zone: ',
                inputHint: 'Outside',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Table number: ',
                inputHint: 'T20',
                color: KBlue,
              ),
              DisabledInputBox(
                label: 'Special request: ',
                inputHint: 'none',
                color: KBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
