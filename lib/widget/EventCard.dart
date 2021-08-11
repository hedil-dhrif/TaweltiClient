import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EventCard extends StatefulWidget {
  final String EventName;
  final String category;
  final String description;
  final int eventId;
  final Function pressDetails;
  final Function pressDelete;

  EventCard({this.EventName,this.description,this.category,this.eventId,this.pressDetails,this.pressDelete});
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.pressDetails,
      child: Container(
        //height: MediaQuery.of(context).size.height * 0.27,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/events.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:10,left: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: widget.EventName+'\n',
                            style: TextStyle(
                              color: KBlue,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: widget.category+'\n',
                            style: TextStyle(
                              color: KBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: widget.description,
                            style: TextStyle(
                              color: KBlue.withOpacity(0.75),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
