import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/models/Cuisine.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import '../constants.dart';
import 'package:tawelticlient/services/cuisine.services.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/services/user.services.dart';

class Filtrage extends StatefulWidget {
  const Filtrage({Key key}) : super(key: key);

  @override
  _FiltrageState createState() => _FiltrageState();
}

class _FiltrageState extends State<Filtrage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          title: 'Filter',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Type of establishment"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                  spacing: 5.0,
                  runSpacing: 3.0,
                  children: <Widget>[
                    filterChipWidget(chipName: 'BeachBar'),
                    filterChipWidget(chipName: 'Lounge'),
                    filterChipWidget(chipName: 'tea room'),
                  ],
                )),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer('Kitchen'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Wrap(
                    spacing: 5.0,
                    runSpacing: 5.0,
                    children: <Widget>[
                      filterChipWidget(chipName: 'French'),
                      filterChipWidget(chipName: 'Tunisan'),
                      filterChipWidget(chipName: 'Italian'),
                      filterChipWidget(chipName: 'Libanese'),
                      filterChipWidget(chipName: 'Asian'),
                      filterChipWidget(chipName: 'Mexican'),
                      filterChipWidget(chipName: 'European'),
                      filterChipWidget(chipName: 'Steak'),
                      filterChipWidget(chipName: 'Sea Food'),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Budget"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        filterChipWidget(chipName: '\$'),
                        filterChipWidget(chipName: '\$\$'),
                        filterChipWidget(chipName: '\$\$\$'),
                      ],
                    )),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("Ambiance"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        filterChipWidget(chipName: 'Festive'),
                        filterChipWidget(chipName: 'Calm'),
                        filterChipWidget(chipName: 'Romantic'),
                        filterChipWidget(chipName: 'Business'),
                        filterChipWidget(chipName: 'Family'),
                      ],
                    )),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _titleContainer("General"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 3.0,
                      children: <Widget>[
                        filterChipWidget(chipName: 'Requires reservation'),
                        filterChipWidget(chipName: 'Car parking'),
                        filterChipWidget(chipName: 'Smoking area'),
                        filterChipWidget(chipName: 'No smoking area'),
                        filterChipWidget(chipName: 'Children area'),
                        filterChipWidget(chipName: 'restaurant tickets'),
                        filterChipWidget(chipName: 'check'),
                        filterChipWidget(chipName: 'Animals allowed'),
                        filterChipWidget(chipName: 'Alcohol'),
                        filterChipWidget(chipName: 'Shisha'),
                        filterChipWidget(chipName: 'Indoors'),
                        filterChipWidget(chipName: 'Outdoors'),
                        filterChipWidget(chipName: 'TPE'),
                        filterChipWidget(chipName: 'WIFI'),
                        filterChipWidget(chipName: 'Karaoke'),
                      ],
                    )),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            SizedBox(height:20,),
            TextButton(
                onPressed: () {

                },
                child: Text(
                  'Find restaurant',
                ))
          ],
        ),
      ),
    );
  }
}

/*
class Filtrage extends StatefulWidget {
  @override
  _FiltrageState createState() => _FiltrageState();
}

class _FiltrageState extends State<Filtrage> {
  bool estclick = false;
  bool kitclick = false;
  bool budclick = false;
  bool ambclick = false;
  bool genclick = false;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  UserServices get userService => GetIt.I<UserServices>();
  CuisineServices get cuisineservice => GetIt.I<CuisineServices>();
  bool _isLoading = false;
  TextEditingController NameController = TextEditingController();
  List<Restaurant> reservations = [];
  List<Cuisine> cuisine = [];
  APIResponse<List<Restaurant>> _apiResponse;
  List<Restaurant> _foundRestaurants = [];
  String errorMessage;
  List<String> listcriteres=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: KBlue,
        ),
        title: Center(
          child: Text(
            'filter parameters',
            style: TextStyle(
                fontSize: 25,
                color: KBlue,
                fontFamily: 'ProductSans',
                letterSpacing: 1,
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterParameter(
                  title: 'Type of establishment :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Lounge',
                        ),
                        MyStatefulWidget(
                          title: 'Beachbar',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        MyStatefulWidget(
                          title: 'Tea room',
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                  title: 'Kitchen :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Frensh',
                        ),
                        MyStatefulWidget(
                          title: 'Tunisian',
                        ),
                        MyStatefulWidget(
                          title: 'Italian',
                        ),
                        MyStatefulWidget(
                          title: 'Turkish',
                        ),
                        MyStatefulWidget(
                          title: 'American',
                        ),
                        MyStatefulWidget(
                          title: 'Lebanese',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Seafood',
                        ),
                        MyStatefulWidget(
                          title: 'Steak',
                        ),
                        MyStatefulWidget(
                          title: 'Mexican',
                        ),
                        MyStatefulWidget(
                          title: 'European',
                        ),
                        MyStatefulWidget(
                          title: 'African',
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                  title: 'Budget :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyStatefulWidget(
                      title: '*',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    MyStatefulWidget(
                      title: '**',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    MyStatefulWidget(
                      title: '***',
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                  title: 'Ambiance :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Festive',
                        ),
                        MyStatefulWidget(
                          title: 'Calm',
                        ),
                        MyStatefulWidget(
                          title: 'Romantic',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Buisness',
                        ),
                        MyStatefulWidget(
                          title: 'Family',
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                  title: 'General :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Requires reservation',
                        ),
                        MyStatefulWidget(
                          title: 'Car park',
                        ),
                        MyStatefulWidget(
                          title: 'Smoking area',
                        ),
                        MyStatefulWidget(
                          title: 'No smoking',
                        ),
                        MyStatefulWidget(
                          title: 'Children area',
                        ),
                        MyStatefulWidget(
                          title: 'Ticket restaurant',
                        ),
                        MyStatefulWidget(
                          title: 'Check',
                        ),
                        MyStatefulWidget(
                          title: 'Animals',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    Column(
                      children: [
                        MyStatefulWidget(
                          title: 'Alcohol',
                        ),
                        MyStatefulWidget(
                          title: 'shisha',
                        ),
                        MyStatefulWidget(
                          title: 'Outdoors',
                        ),
                        MyStatefulWidget(
                          title: 'Indoors',
                        ),
                        MyStatefulWidget(
                          title: 'TPE',
                        ),
                        MyStatefulWidget(
                          title: 'Wifi',
                        ),
                        MyStatefulWidget(
                          title: 'Karaoke',
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: KBlue),
                    child: Text(
                      'Check result',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  findRestaurantUsingLoop(
      List<Restaurant> restaurants, List<String> cuisineType) {
    List<Restaurant> results = [];
    print(cuisineType);
    if (cuisineType.length == null) {
      setState(() {
        results = _apiResponse.data;
      });
    } else {
      for (var i = 0; i < restaurants.length; i++) {
        for (var j = 0; j < cuisineType.length; j++) {
          if (cuisine[i].type == cuisineType[j].toLowerCase()) {
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
}

class FilterParameter extends StatelessWidget {
  final String title;

  const FilterParameter({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 22.5, color: KBlue, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final String title;

  const MyStatefulWidget({Key key, this.title}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return KBlue;
    }

    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool value) {
            setState(() {
              isChecked = value;
            });
          },
        ),
        Text(
          widget.title,
          style: TextStyle(color: KBlue, fontSize: 20),
        ),
      ],
    );
  }
}
*/

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle:
          TextStyle(color: KBlue, fontSize: 16.0, fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Color(0xffeadffd),
    );
  }
}
