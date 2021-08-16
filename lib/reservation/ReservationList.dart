import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/bookWaitSeat.dart';
import 'package:tawelticlient/models/reservation.dart';
import 'package:tawelticlient/services/bookWaitedSeat.services.dart';
import 'package:tawelticlient/services/reservation.services.dart';
import 'package:tawelticlient/reservation/AddReservation.dart';
import 'package:tawelticlient/widget/floorDelete.dart';
import 'package:tawelticlient/widget/waitCard.dart';

import '../widget/RestauCard.dart';
import 'DetailsReservation.dart';

class ReservationtList extends StatefulWidget {
  @override
  _ReservationtListState createState() => _ReservationtListState();
}

class _ReservationtListState extends State<ReservationtList> {
  BookWaitSeatServices get bwsService => GetIt.I<BookWaitSeatServices>();
  List<BookWaitSeat> reservations = [];
  APIResponse<List<BookWaitSeat>> _apiResponse;
  bool _isLoading = false;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;
  String dateReservatin;
  String timeReservatin;
 var user;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }
  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    user=userId;
    print(userId);
    setState(() {
      user = userId;
      _fetchReservations(user);

      //print(user);
    });
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: Icon(CupertinoIcons.arrow_left),
          title: Text(
            'Reservation list',
            style: TextStyle(
                fontSize: 25,
                color: KBlue,
                fontFamily: 'ProductSans',
                letterSpacing: 1,
                fontWeight: FontWeight.w100),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: TableCalendar(
                events: _events,
                initialCalendarFormat: CalendarFormat.week,
                calendarStyle: CalendarStyle(
                  selectedColor: KBlue,
                  todayColor: KBeige,
                  weekendStyle: TextStyle(color: KBeige),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    color: KBlue,
                    fontSize: 15,
                  ),
                  weekendStyle: TextStyle(color: KBeige),
                ),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonShowsNext: false,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                  ),
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, _) {
                  setState(() {
                    _selectedEvents = events;
                  });
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: KBlue,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                calendarController: _controller,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height*0.6,
               child:_buildEventsList(_apiResponse.data),
            ),

            /*..._selectedEvents.map(
              (event) => ListTile(
                title: Container(
                  color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Text(event.title),
                ),
                */ /*onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailsPage(
                        event: event,
                      ),
                    ),
                  );
                },*/ /*
              ),
            ),*/
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: KBeige,
      //   child: Icon(Icons.add),
      //   // onPressed: () {
      //   //   Navigator.push(
      //   //       context, MaterialPageRoute(builder: (context) => AddReservation()));
      //   // },
      // ),
    );
  }

  _fetchReservations(user) async {
    print(user);
    setState(() {
      _isLoading = true;
    });

    _apiResponse =
    await bwsService.getUserListBWS(user.toString());
    print(_apiResponse.data);
    setState(() {
      _isLoading = false;
    });
  }

  _buildEventsList(List data) {
    return Container(
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          dateReservatin= DateFormat('dd-MM-yyyy').format(data[index].debut);
          timeReservatin= DateFormat('hh:mm').format(data[index].debut);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DetailReservation(reservationId: data[index].id,))).then((__) => _fetchReservations(user));
            },
            child: WaitCard(

              // delete:()async{
              //   final result = await showDialog(
              //       context: context, builder: (_) => FloorDelete());
              //
              //   if (result) {
              //     final deleteResult = await reservationService
              //         .deleteReservation(data[index].id.toString());
              //     _fetchReservations(user);
              //
              //     var message = 'The reservation was deleted successfully';
              //
              //     return deleteResult?.data ?? false;
              //   }
              //   print(result);
              //   return result;
              // },
              guestname: data[index].guestName,
              nbPersonne: '2',
              reservationId: data[index].id,
              reservationDate: dateReservatin,
              reservationTime: timeReservatin,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black87,
        ),
      ),
    );
  }
}
