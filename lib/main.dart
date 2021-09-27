import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/accueil.dart';
import 'package:tawelticlient/auth/googleAuth.dart';
import 'package:tawelticlient/auth/start.dart';
import 'package:tawelticlient/download.dart';
import 'package:tawelticlient/download.dart';
import 'package:tawelticlient/models/fileEvent.dart';
import 'package:tawelticlient/services/ambiance.services.dart';
import 'package:tawelticlient/services/bookWaitedSeat.services.dart';
import 'package:tawelticlient/services/cuisine.services.dart';
import 'package:tawelticlient/services/etablissement.services.dart';
import 'package:tawelticlient/services/event.services.dart';
import 'package:tawelticlient/services/file.services.dart';
import 'package:tawelticlient/services/fileEvent.services.dart';
import 'package:tawelticlient/services/general.services.dart';
import 'package:tawelticlient/services/reservation.services.dart';
import 'package:tawelticlient/services/restaurant.services.dart';
import 'package:tawelticlient/services/table.services.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/social_share.dart';
import 'package:tawelticlient/url.dart';

import 'accueil.dart';
import 'auth/start.dart';
import 'download.dart';

void setupLocator() {

  GetIt.I.registerLazySingleton(() => EventServices());
  GetIt.I.registerLazySingleton(() => UserServices());
  GetIt.I.registerLazySingleton(() => RestaurantServices());
  GetIt.I.registerLazySingleton(() => ReservationServices());
  GetIt.I.registerLazySingleton(() => CuisineServices());
  GetIt.I.registerLazySingleton(() => EtablissementServices());
  GetIt.I.registerLazySingleton(() => AmbianceServices());
  GetIt.I.registerLazySingleton(() => GeneralServices());
  GetIt.I.registerLazySingleton(() => BookWaitSeatServices());
  GetIt.I.registerLazySingleton(() => RestaurantTableServices());
  GetIt.I.registerLazySingleton(() => FileServices());
  GetIt.I.registerLazySingleton(() => FileEventServices());

}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }
  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token!= null){
      setState(() {
        _isLoggedIn = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInDemo(),
     //home:_isLoggedIn?Accueil():StartPage(),
    );
  }
}

