import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/bookWaitSeat.dart';
import 'package:tawelticlient/models/table.dart';
import 'package:tawelticlient/reservation/confResevPage.dart';
import 'package:tawelticlient/services/bookWaitedSeat.services.dart';
import 'package:tawelticlient/services/table.services.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:tawelticlient/widget/DisabledInput.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
class PassReservation extends StatefulWidget {
  final int restaurantId;
  PassReservation({this.restaurantId});
  @override
  _PassReservationState createState() => _PassReservationState();
}

class _PassReservationState extends State<PassReservation> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  APIResponse<List<BookWaitSeat>> _apiResponse;
  APIResponse<List<RestaurantTable>> _apiResponse2;
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  BookWaitSeatServices get bwsService => GetIt.I<BookWaitSeatServices>();
  RestaurantTableServices get restaurantTableService =>
      GetIt.I<RestaurantTableServices>();

  TextEditingController NameController = TextEditingController();
  TextEditingController guestNameController = TextEditingController();
  int _currentStep = 0;
  String errorMessage;
  var user;
  List<int> Guest = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  UserServices get userService => GetIt.I<UserServices>();
  bool _isLoading = false;
  int Id;
  int _counter = 0;
  DateTime _datetime;
  final List<BookWaitSeat> listBWS = [];
  final List<BookWaitSeat> databaseBWS = [];
  final List<int> listTables = [];
  final List<RestaurantTable> listAllTables = [];
  DateTime startTime;
  DateTime endTime;
  int id;
  bool _validate = false;
  //final List<int> availableTables=[];
  final List<RestaurantTable> availableTables = [];
  final List<BookWaitSeat> availableBWS = [];
  final List<BookWaitSeat> unavailableBWS = [];
  TimeOfDay newTime;
  String result = '0';
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

  @override
  void initState() {
    print(widget.restaurantId);
    // _getUserInfo();
    _fetchBWS();
    _fetchTables();
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    //print(userId);
    setState(() {
      user = userId;
      //_getUserProfile(user);
      //print(user);
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

      //print('$hours:$minutes:00');
      return '$hours:$minutes:00';
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    newTime = await showTimePicker(
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
        child: AppBarWidget(
          title: 'Add reservation',
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stepper(
              //type: StepperType.horizontal,
              steps: _mySteps(),
              currentStep: this._currentStep,
              onStepTapped: (step) {
                setState(() {
                  this._currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._mySteps().length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    //Logic to check if everything is completed
                    //print('Completed, check fields.');
                  }
                  //  _buildListAvailbaleTablesWithNbPerson(_counter);
                  // _getAvailableTablesTimeAndDate();
                });
              },
              onStepCancel: () {
                setState(() {
                  if (this._currentStep > 0) {
                    this._currentStep = this._currentStep - 1;
                  } else {
                    this._currentStep = 0;
                  }
                });
              },
            ),
            TextButton(
                onPressed: () {
                  // _fetchBWS();
                  // _fetchTables();
                 _buildListAvailbaleTablesWithNbPerson(_counter);
                  
                },
                child: Text('get reservation')),
          ],
        ),
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text(
          'Choose guest number',
          style: TextStyle(color: KBlue, fontSize: 20),
        ),
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: MediaQuery.of(context).size.width * 0.7,
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
                  fontSize: 25,
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
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text(
          'Pick the date',
          style: TextStyle(color: KBlue, fontSize: 20),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
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
                          print(datetime);
                        });
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text(
          'Pick the time',
          style: TextStyle(color: KBlue, fontSize: 20),
        ),
        content: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
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
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text(
          'Validate info',
          style: TextStyle(color: KBlue, fontSize: 20),
        ),
        content: DisabledInput(
          controller: guestNameController,
          validate: _validate,
          inputHint: 'jhon',
          color: KBlue,
        ),
        isActive: _currentStep >= 3,
      )
    ];
    return _steps;
  }

  // _getUserProfile(user) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   await userService.getUserProfile(user.toString()).then((response) {
  //     if (response.error) {
  //       errorMessage = response.errorMessage ?? 'An error occurred';
  //     }
  //     Id = response.data.id;
  //     FirstNameController.text = response.data.first_name;
  //     LastNameController.text = response.data.last_name;
  //     mailController.text = response.data.email;
  //    // phoneController.text = response.data.phone;
  //     //print(response.data.first_name);
  //     //print(response.data.email);
  //     print(response.data.id);
  //     // _titleController.text = floor.nom;
  //     // _contentController.text = note.noteContent;
  //   });
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  _fetchBWS() async {
    // setState(() {
    //   _isLoading = true;
    // });
    // _apiResponse =
    //     await bwsService.getRestaurantsListBWS(widget.restaurantId.toString());
    // print(_apiResponse.data);
    // _buildListBWS();
    // setState(() {
    //   _isLoading = false;
    // });
    final response = await http
        .get(Uri.parse('http://37.187.198.241:3000/BWS/GetALlBookWaitSeat/${widget.restaurantId}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonData = json.decode(response.body);
      for (var item in jsonData) {
        listBWS.add(BookWaitSeat.fromJson(item));
      }
      print(listBWS);
      return listBWS;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  // _buildListBWS() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   for (int i = 0; i < _apiResponse.data.length; i++) {
  //     if (listBWS.contains(_apiResponse.data[i].id)) {
  //       i++;
  //     } else {
  //       listBWS.add(_apiResponse.data[i]);
  //       databaseBWS.add(_apiResponse.data[i]);
  //     }
  //   }
  //   print(listBWS);
  //   print(databaseBWS);
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  _fetchTables() async {
    // setState(() {
    //   _isLoading = true;
    // });
    //
    // _apiResponse2 = await restaurantTableService
    //     .getRestaurantsListTables(widget.restaurantId.toString());
    // //print(_apiResponse2.data);
    //
    // setState(() {
    //   _isLoading = false;
    // });
    final response = await http
        .get(Uri.parse('http://37.187.198.241:3000/user/RestaurantWithTable/${widget.restaurantId}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final jsonData = json.decode(response.body);
      for (var item in jsonData) {
        listAllTables.add(RestaurantTable.fromJson(item));
      }
      print(listAllTables);
      return     _buildListTables();

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  _buildListTables() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < listAllTables.length; i++) {
      if (listTables.contains(listAllTables[i].ids)) {
        i++;
      } else {
        listTables.add(listAllTables[i].ids - 1630);
        availableTables.add(listAllTables[i]);
      }
    }
    //print(listTables);
    setState(() {
      _isLoading = false;
    });
  }

  _buildListAvailbaleTablesWithNbPerson(int nbPerson) {
    for (int i = 0; i < listBWS.length; i++) {
      for (int j = 0; j < availableTables.length; j++) {
        if (availableTables[j].nbCouverts == nbPerson &&
            listBWS[i].id == availableTables[j].ids - 1630) {
          print(availableTables[j].ids - 1630);

          startTime = DateTime(datetime.year, datetime.month, datetime.day,
              newTime.hour, newTime.minute);
          endTime = DateTime(datetime.year, datetime.month, datetime.day,
              newTime.hour + 1, newTime.minute);
          final DateTime dbStartTime=DateTime(listBWS[i].debut.year, listBWS[i].debut.month, listBWS[i].debut.day,
              listBWS[i].debut.hour +2, listBWS[i].debut.minute);
          final DateTime dbEndTime=DateTime(listBWS[i].fin.year, listBWS[i].fin.month, listBWS[i].fin.day,
              listBWS[i].fin.hour +2, listBWS[i].fin.minute);
          print(dbStartTime);
          print(dbEndTime);
          print(startTime);
          print(endTime);
          if (startTime.compareTo(dbStartTime) >= 0 &&
                  startTime.compareTo(dbEndTime) <= 0 ||
              (endTime.compareTo(dbStartTime) >= 0 &&
                  endTime.compareTo(dbEndTime) <= 0)) {
            print(databaseBWS[i].id);
            print('is unavailable');
            id = listBWS[i].id;
            unavailableBWS.add(listBWS[i]);
            print(unavailableBWS.length);
            _showMyDialog();
          }
          else {
           print(listBWS[i].ids);
           print('is available');
            id = listBWS[i].id;
            availableBWS.add(listBWS[i]);

           Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) => ConfirmPage(
                     bookWaitSeat: availableBWS,
                     startTime: startTime,
                     endTime: endTime,
                     Tables: availableTables,
                     guestName: guestNameController.text,
                   )));
          }
        }
      }
    }
    // id = availableBWS[0].id;
    // result = 'table with id= $id is available at date :$startTime';
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('No available Tables at this time'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

