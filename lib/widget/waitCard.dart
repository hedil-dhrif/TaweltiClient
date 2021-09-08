import 'package:flutter/material.dart';

import '../constants.dart';
import 'TowSidedRoundedButton.dart';

class WaitCard extends StatefulWidget {
  final int reservationId;
  final String guestname;
  final String reservationDate;
  final String reservationTime;
  final String nbPersonne;
  final Function delete;

  WaitCard({
    this.nbPersonne,
    this.guestname,
    this.reservationDate,
    this.reservationTime,
    this.reservationId,
    this.delete,
  });
  @override
  _WaitCardState createState() => _WaitCardState();
}

class _WaitCardState extends State<WaitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10, right: 10, left: 10),
      padding: EdgeInsets.only(left: 20),
      height: MediaQuery.of(context).size.height * 0.27,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'guest name:',
                          style: TextStyle(
                            fontSize: 20,
                            color: KBlue,
                          ),
                        ),
                        Text(
                          'Reservation date:',
                          style: TextStyle(
                            fontSize: 20,
                            color: KBlue,
                          ),
                        ),
                        Text(
                          'Reservation time:',
                          style: TextStyle(
                            fontSize: 20,
                            color: KBlue,
                          ),
                        ),
                        Text(
                          'Guest number:',
                          style: TextStyle(
                            fontSize: 20,
                            color: KBlue,
                          ),
                        ),
                        // Text(
                        //   'Table code:',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     color: KBlue,
                        //   ),
                        // ),
                      ],
                    ),
                    flex: 4,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.guestname,
                          style: TextStyle(
                              fontSize: 20,
                              color: KBlue,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          widget.reservationDate,
                          style: TextStyle(
                              fontSize: 20,
                              color: KBlue,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          widget.reservationTime,
                          style: TextStyle(
                              fontSize: 20,
                              color: KBlue,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          widget.nbPersonne,
                          style: TextStyle(
                              fontSize: 20,
                              color: KBlue,
                              fontWeight: FontWeight.w300),
                        ),
                        // Text(
                        //   'T20',
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     color: KBlue,
                        //   ),
                        //),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TwoSideRoundedButton(
                  text: 'cancel',
                  press: widget.delete,
                  bottomradious: 10,
                  topradious: 0,
                  textcolor: Colors.white,
                  conatinercolor: KBeige.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
