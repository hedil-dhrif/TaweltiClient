import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/services/event.services.dart';
import 'package:tawelticlient/models/event.dart';

import '../DetailsEvent.dart';
import '../constants.dart';
import 'EventCard.dart';
import 'floorDelete.dart';


class EventList extends StatefulWidget {
  final int restaurantId;
  EventList({this.restaurantId});
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  EventServices get eventService => GetIt.I<EventServices>();
  List<Event> events = [];
  APIResponse<List<Event>> _apiResponse;
  bool _isLoading = false;

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse =
        await eventService.getEventsList(widget.restaurantId.toString());
    _buildEventsList(events);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchEvents();
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBlue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: _buildEventsList(_apiResponse.data)),
            ),
          ],
        ),
      ),
    );
  }

  _buildEventsList(List data) {
    if (data.length > 0) {
      return Container(
        child: ListView.separated(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(data[index].id),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {},
              confirmDismiss: (direction) async {
                final result = await showDialog(
                    context: context, builder: (_) => FloorDelete());

                if (result) {
                  final deleteResult =
                      await eventService.deleteEvent(data[index].id.toString());
                  _fetchEvents();

                  var message = 'The event was deleted successfully';

                  return deleteResult?.data ?? false;
                }
                print(result);
                return result;
              },
              background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16),
                  child: Align(
                    child: Icon(Icons.delete, color: Colors.white),
                    alignment: Alignment.centerLeft,
                  )),
              child: EventCard(
                EventName: data[index].nom,
                category: data[index].category,
                description: data[index].description,
                pressDetails: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsEvent(
                                eventId: data[index].id,
                              ))).then((__) => _fetchEvents());
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black87,
          ),
        ),
      );
    } else {
      return Center(
          child: Text(
        'no events yet',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ));
    }
  }
}
