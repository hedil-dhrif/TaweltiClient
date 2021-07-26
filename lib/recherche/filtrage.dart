import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/models/Cuisine.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/models/ambiance.dart';
import 'package:tawelticlient/models/etablissement.dart';
import 'package:tawelticlient/models/general.dart';
import 'package:tawelticlient/recherche/result.dart';
import 'package:tawelticlient/services/ambiance.services.dart';
import 'package:tawelticlient/services/etablissement.services.dart';
import 'package:tawelticlient/services/general.services.dart';
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
  AmbianceServices get ambianceService => GetIt.I<AmbianceServices>();
  CuisineServices get cuisineService => GetIt.I< CuisineServices>();
  EtablissementServices get etablissementService => GetIt.I<EtablissementServices>();
  GeneralServices get generalService => GetIt.I<GeneralServices>();

  List<String> ambiance = [];
  List<String> ambianceDB = [];
  List<String> general = [];
  List<String> etablissment = [];
  List<String> cuisine = [];
  List<String> budget = [];
  List<Ambiance> filterAmbiances = [];
  List<Cuisine> filterCuisines = [];
  List<Etablissement> filterEtablissements = [];
  List<General> filterGenerals = [];
  List<int> results = [];

  bool _isLoading = true;
  APIResponse<List<Ambiance>> _apiResponse;
  APIResponse<List<Cuisine>> _apiResponseCuisine;
  APIResponse<List<Etablissement>> _apiResponseEtablissement;
  APIResponse<List<General>> _apiResponseGeneral;

  _fetchAmbiances() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await ambianceService.getListAmbiance();
    //_foundRestaurants = _apiResponse.data;
    print(_apiResponse.data.length);
    print(_apiResponse.data);
    setState(() {
      _isLoading = false;
      filterAmbiances = _apiResponse.data;
    });
  }
  _fetchCuisines() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseCuisine = await cuisineService.getListCuisine();
    //_foundRestaurants = _apiResponse.data;
    print(_apiResponseCuisine.data.length);
    print(_apiResponseCuisine.data);
    setState(() {
      _isLoading = false;
    });
    filterCuisines=_apiResponseCuisine.data;
  }
  _fetchEtablissement() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseEtablissement = await etablissementService.getListEtablissement();
    //_foundRestaurants = _apiResponse.data;
    print(_apiResponseEtablissement.data.length);
    print(_apiResponseEtablissement.data);
    setState(() {
      _isLoading = false;
    });
    filterEtablissements=_apiResponseEtablissement.data;
  }
  _fetchGenerals() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseGeneral = await generalService.getListGeneral();
    //_foundRestaurants = _apiResponse.data;
    print(_apiResponseGeneral.data.length);
    print(_apiResponseGeneral.data);
    setState(() {
      _isLoading = false;
    });
    filterGenerals=_apiResponseGeneral.data;
  }

  // _listAmbianceDb() {
  //   filterAmbiances.forEach((element) {
  //     ambianceDB.add(element.type);
  //   });
  // }

  findRestaurantUsingAmbiance(List<String> ambiance) {
    print(ambiance);
    print(_apiResponse.data);
    for (var i = 0; i < ambiance.length; i++) {
      for (var j = 0; j < _apiResponse.data.length; j++) {
        if (ambiance[i].toLowerCase() ==
            _apiResponse.data[j].type.toLowerCase()) {
          if (results.contains(_apiResponse.data[j].restaurantId)) {
            print(
                'Using loop: ${filterAmbiances[j].type},${filterAmbiances[j].restaurantId}');
            j++;
          } else {
            results.add(_apiResponse.data[j].restaurantId);
            print(
                'Using loop: ${filterAmbiances[j].type},${filterAmbiances[j].restaurantId}');
          }
        }
      }
    }
    print(results);
  }
  findRestaurantUsingCuisine(List<String> cuisine) {
    print(cuisine);
    print(_apiResponseCuisine.data);
    for (var i = 0; i < cuisine.length; i++) {
      for (var j = 0; j < _apiResponseCuisine.data.length; j++) {
        if (cuisine[i].toLowerCase() ==
            _apiResponseCuisine.data[j].type.toLowerCase()) {
          if (results.contains(_apiResponseCuisine.data[j].restaurantId)) {
            print(
                'Using loop: ${filterCuisines[j].type},${filterCuisines[j].restaurantId}');
            j++;
          } else {
            results.add(_apiResponseCuisine.data[j].restaurantId);
            print(
                'Using loop: ${filterCuisines[j].type},${filterCuisines[j].restaurantId}');
          }
        }
      }
    }
    print(results);
  }
  findRestaurantUsingEtablissement(List<String> etablissement) {
    print(etablissment);
    print(_apiResponseEtablissement.data);
    for (var i = 0; i < etablissment.length; i++) {
      for (var j = 0; j < _apiResponseEtablissement.data.length; j++) {
        if (etablissment[i].toLowerCase() ==
            _apiResponseEtablissement.data[j].type.toLowerCase()) {
          if (results.contains(_apiResponseEtablissement.data[j].restaurantId)) {
            print(
                'Using loop: ${filterEtablissements[j].type},${filterEtablissements[j].restaurantId}');
            j++;
          } else {
            results.add(_apiResponseEtablissement.data[j].restaurantId);
            print(
                'Using loop: ${filterEtablissements[j].type},${filterEtablissements[j].restaurantId}');
          }
        }
      }
    }
    print(results);
  }
  findRestaurantUsingGeneral(List<String>general) {
    print(general);
    print(_apiResponseGeneral.data);
    for (var i = 0; i <general.length; i++) {
      for (var j = 0; j < _apiResponseGeneral.data.length; j++) {
        if (general[i].toLowerCase() ==
            _apiResponseGeneral.data[j].type.toLowerCase()) {
          if (results.contains(_apiResponseGeneral.data[j].restaurantId)) {
            print(
                'Using loop: ${filterGenerals[j].type},${filterGenerals[j].restaurantId}');
            j++;
          } else {
            results.add(_apiResponseGeneral.data[j].restaurantId);
            print(
                'Using loop: ${filterGenerals[j].type},${filterGenerals[j].restaurantId}');
          }
        }
      }
    }
    print(results);
  }
  @override
  void initState() {
    _fetchAmbiances();
    _fetchCuisines();
    _fetchGenerals();
    _fetchEtablissement();
    super.initState();
  }

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
                    FilterChipWidget(
                      chipName: 'BeachBar',
                      chips: etablissment,
                    ),
                    FilterChipWidget(
                      chipName: 'Lounge',
                      chips: etablissment,
                    ),
                    FilterChipWidget(
                      chipName: 'tea room',
                      chips: etablissment,
                    ),
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
                      FilterChipWidget(
                        chipName: 'Cuisine française',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'Cuisine Tunisienne',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'Cuisine italienne',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'Libanese',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'Asian',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'Mexican',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'European',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'Steak',
                        chips: cuisine,
                      ),
                      FilterChipWidget(
                        chipName: 'Sea Food',
                        chips: cuisine,
                      ),
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
                    FilterChipWidget(
                      chipName: '\$',
                      chips: budget,
                    ),
                    FilterChipWidget(
                      chipName: '\$\$',
                      chips: budget,
                    ),
                    FilterChipWidget(
                      chipName: '\$\$\$',
                      chips: budget,
                    ),
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
                    FilterChipWidget(
                      chipName: 'Festive',
                      chips: ambiance,
                    ),
                    FilterChipWidget(
                      chipName: 'Calm',
                      chips: ambiance,
                    ),
                    FilterChipWidget(
                      chipName: 'Romantic',
                      chips: ambiance,
                    ),
                    FilterChipWidget(
                      chipName: 'Business',
                      chips: ambiance,
                    ),
                    FilterChipWidget(
                      chipName: 'Family',
                      chips: ambiance,
                    ),
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
                    FilterChipWidget(
                      chipName: 'Requires reservation',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Car parking',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Smoking area',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'No smoking area',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Children area',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'restaurant tickets',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'check',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Animals allowed',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Alcohol',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Shisha',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Indoors',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Outdoors',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'TPE',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'WIFI',
                      chips: general,
                    ),
                    FilterChipWidget(
                      chipName: 'Karaoke',
                      chips: general,
                    ),
                  ],
                )),
              ),
            ),
            Divider(
              color: Colors.blueGrey,
              height: 10.0,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  findRestaurantUsingAmbiance(ambiance);
                  findRestaurantUsingCuisine(cuisine);
                  findRestaurantUsingEtablissement(etablissment);
                  findRestaurantUsingGeneral(general);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultRecherche(
                                restaurantsIDs: results,
                              )));
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

class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final List<String> chips;
  FilterChipWidget({Key key, this.chipName, this.chips}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
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
          widget.chips.add(widget.chipName);
        });
      },
      selectedColor: Color(0xffeadffd),
    );
  }
}
