import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
import 'package:tawelticlient/widget/EventList.dart';
import 'package:url_launcher/url_launcher.dart';

class NestedTabBar extends StatefulWidget {
  final int restaurantId;
  final int userId;
  final String adresse;
  //final String kitchen;
  // final String phone;
  // final String web;
  final String description;
  // final String etablissement;
  // final String general;
  // final String ambiance;

  NestedTabBar({
    this.restaurantId,
    this.adresse,
    this.description,
    this.userId,
    // this.phone,
    // this.web,
    // this.kitchen,
    // this.etablissement,
    // this.general,
    // this.ambiance
  });
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
  EtablissementServices get etablissementService =>
      GetIt.I<EtablissementServices>();
  GeneralServices get generalService => GetIt.I<GeneralServices>();

  final List<Event> events = [];
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
  String _platformVersion = 'Unknown';
  String text = 'https://medium.com/@suryadevsingh24032000';
  String subject = 'follow me';
  String url= 'tel:+21626718812';
  void initState() {
    super.initState();
    print(widget.restaurantId);
    // _fetchEvents();
    _fetchCuisines();
    _fetchAmbiances();
    _fetchEtablissement();
    _fetchGeneral();
    _fetchEvents();
    super.initState();
   // _nestedTabController = new TabController(length: 3, vsync: this);
  }

