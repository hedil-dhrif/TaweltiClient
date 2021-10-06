import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:smart_select/smart_select.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/Cuisine.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/models/ambiance.dart';
import 'package:tawelticlient/models/etablissement.dart';
import 'package:tawelticlient/models/general.dart';
import 'package:tawelticlient/recherche/filtrage.dart';
import 'package:tawelticlient/recherche/result.dart';
import 'package:tawelticlient/services/ambiance.services.dart';
import 'package:tawelticlient/services/cuisine.services.dart';
import 'package:tawelticlient/services/etablissement.services.dart';
import 'package:tawelticlient/services/general.services.dart';
import 'package:tawelticlient/services/restaurant.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {

   TextStyle textStyle=TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: KBlue);
   List<String> ambiance = [];
   List<String> cuisine = [];

   AmbianceServices get ambianceService => GetIt.I<AmbianceServices>();
   CuisineServices get cuisineService => GetIt.I<CuisineServices>();
   EtablissementServices get etablissementService =>
       GetIt.I<EtablissementServices>();
   GeneralServices get generalService => GetIt.I<GeneralServices>();

   //List<String> ambiance = [];
   List<String> ambianceDB = [];
   List<String> general = [];
   List<String> etablissment = [];
   //List<String> cuisine = [];
   List<String> budget = [];
   List<Ambiance> filterAmbiances = [];
   List<Cuisine> filterCuisines = [];
   List<Etablissement> filterEtablissements = [];
   List<General> filterGenerals = [];
   List<int> results = [];

   bool _isLoading = true;
   APIResponse<List<Ambiance>> _apiResponseAmbiance;
   APIResponse<List<Cuisine>> _apiResponseCuisine;
   APIResponse<List<Etablissement>> _apiResponseEtablissement;
   APIResponse<List<General>> _apiResponseGeneral;
   Position _currentPosition;
   String _currentAddress;
   final Geolocator geolocator = Geolocator();
   RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
   List<Restaurant> _foundRestaurants = [];
   APIResponse<List<Restaurant>> _apiResponse;


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

   List<String> list = [
     'Nabeul,tunisie',
     'Hamamet Sud,tunisie',
     'Hamamet nord,tunisie',
     'Kelibia,tunisie',
     'Tunis,tunisie',
     'carthage,tunisie',
     'menzah,tunisie',
     'Gammart,tunisie',
     'Nasr,tunisie',
     'Lagoulette,tunisie',
     'Sousse,tunisie',
     'Kantaoui,tunisie',
     'Djerba,tunisie',
     'Monastir,tunisie'
   ];


   String value = 'hamamet';
   _fetchAmbiances() async {
     setState(() {
       _isLoading = true;
     });

     _apiResponseAmbiance = await ambianceService.getListAmbiance();
     //_foundRestaurants = _apiResponse.data;
     print(_apiResponseAmbiance.data.length);
     print(_apiResponseAmbiance.data);
     setState(() {
       _isLoading = false;
       filterAmbiances = _apiResponseAmbiance.data;
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
     filterCuisines = _apiResponseCuisine.data;
   }

   _fetchEtablissement() async {
     setState(() {
       _isLoading = true;
     });

     _apiResponseEtablissement =
     await etablissementService.getListEtablissement();
     //_foundRestaurants = _apiResponse.data;
     print(_apiResponseEtablissement.data.length);
     print(_apiResponseEtablissement.data);
     setState(() {
       _isLoading = false;
     });
     filterEtablissements = _apiResponseEtablissement.data;
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
     filterGenerals = _apiResponseGeneral.data;
   }

   // _listAmbianceDb() {
   //   filterAmbiances.forEach((element) {
   //     ambianceDB.add(element.type);
   //   });
   // }

   findRestaurantUsingAmbiance(List<String> ambiance) {
     print(ambiance);
     print(_apiResponseAmbiance.data);
     for (var i = 0; i < ambiance.length; i++) {
       for (var j = 0; j < _apiResponseAmbiance.data.length; j++) {
         if (ambiance[i].toLowerCase() ==
             _apiResponseAmbiance.data[j].type.toLowerCase()) {
           if (results.contains(_apiResponseAmbiance.data[j].restaurantId)) {
             print(
                 'Using loop: ${_apiResponseAmbiance.data[j].type},${_apiResponseAmbiance.data[j].restaurantId}');
             j++;
           } else {
             results.add(_apiResponseAmbiance.data[j].restaurantId);
             print(
                 'Using loop: ${_apiResponseAmbiance.data[j].type},${_apiResponseAmbiance.data[j].restaurantId}');
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
           if (results
               .contains(_apiResponseEtablissement.data[j].restaurantId)) {
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

   findRestaurantUsingGeneral(List<String> general) {
     print(general);
     print(_apiResponseGeneral.data);
     for (var i = 0; i < general.length; i++) {
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

   Future<Position> _determinePosition() async {
     bool serviceEnabled;
     LocationPermission permission;

     // Test if location services are enabled.
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     if (!serviceEnabled) {
       // Location services are not enabled don't continue
       // accessing the position and request users of the
       // App to enable the location services.
       return Future.error('Location services are disabled.');
     }

     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
         // Permissions are denied, next time you could try
         // requesting permissions again (this is also where
         // Android's shouldShowRequestPermissionRationale
         // returned true. According to Android guidelines
         // your App should show an explanatory UI now.
         return Future.error('Location permissions are denied');
       }
     }

     if (permission == LocationPermission.deniedForever) {
       // Permissions are denied forever, handle appropriately.
       return Future.error(
           'Location permissions are permanently denied, we cannot request permissions.');
     }
     getLocation();

     // When we reach here, permissions are granted and we can
     // continue accessing the position of the device.
   }

   getLocation() async {
     Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);
     print(position.latitude);
     print(position.longitude);

     getCurrentAddress(position.latitude,position.longitude);
   }

   List<Address> resultAdress = [];


   getCurrentAddress(latitude,longitude) async {
     var address;

     final coordinates = new Coordinates(latitude,longitude);
     resultAdress = await Geocoder.local.findAddressesFromCoordinates(coordinates);
     var first = resultAdress.first;
     if (first != null) {
       address = first.featureName;
       address = " $address, ${first.subLocality}";
       address = " $address, ${first.subLocality}";
       address = " $address, ${first.locality}";
       address = " $address, ${first.countryName}";
       address = " $address, ${first.postalCode}";

       // locationController.text = address;
       print(address);
       print(first.countryName);
       setState(() {
         value=first.countryName.toString();

       });
     }
     return address;
   }

   _findRestaurantsWithLocation(value){
     _foundRestaurants.forEach((element) {
       if(element.adresse.toUpperCase().contains(value.substring(0, 4).toUpperCase())){
         print(element.NomResto);
       }
     });
   }


   var placesSearch = PlacesSearch(
     apiKey:
     'pk.eyJ1IjoibWFsZWs3NTEiLCJhIjoiY2t1YTh3d3Y4MGVmdzJubXZhbjNuZnE1aiJ9.fOE93kvySi-HSIgEhixglQ',
     limit: 5,
   );
   Future<List<MapBoxPlace>> getPlaces() {
     print(placesSearch.getPlaces("New York"));
     placesSearch.getPlaces("New York");
   }
   @override
   void initState() {
     _fetchRestaurants();
     _fetchAmbiances();
     _fetchCuisines();
     _fetchGenerals();
     _fetchEtablissement();
     _determinePosition();
     super.initState();
   }
   Widget _titleContainer(String myTitle) {
     return Text(
       myTitle,
       style: TextStyle(
           color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
     );
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

      body: Stack(
        children: [
          Container(
            child: VerticalTabs(
              tabsWidth: 120,

              tabs: <Tab>[
                Tab(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Général',style: textStyle,),
                )),
                Tab(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cuisine',style: textStyle,),
                )),
                Tab(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Ambiance',style: textStyle,),
                )),
                Tab(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Alcool',style: textStyle,),
                )),
              ],
              contents: <Widget>[
                Container(child:SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _titleContainer("Location"),
                      ),
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      MapBoxPlaceSearchWidget(
                                        // height: 50,
                                        popOnSelect: true,
                                        apiKey:
                                        "pk.eyJ1IjoibWFsZWs3NTEiLCJhIjoiY2t1YTh3d3Y4MGVmdzJubXZhbjNuZnE1aiJ9.fOE93kvySi-HSIgEhixglQ",
                                        searchHint: 'Your Hint here',
                                        onSelected: (place) {
                                          list.add(place.text);
                                          setState(() {
                                            value=place.text;
                                            _findRestaurantsWithLocation(value);
                                          });
                                        },
                                        context: context,
                                      ),
                                      Container(
                                        height:MediaQuery.of(context).size.height*0.4,
                                        child: ListView.builder(
                                            itemCount: list.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(list[index]),
                                                //leading: new Icon(Icons.share),
                                                onTap: () {
                                                  setState(() {
                                                    value = list[index];
                                                  });
                                                  _findRestaurantsWithLocation(value);

                                                  Navigator.pop(context);
                                                },
                                              );
                                            }),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Icon(Icons.place_outlined),
                              Text(value),
                              Icon(Icons.arrow_drop_down_rounded)
                            ],
                          )),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: _titleContainer("Type of establishment"),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Wrap(
                              //spacing: 5.0,
                              //runSpacing: 3.0,
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

                      Divider(
                        color: Colors.blueGrey,
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _titleContainer("Budget"),
                      ),
                      Align(
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

                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: _titleContainer("Ambiance"),
                      // ),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Container(
                      //       child: Wrap(
                      //     spacing: 5.0,
                      //     runSpacing: 3.0,
                      //     children: <Widget>[
                      //       FilterChipWidget(
                      //         chipName: 'Festive',
                      //         chips: ambiance,
                      //       ),
                      //       FilterChipWidget(
                      //         chipName: 'Calm',
                      //         chips: ambiance,
                      //       ),
                      //       FilterChipWidget(
                      //         chipName: 'Romantic',
                      //         chips: ambiance,
                      //       ),
                      //       FilterChipWidget(
                      //         chipName: 'Business',
                      //         chips: ambiance,
                      //       ),
                      //       FilterChipWidget(
                      //         chipName: 'Family',
                      //         chips: ambiance,
                      //       ),
                      //     ],
                      //   )),
                      // ),
                      Divider(
                        color: Colors.blueGrey,
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _titleContainer("General"),
                      ),
                      Align(
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
                      Divider(
                        color: Colors.blueGrey,
                        height: 10.0,
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // TextButton(
                      //     onPressed: () {
                      //       findRestaurantUsingAmbiance(ambiance);
                      //       //findRestaurantUsingCuisine(cuisine);
                      //       findRestaurantUsingEtablissement(etablissment);
                      //       findRestaurantUsingGeneral(general);
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => ResultRecherche(
                      //                 restaurantsIDs: results,
                      //               )));
                      //     },
                      //     child: Text(
                      //       'Find restaurant',
                      //     ))
                    ],
                  ),
                ),),
                Container(child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _titleContainer('Kitchen'),
                      ),
                    ),
                    Align(
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
                  ],
                ),),
                Container(child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _titleContainer("Ambiance"),
                    ),
                    Align(
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
                  ],
                ),),
                Container(),
              ],
            ),

          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,

              ),
     child: TextButton(
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
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(
               'Find restaurant',
             style: textStyle,
           ),
         )),
            ),
          )
        ],
      ),
    );
  }


}
