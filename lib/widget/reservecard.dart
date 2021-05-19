import 'package:flutter/material.dart';
import 'package:tawelticlient/reservation/AddReservation.dart';
import 'package:tawelticlient/reservation/DetailsReservation.dart';

import '../constants.dart';
import 'TowSidedRoundedButton.dart';

class ReservationCard extends StatefulWidget {
  final String titre2;
  final String titre3;
  final String titre4;
  final String titre5;
  final String titre1;

  const ReservationCard({Key key, this.titre2, this.titre3, this.titre4, this.titre5, this.titre1}) : super(key: key);

  @override
  _ReservationCardState createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailReservation()));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reservation code:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'guest name:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Reservation time:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Zone:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Table code:',
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.titre1,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.titre2,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.titre3,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.titre4,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.titre5,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TwoSideRoundedButton(
                  text: 'Edit',
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddReservation()));
                  },
                  bottomradious: 0,
                  topradious: 20,
                  conatinercolor: Color(0xFFF6F6F6),
                  textcolor: KBeige,
                ),
                TwoSideRoundedButton(
                  text: 'Delete',
                  press: () {},
                  bottomradious: 20,
                  topradious: 0,
                  textcolor: Colors.white,
                  conatinercolor: KBlue,
                ),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}
