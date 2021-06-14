import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/reservation.dart';
import 'package:tawelticlient/services/reservation.services.dart';

class AddReservation extends StatefulWidget {
  final int userId;
  final int restaurantId;
  AddReservation({this.restaurantId,this.userId});
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  ReservationServices get reservationService => GetIt.I<ReservationServices>();

  DateTime _datetime;
  int _counter = 0;
  bool _isLoading = false;
  TextEditingController guestNameController = TextEditingController();
  String valueChoose;
  List listItem = [
    'Outside',
    'Inside',
    'Garden',
  ];
  var user;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }
  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    print(userId);
    setState(() {
      user = userId;
      print(user);
    });
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  DateTime datetime;

  String getText() {
    if (datetime == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd-MM-yyyy').format(datetime);
    }
  }

  TimeOfDay time;

  String getTextTime() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xf6f6f6),
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
             Navigator.of(context).pop();
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Text(
            'Add Reservation',
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
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Guest name :',
                    style: TextStyle(
                      fontSize: 20,
                      color: KBlue,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: KBlue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: guestNameController,
                    ),
                  ),
                  Text(
                    'Guest number :',
                    style: TextStyle(
                      fontSize: 20,
                      color: KBlue,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: KBlue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$_counter',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_up,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _incrementCounter,
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                                color: KBlue,
                              ),
                              onTap: _decrementCounter,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pick a date :',
                            style: TextStyle(
                              fontSize: 20,
                              color: KBlue,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: KBlue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: KBlue,
                                  size: 30,
                                ),
                                GestureDetector(
                                  child: Text(
                                    getText(),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate:
                                      datetime == null ? DateTime.now() : datetime,
                                      initialDatePickerMode: DatePickerMode.day,
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2040),
                                    ).then((date) {
                                      setState(() {
                                        datetime = date;
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pick time :',
                            style: TextStyle(
                              fontSize: 20,
                              color: KBlue,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: KBlue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: KBlue,
                                  size: 30,
                                ),
                                GestureDetector(
                                  child: Text(
                                    getTextTime(),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    pickTime(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   'Pick zone: ',
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     color: KBlue,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(width: 1, color: KBlue),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: DropdownButton(
                  //     hint: Text(
                  //       'Select Floor : ',
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //       ),
                  //     ),
                  //     icon: Icon(
                  //       Icons.arrow_drop_down,
                  //     ),
                  //     iconSize: 35,
                  //     isExpanded: true,
                  //     underline: SizedBox(),
                  //     value: valueChoose,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         valueChoose = newValue;
                  //       });
                  //     },
                  //     items: listItem.map((valueItem) {
                  //       return DropdownMenuItem(
                  //         value: valueItem,
                  //         child: Text(
                  //           valueItem,
                  //           style: TextStyle(
                  //             fontSize: 20,
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      _addReservation();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AddReservationNext()));
                    },
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: KBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 20,
                                color: KBackgroundColor,
                                letterSpacing: 2),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _addReservation()async{
    setState(() {
      _isLoading = true;
    });
    final reservation = Reservation(
      userId: user,
      restaurantId: widget.restaurantId,
      nbPersonne: _counter,
      nomPersonne: guestNameController.text,
      dateReservation: getText(),
      heureReservation: getTextTime(),
    );
    final result = await reservationService.createReservation(reservation);

    setState(() {
      _isLoading = false;
    });

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Done'),
          content: Text('your reservation is added successfully'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
}
