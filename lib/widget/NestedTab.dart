import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/DetailsEvent.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/Cuisine.dart';
import 'package:tawelticlient/models/ambiance.dart';
import 'package:tawelticlient/models/etablissement.dart';
import 'package:tawelticlient/models/event.dart';
import 'package:tawelticlient/models/general.dart';
import 'package:tawelticlient/models/user.dart';
import 'package:tawelticlient/services/ambiance.services.dart';
import 'package:tawelticlient/services/cuisine.services.dart';
import 'package:tawelticlient/services/etablissement.services.dart';
import 'package:tawelticlient/services/general.services.dart';
import 'package:tawelticlient/services/restaurant.services.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:tawelticlient/widget/EventCard.dart';
import 'package:tawelticlient/widget/profileCarousel.dart';

import '../reservation/AddReservation.dart';

class NestedTabBar extends StatefulWidget {
  final int restaurantId;
  final int userId;
  final String adresse;
  final String kitchen;
  final String phone;
  final String web;
  final String description;
  final String etablissement;
  final String general;
  final String ambiance;

  NestedTabBar(
      {this.restaurantId,
      this.adresse,
      this.description,
      this.userId,
      this.phone,
      this.web,
      this.kitchen,
      this.etablissement,
      this.general,
      this.ambiance});
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  UserServices get userService => GetIt.I<UserServices>();
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  CuisineServices get cuisineService => GetIt.I<CuisineServices>();
  AmbianceServices get ambianceService => GetIt.I<AmbianceServices>();
  EtablissementServices get etablissementService => GetIt.I<EtablissementServices>();
  GeneralServices get generalService => GetIt.I<GeneralServices>();

  List<Event> events = [];
  final List<String> listCuisines = [];
  final List<String> listAmbiances = [];
  final List<String> listEtablissements = [];
  final List<String> listGeneral = [];

  APIResponse<List<Event>> _apiResponse;
  APIResponse<List<Cuisine>> _cuisineResponse;
  APIResponse<List<Ambiance>> _ambianceResponse;
  APIResponse<List<Etablissement>> _etablissementResponse;
  APIResponse<List<General>> _generalResponse;

  bool get isEditing => widget.restaurantId != null;
  bool _isLoading = false;
  String errorMessage;
  String email;
  String phone;
  bool _enabled = true;
  User user;

  void initState() {
    super.initState();
    print(widget.restaurantId);
    _fetchEvents();
    _fetchCuisines();
    _fetchAmbiances();
    _fetchEtablissement();
    _fetchGeneral();
    super.initState();
    _nestedTabController = new TabController(length: 3, vsync: this);
  }