  Future<void> _makeSocialMediaRequest(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // TabBar(
        //   unselectedLabelStyle: TextStyle(fontSize: 16),
        //   // indicator: BoxDecoration(
        //   //   borderRadius: BorderRadius.circular(40),
        //   //   border: Border.all(color: KBlue, width: 1),
        //   // ),
        //   controller: _nestedTabController,
        //   indicatorColor: KBeige,
        //   labelColor: KBlue,
        //   unselectedLabelColor: KBlue,
        //   isScrollable: true,
        //   labelStyle: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black,
        //   ),
        //   tabs: <Widget>[
        //     Tab(
        //       text: "Détails",
        //     ),
        //     Tab(
        //       text: "Events",
        //     ),
        //     Tab(
        //       text: "Reviews",
        //     ),
        //   ],
        // ),
        Container(
          //height: screenHeight * 0.6,
          child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ProfileCarousel(restaurantId: widget.restaurantId.toString(),),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.location_on_outlined,
                  //       color: KBeige,
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Expanded(
                  //         flex: 8,
                  //         child: Text(
                  //           widget.adresse,
                  //           style: TextStyle(fontSize: 16, color: KBlue),
                  //         )),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Icon(
                  //       Icons.access_time,
                  //       color: KBeige,
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Expanded(
                  //       flex: 8,
                  //       child: RichText(
                  //         text: TextSpan(
                  //           children: <TextSpan>[
                  //             TextSpan(
                  //               text: 'Closed in 45 minutes',
                  //               style: TextStyle(
                  //                   fontSize: 16,
                  //                   color: KBeige,
                  //                   decoration: TextDecoration.underline),
                  //             ),
                  //             TextSpan(
                  //               text: '11AM To 12 Midnight',
                  //               style:
                  //                   TextStyle(fontSize: 16, color: KBlue),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Description : ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: KBlue),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'loremupsumloremupsumloremupsumloremupsumloremupsumloremupsumloremupsumloremupsum',
                    style: TextStyle(fontSize: 16, color: KBlue),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Type : ',
                  //       style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: KBlue),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Wrap(
                  //       children: List.generate(listEtablissements.length,
                  //           (index) {
                  //         return Text(
                  //           listEtablissements[index].toString(),
                  //           style: TextStyle(
                  //             //fontWeight: FontWeight.w600,
                  //             fontSize: 16,
                  //             color: KBlue,
                  //           ),
                  //         );
                  //       }),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Food : ',
                  //       style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: KBlue),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Wrap(
                  //       children:
                  //           List.generate(listCuisines.length, (index) {
                  //         return Text(
                  //           listCuisines[index].toString() + ' , ',
                  //           style: TextStyle(
                  //             //fontWeight: FontWeight.w600,
                  //             fontSize: 16,
                  //             color: KBlue,
                  //           ),
                  //         );
                  //       }),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Ambiance: ',
                  //       style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //           color: KBlue),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     Wrap(
                  //       children:
                  //           List.generate(listAmbiances.length, (index) {
                  //         return Text(
                  //           listAmbiances[index].toString(),
                  //           style: TextStyle(
                  //             //fontWeight: FontWeight.w600,
                  //             fontSize: 16,
                  //             color: KBlue,
                  //           ),
                  //         );
                  //       }),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   'Other : ',
                  //   style: TextStyle(
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.bold,
                  //       color: KBlue),
                  // ),
                  SizedBox(
                    width: 5,
                  ),
                  Wrap(
                    children: List.generate(listGeneral.length, (index) {
                      return Text(
                        listGeneral[index].toString() + ' , ',
                        style: TextStyle(
                          //fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: KBlue,
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: KBeige.withOpacity(0.5),
                                //border: Border.all(color: KBeige),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.map_outlined,
                                  color: KBeige,
                                ))),
                        GestureDetector(
                          onTap: ()async{
                            if(await canLaunch(url))
                            {
                            await launch(url);
                            }else
                            {
                            throw 'call not possible';
                            }

                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: KBeige.withOpacity(0.5),

                                  //  border: Border.all(color: KBeige),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.call,
                                    color: KBeige,
                                  ))),
                        ),
                        GestureDetector(
                          onTap: (){
                            final Uri _emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: 'contact.tawelty@gmail.com',
                                queryParameters: {
                                  'subject': 'subject'
                                }
                            );
                            launch(_emailLaunchUri.toString());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: KBeige.withOpacity(0.5),
                                  //border: Border.all(color: KBeige),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: KBeige,
                                  ))),
                        ),
                        GestureDetector(
                          onTap: (){
                            _makeSocialMediaRequest("http://pratikbutani.com");

                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: KBeige.withOpacity(0.5),
                                  //border: Border.all(color: KBeige),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.link,
                                    color: KBeige,
                                  ))),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Text(
                      'Events : ',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: KBlue),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: EdgeInsets.only(top: 5),
                    child: EventList(
                      restaurantId: widget.restaurantId,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Text(
                      'Your Rating !',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: KBlue),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              //color: KBeige.withOpacity(0.5),
                              border: Border.all(color: KBeige),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('1'),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              // color: KBeige.withOpacity(0.5),
                              border: Border.all(color: KBeige),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('2'),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              //color: KBeige.withOpacity(0.5),
                              border: Border.all(color: KBeige),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('3'),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              //color: KBeige.withOpacity(0.5),
                              border: Border.all(color: KBeige),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('4'),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              //color: KBeige.withOpacity(0.5),
                              border: Border.all(color: KBeige),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text('5'),
                                Icon(
                                  Icons.star,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text('We would like to hear more about your experience !',style: TextStyle(fontSize: 16,color: KBlue),),
                  ),
                  TextButton( child: Text('Add your Review',style: TextStyle(color: KBeige,fontSize: 18),)),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0,bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: KBlue),
                        ),
                        Text(
                          'Read All(400) ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                              fontSize: 16,
                             // fontWeight: FontWeight.w400,
                              color: KBeige),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      CircleAvatar(
                        child: Text('M'),
                      ),
                      Column(
                        children: [
                          Text('JhonDoe'),
                          Text('45 Reviews , 353 Followers'),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: KBeige.withOpacity(0.8),
                          //  border: Border.all(color: KBeige),
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('1'),
                              Icon(
                                Icons.star,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: Text(
                      'loremupsumloremupsumloremupsumloremupsumloremupsumloremupsumloremupsumloremupsum',
                      style: TextStyle(fontSize: 16, color: KBlue),
                    ),
                  ),

                ],
              )),
        )
      ],
    );
  }

  _fetchEvents() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await restaurantService
        .getRestaurantsListEvents(widget.restaurantId.toString());
    print(_apiResponse.data.length);
    _buildEventsList(events);
    setState(() {
      _isLoading = false;
    });
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
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => DetailsEvent(
              //               eventId: data[index].id,
              //             ))).then((__) => _fetchEvents());
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

    for (int i = 0; i < _etablissementResponse.data.length; i++) {
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
      if (listAmbiances.contains(_ambianceResponse.data[i].type)) {
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
