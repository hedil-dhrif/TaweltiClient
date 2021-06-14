import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/Restaurant/RestaurantProfil.dart';
import 'package:tawelticlient/client/Profil.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:tawelticlient/widget/RestaurantCard.dart';
import 'Restaurant/RestaurantProfil.dart';
import 'api/api_Response.dart';
import 'auth/signin.dart';
import 'constants.dart';
import 'services/restaurant.services.dart';

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
  List<Restaurant> reservations = [];
  APIResponse<List<Restaurant>> _apiResponse;
  TextEditingController editingController = TextEditingController();
  List<Restaurant> _foundRestaurants = [];
  String errorMessage;
  var user;
  int Id;
  List<String> searchCritere;

  @override
  void initState() {
    _getUserInfo();
    _fetchRestaurants();
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

  // This function is called whenever the text field changes
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
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
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
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: TextField(
                  onChanged: (value) => _runFilter(value),
                  controller: editingController,
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: KBlue,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: KBlue, width: 1),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: KBlue,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuisine type: ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: KBlue),
                        ),
                        Container(
                          child: CheckboxGroup(
                              labelStyle: TextStyle(fontSize: 17.5, color: KBlue),
                              orientation: GroupedButtonsOrientation.VERTICAL,
                              labels: <String>[
                                "Cuisine Tunisienne",
                                "Cuisine arabe",
                                "Cuisine française",
                                "Cuisine italienne",
                              ],
                             // onSelected: (List<String> checked) =>
                              //findRestaurantUsingLoop(_apiResponse.data, checked),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location: ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: KBlue),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: CheckboxGroup(
                              labelStyle: TextStyle(fontSize: 17.5, color: KBlue),
                              orientation: GroupedButtonsOrientation.VERTICAL,
                              labels: <String>[
                                "Tunis",
                                "Sidi bousaid",
                                "Nabeul",
                                "la marsa",
                              ],
                              onSelected: (List<String> checked) =>
                                  findRestaurantUsingLocation(_apiResponse.data, checked)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _foundRestaurants.length > 0
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.45,
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

  // findRestaurantUsingLoop(List<Restaurant> restaurants, List<String> cuisineType) {
  //   List<Restaurant> results = [];
  //   print(cuisineType);
  //   if(cuisineType.length==null){
  //     setState(() {
  //       results=_apiResponse.data;
  //     });
  //   }else{
  //     for (var i = 0; i < restaurants.length; i++) {
  //       for(var j=0;j<cuisineType.length;j++){
  //         if (restaurants[i].cuisine == cuisineType[j].toLowerCase()) {
  //           results.add(restaurants[i]);
  //           print('Using loop: ${restaurants[i].NomResto}');
  //           setState(() {
  //             _foundRestaurants=results;
  //           });
  //         }
  //       }
  //
  //     }
  //   }
  // }

  findRestaurantUsingLocation(List<Restaurant> restaurants, List<String> location) {
    List<Restaurant> results = [];
    print(location);
    if(location.length==null){
      setState(() {
        results=_apiResponse.data;
      });
    }
    else{
      for (var i = 0; i < restaurants.length; i++) {
        for(var j=0;j<location.length;j++){
          if (restaurants[i].adresse == location[j].toLowerCase()) {
            results.add(restaurants[i]);
            print('Using loop: ${restaurants[i].NomResto}');
            setState(() {
              _foundRestaurants=results;
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
      NameController.text = response.data.username;
      print(response.data.username);
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

class CheckBoxModal {
  String title;
  bool checked;

  CheckBoxModal({@required this.title, @required this.checked = false});
}
