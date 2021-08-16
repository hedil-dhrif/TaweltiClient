import 'package:flutter/material.dart';


import '../constants.dart';
import '../reservation/AddReservation.dart';
import 'TowSidedRoundedButton.dart';

class RestauCard extends StatefulWidget {
  final int reservationId;
  final String guestname;
  final String reservationDate;
  final String reservationTime;
  final String nbPersonne;

  RestauCard({this.nbPersonne,this.guestname,this.reservationDate,this.reservationTime,this.reservationId});
  @override
  _RestauCardState createState() => _RestauCardState();
}

class _RestauCardState extends State<RestauCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    children: [
                      Text(
                        widget.guestname,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      Text(
                        widget.reservationDate,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      Text(
                        widget.reservationTime,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
                      ),
                      Text(
                        widget.nbPersonne,
                        style: TextStyle(
                          fontSize: 20,
                          color: KBlue,
                        ),
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

        ],
      ),
    );
  }
}
