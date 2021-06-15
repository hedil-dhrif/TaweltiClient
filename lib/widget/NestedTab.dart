import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/DetailsEvent.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/event.dart';
import 'package:tawelticlient/models/user.dart';
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
  NestedTabBar(
      {this.restaurantId, this.adresse, this.description, this.userId, this.phone, this.web, this.kitchen});
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  UserServices get userService => GetIt.I<UserServices>();
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  List<Event> events = [];
  APIResponse<List<Event>> _apiResponse;

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
              /*Container(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileCarousel(),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Email: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: KBlue),
                                ),
                                TextSpan(
                                  text: 'plaza@gnet.tn',
                                  style: TextStyle(fontSize: 20, color: KBlue),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Phone number : ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: KBlue),
                                ),
                                TextSpan(
                                  text: ' 71 743 577',
                                  style: TextStyle(fontSize: 20, color: KBlue),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Location: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: KBlue),
                                ),
                                TextSpan(
                                  text: widget.adresse,
                                  style: TextStyle(fontSize: 20, color: KBlue),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Description: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: KBlue),
                                ),
                                TextSpan(
                                  text: widget.description,
                                  style: TextStyle(fontSize: 20, color: KBlue),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddReservation(
                                              userId: widget.userId,
                                              restaurantId: widget.restaurantId,
                                            )));
                              },
                              child: Text('add reservation'))
                        ],
                      ),
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: _buildEventsList(_apiResponse.data),
              ),*/
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
}

class Information extends StatelessWidget {

  final String titre1;
  final String titre2;

  const Information({
    Key key, this.titre1, this.titre2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: titre1,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: KBlue),
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
