import 'package:flutter/material.dart';
import 'package:tawelticlient/constants.dart';

class ReservationCard extends StatefulWidget {
  const ReservationCard({Key key}) : super(key: key);

  @override
  _ReservationCardState createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.275,
      decoration: BoxDecoration(
        color: KBackgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.225,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.225,
                  height: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Color(0xFF1C3956), BlendMode.dstATop),
                        image: ExactAssetImage('assets/Qrcode.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Restaurant name',
                        style: TextStyle(
                            color: KBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      Text(
                        'Guest name',
                        style: TextStyle(
                            color: KBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1.5,
            indent: 0,
            endIndent: 0,
            color: KBeige.withOpacity(0.5),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.085,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Reservation time:',
                      style: TextStyle(
                          color: KBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'table number:',
                      style: TextStyle(
                          color: KBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '21/09/2021 10:15PM',
                      style: TextStyle(color: KBlue, fontSize: 16),
                    ),
                    Text(
                      '102',
                      style: TextStyle(color: KBlue, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
