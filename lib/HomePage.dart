import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/client/Profil.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:tawelticlient/widget/RechercheBar.dart';
import 'package:tawelticlient/widget/RestaurantCard.dart';
import 'Restaurant/RestaurantProfil.dart';
import 'api/api_Response.dart';
import 'auth/signin.dart';
import 'constants.dart';
import 'services/restaurant.services.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if(null != _timer){
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  UserServices get userService => GetIt.I<UserServices>();
  bool _isLoading = false;
  TextEditingController NameController = TextEditingController();
  List<Restaurant> restaurant = [];
  List<Restaurant> filterrestaurant = [];
  APIResponse<List<Restaurant>> _apiResponse;
  TextEditingController editingController = TextEditingController();
  List<Restaurant> _foundRestaurants = [];
  String errorMessage;
  String query = '';
  final debouncer = Debouncer(milliseconds: 500);
  var user;
  int Id;
  List<String> searchCritere;

  @override
  void initState() {
    _getUserInfo();
    _fetchRestaurants();
    restaurant = [];
    filterrestaurant = [];
    setState(() {
      _isLoading = true;
    });
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    print(userId);
    setState(() {
      user = userId;
      _getUserProfile(user);
      print(user);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Restaurant> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _apiResponse.data;
    } else {
      results = _apiResponse.data
          .where((restaurant) => restaurant.NomResto.toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundRestaurants = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClientProfil()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: KBlue,
                backgroundImage: AssetImage('assets/profil.png'),
              ),
            ),
          ),
          title: 'Hello\t' + NameController.text,
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      endDrawer: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: KBlue,
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(CupertinoIcons.settings),
                      Text('paramètres'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.logout),
                      Text('déconnexion'),
                    ],
                  ),
                  onTap: () {
                    logout();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RechercherBar(
              changed: (string){
                setState(() {
                  debouncer.run(() {
                    filterrestaurant = restaurant.where((u)=> (u.NomResto.toLowerCase().contains(string))).toList();
                    print(string);
                  });
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 20),
              child: Text(
                'Recommended for you',
                style: TextStyle(
                  color: KBlue,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RestaurantRecommand(),
                  RestaurantRecommand(),
                  RestaurantRecommand(),
                  RestaurantRecommand(),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20),
              child: Text(
                'Upcomming events',
                style: TextStyle(
                  color: KBlue,
                  fontSize: 20,
                  letterSpacing: 1,
                ),
              ),
            ),
            _foundRestaurants.length > 0
                ? Container(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: _buildListRestaurants(filterrestaurant),
                  )
                : Text(
                    'No results found',
                    style: TextStyle(fontSize: 24),
                  ),
          ],
        ),
      ),
    );
  }

  _fetchRestaurants() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await restaurantService.getRestaurantsList();
    _foundRestaurants = _apiResponse.data;
    print(_apiResponse.data.length);
    print(_apiResponse.data);
    setState(() {
      _isLoading = false;
      filterrestaurant = _apiResponse.data;
    });
  }

  _buildListRestaurants(_apiResponse) {
    //List ListPhotos=['assets/plaza_corniche.jpg','assets/the_cliff.jpg','assets/villa_didon.jpg','assets/maison_bleue.jpg','assets/maison_bleue.jpg','assets/maison_bleue.jpg',];
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(_apiResponse.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RestaurantProfil(
                          restaurantId: _apiResponse[index].id,
                        )));
          },
          child: RestaurantCard(
            image: 'assets/resto.png',
            title: _apiResponse[index].NomResto,
            soustitle: _apiResponse[index].adresse,
          ),
        );
      }),
    );
  }

  findRestaurantUsingLocation(
      List<Restaurant> restaurants, List<String> location) {
    List<Restaurant> results = [];
    print(location);
    if (location.length == null) {
      setState(() {
        results = _apiResponse.data;
      });
    } else {
      for (var i = 0; i < restaurants.length; i++) {
        for (var j = 0; j < location.length; j++) {
          if (restaurants[i].adresse == location[j].toLowerCase()) {
            results.add(restaurants[i]);
            print('Using loop: ${restaurants[i].NomResto}');
            setState(() {
              _foundRestaurants = results;
            });
          }
        }
      }
    }
  }

  void logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('id');
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => SignIn()));
  }

  _getUserProfile(user) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserProfile(user.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      Id = response.data.id;
      NameController.text = response.data.first_name;
      print(response.data.first_name);
      print(response.data.email);
      print(response.data.id);
      // _titleController.text = floor.nom;
      // _contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });
  }
}

class RestaurantRecommand extends StatelessWidget {
  const RestaurantRecommand({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 2.5),
      height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.width * 0.225,
      decoration:
          BoxDecoration(color: KBeige, borderRadius: BorderRadius.circular(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/restaurant.jpg'),
            radius: 35,
          ),
          Text(
            'Restaurant',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    );
  }
}

