import 'package:flutter/material.dart';

import '../constants.dart';
import 'TowSidedRoundedButton.dart';

class EventCard extends StatefulWidget {
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       /* Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailsEvent()));*/
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/events.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Event name \n ",
                          style: TextStyle(
                            color: KBlue,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: "event description",
                          style: TextStyle(
                            color: KBlue.withOpacity(0.75),
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TwoSideRoundedButton(
                  text: 'Edit',
                  press: () {
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddEvent()));*/
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
            ),
          ],
        ),
      ),
    );
  }
}