  _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await restaurantService
        .getRestaurantsListEvents(widget.restaurantId.toString());
    print(_apiResponse.data.length);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          unselectedLabelStyle: TextStyle(fontSize: 20),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: KBeige, width: 1),
          ),
          controller: _nestedTabController,
          indicatorColor: KBeige,
          labelColor: KBlue,
          unselectedLabelColor: KBlue,
          isScrollable: true,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          tabs: <Widget>[
            Tab(
              text: "Détails",
            ),
            Tab(
              text: "Events",
            ),
            Tab(
              text: "Reviews",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.5,
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileCarousel(),
                        SizedBox(
                          height: 10,
                        ),
                        Information(
                          titre1: 'Location: ',
                          titre2: widget.adresse,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Information(
                          titre1: 'Kitchen: ',
                          titre2: widget.kitchen,
                        ),
                        Wrap(
                          children: List.generate(listCuisines.length, (index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: KBlue, width: 1),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                listCuisines[index].toString(),
                                style: TextStyle(
                                  //fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: KBlue,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Information(
                          titre1: 'Establishment: ',
                          titre2: widget.etablissement,
                        ),
                        Wrap(
                          children: List.generate(listEtablissements.length, (index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: KBlue, width: 1),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                listEtablissements[index].toString(),
                                style: TextStyle(
                                  //fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: KBlue,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Information(
                          titre1: 'Ambiance: ',
                          titre2: '',
                        ),
                        Wrap(
                          children: List.generate(listAmbiances.length, (index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: KBlue, width: 1),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                listAmbiances[index].toString(),
                                style: TextStyle(
                                  //fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: KBlue,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Information(
                          titre1: 'General: ',
                          titre2: '',
                        ),
                        Wrap(
                          children: List.generate(listGeneral.length, (index) {
                            return Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: KBlue, width: 1),
                                borderRadius: BorderRadius.circular(50)
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                listGeneral[index].toString(),
                                style: TextStyle(
                                  //fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: KBlue,
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Information(
                          titre1: 'Phone number: ',
                          titre2: widget.phone,
                        ),
                        /*Information(
                          titre1: 'Siteweb: ',
                          titre2: widget.web,
                        ),*/
                        SizedBox(
                          height: 15,
                        ),
                        Information(
                          titre1: 'Budget: ',
                          titre2: '***',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Information(
                          titre1: 'Description: ',
                          titre2: widget.description,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: _buildEventsList(_apiResponse.data),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Color(0xFFF4F4F4),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildEventsList(List data) {
    return Container(
      child: ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return EventCard(
            EventName: data[index].nom,
            category: data[index].category,
            description: data[index].description,
            pressDetails: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsEvent(
                            eventId: data[index].id,
                          ))).then((__) => _fetchEvents());
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black87,
        ),
      ),
    );
  }

  _fetchCuisines() async {
    setState(() {
      _isLoading = true;
    });

    _cuisineResponse = await cuisineService
        .getRestaurantsListCuisine(widget.restaurantId.toString());
    _buildListCuisines();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListCuisines() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _cuisineResponse.data.length; i++) {
      if (listCuisines.contains(_cuisineResponse.data[i].type)) {
        i++;
      } else {
        listCuisines.add(_cuisineResponse.data[i].type);
      }
    }
    print(listCuisines);
    setState(() {
      _isLoading = false;
    });
  }

  _fetchEtablissement() async {
    setState(() {
      _isLoading = true;
    });

    _etablissementResponse = await etablissementService
        .getRestaurantsListEtablissement(widget.restaurantId.toString());
    _buildListEtablissement();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListEtablissement() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i <_etablissementResponse.data.length; i++) {
      if (listEtablissements.contains(_etablissementResponse.data[i].type)) {
        i++;
      } else {
        listEtablissements.add(_etablissementResponse.data[i].type);
      }
    }
    print(listEtablissements);
    setState(() {
      _isLoading = false;
    });
  }

  _fetchGeneral() async {
    setState(() {
      _isLoading = true;
    });

    _generalResponse = await generalService
        .getRestaurantsListGeneral(widget.restaurantId.toString());
    _buildListGeneral();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListGeneral() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _generalResponse.data.length; i++) {
      if (listGeneral.contains(_generalResponse.data[i].type)) {
        i++;
      } else {
        listGeneral.add(_generalResponse.data[i].type);
      }
    }
    print(listGeneral);
    setState(() {
      _isLoading = false;
    });
  }

  _fetchAmbiances() async {
    setState(() {
      _isLoading = true;
    });

    _ambianceResponse = await ambianceService
        .getRestaurantsListAmbiance(widget.restaurantId.toString());
    _buildListAmbiance();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListAmbiance() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _ambianceResponse.data.length; i++) {
      if (listAmbiances.contains( _ambianceResponse.data[i].type)) {
        i++;
      } else {
        listAmbiances.add(_ambianceResponse.data[i].type);
      }
    }
    print(listAmbiances);
    setState(() {
      _isLoading = false;
    });
  }
}

class Information extends StatelessWidget {
  final String titre1;
  final String titre2;

  const Information({
    Key key,
    this.titre1,
    this.titre2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: titre1,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: KBlue),
          ),
          TextSpan(
            text: titre2,
            style: TextStyle(fontSize: 20, color: KBlue),
          ),
        ],
      ),
    );
  }
}
