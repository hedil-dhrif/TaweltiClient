import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
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
            // TextField(
            //   onChanged: (value) => _runFilter(value),
            //   decoration: InputDecoration(
            //       labelText: 'Search', suffixIcon: Icon(Icons.search)),
            // ),
            RechercherBar(
              changed: (value){
                  _runFilter(value);
                  // debouncer.run(() {
                  //   filterrestaurant = restaurant.where((u)=> (u.NomResto.toLowerCase().contains(string))).toList();
                  //   print(string);
                  // });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10),
              child: TextButton(
                onPressed: (){
                  _getUserInfo();
                },
                child: Text(
                  'Recommended for you',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KBlue,
                    fontSize: 20,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10),
              child: SingleChildScrollView(
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
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 0, left: 20),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: KBlue,
                  fontSize: 20,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            _foundRestaurants.length > 0
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: _buildListRestaurants(_foundRestaurants),
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
    return ListView.builder(
      // Create a grid with 2 columns. If you change the scrollDirection to
      itemCount: _apiResponse.length,
      itemBuilder:(BuildContext context,index){
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RestaurantProfil(
                          restaurantId: _apiResponse[index].id,
                        )));
          },
          // child: RestaurantCard(
          //   image: 'assets/resto.png',
          //   title: _apiResponse[index].NomResto,
          //   soustitle: _apiResponse[index].adresse,
          // ),
          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: RestoCard(
              id: _apiResponse[index].id.toString(),
              imagePath: 'assets/resto.png',
              name: _apiResponse[index].NomResto,
              adresse: _apiResponse[index].adresse,
              ratings: 5,
            ),
          ),
        );
      });
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        //borderRadius: BorderRadius.circular(5),
       // height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
                height: 100.0,
                width: 340.0,
                child:Stack(
                  children: [
                    Container(
                     decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),

                      child: CarouselSlider(
                        options: CarouselOptions(height: 400.0),
                        items: [5,1,1,1].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.amber
                                ),
                                child:FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.asset('assets/restaurant.jpg',)),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(right: 5,
                        top: 10,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          //   color: Colors.blue
                          // ),
                            child: Center(child: Icon(Icons.favorite,color: Colors.black12,size: 15,)))),
                    Positioned(
                      top: 10,
                      left: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.black45
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              "(" + 5.toString() + " Reviews)",
                              style: TextStyle(color: Colors.grey,fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex:8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'the Cliff',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: KBlue),
                          ),
                          Text(
                            'Avenue Sidi Dhrif, La Marsa',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: KBlue),
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

