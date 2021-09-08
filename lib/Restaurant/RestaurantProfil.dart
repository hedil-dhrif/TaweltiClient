import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/models/file.dart';
import 'package:tawelticlient/reservation/AddReservation.dart';
import 'package:tawelticlient/services/file.services.dart';
import 'package:tawelticlient/services/restaurant.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:tawelticlient/widget/NestedTab.dart';
import 'package:tawelticlient/services/cuisine.services.dart';
import 'package:tawelticlient/widget/profileCarousel.dart';

class RestaurantProfil extends StatefulWidget {
  final int restaurantId;
  RestaurantProfil({this.restaurantId});
  @override
  _RestaurantProfilState createState() => _RestaurantProfilState();
}

class _RestaurantProfilState extends State<RestaurantProfil> {
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  FileServices get fileService => GetIt.I<FileServices>();
  CuisineServices get cuisineServices => GetIt.I<CuisineServices>();

  bool get isEditing => widget.restaurantId != null;
  bool _isLoading = false;

  String errorMessage;
  String adresse;
  String description;
  String name;
  String phone;
  String email;
  String web;
  int userId;
  String kitchen;
  bool _enabled = true;
  Restaurant restaurant;
  String etablissement;
  String general;
  String ambiance;

  @override
  void initState() {
    print(widget.restaurantId);
    if (isEditing) {
      setState(() {
        _isLoading = false;
      });
      restaurantService
          .getRestaurant(widget.restaurantId.toString())
          .then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        restaurant = response.data;
        adresse = restaurant.adresse;
        description = restaurant.description;
        name = restaurant.NomResto;
        userId = restaurant.userId;
        //kitchen = cuisine.type;
        print(adresse);
        //print(kitchen);
        print(description);
        print(name);
        print(userId);
        //phoneController.text=reservation.etat.toString();
        //_contentController.text = note.noteContent;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(80.0),
      //   child: AppBarWidget(
      //     title: name,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  child: ProfileCarousel(
                      restaurantId: widget.restaurantId.toString()),
                  // padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(10),
                  //       bottomRight: Radius.circular(10)),
                  //   image: DecorationImage(
                  //       colorFilter: ColorFilter.mode(
                  //           Color(0xFFFEFEFE).withOpacity(0.5), BlendMode.dstATop),
                  //       image: AssetImage('assets/plaza_corniche.jpg'),
                  //       fit: BoxFit.cover),
                  // ),
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     RichText(
                  //       text: TextSpan(
                  //         children: <TextSpan>[
                  //           TextSpan(
                  //               text: 'Welcome to\n',
                  //               style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 30,
                  //                   letterSpacing: 2,
                  //                   color: KBlue)),
                  //           TextSpan(
                  //               text: name,
                  //               style: TextStyle(fontSize: 30, color: KBlue)),
                  //         ],
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => PassReservation(restaurantId:widget.restaurantId ,)));
                  //       },
                  //       child: Container(
                  //         padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: KBlue
                  //         ),
                  //         child: Text('Reserve', style: TextStyle( color: Colors.white, fontSize: 25),),
                  //       ),
                  //     )
                  //   ],
                  // ),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.black12],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 30,
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 30,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 200,
                          child: Text(
                            name.toUpperCase(),
                            style: TextStyle(
                                color: KBlue,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          )),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.black12,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: KBeige,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          flex: 8,
                          child: Text(
                            adresse,
                            style: TextStyle(fontSize: 16, color: KBlue),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: KBeige,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 8,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Closed in 45 minutes',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: KBeige,
                                    decoration: TextDecoration.underline),
                              ),
                              TextSpan(
                                text: '11AM To 12 Midnight',
                                style: TextStyle(fontSize: 16, color: KBlue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PassReservation(restaurantId:widget.restaurantId ,)));
                    },
                    child: Text(
                      'Add reservation',
                      style: TextStyle(fontSize: 16, color: KBeige),
                    ),
                  ),
                ],
              ),
            ),

            NestedTabBar(
              restaurantId: widget.restaurantId,
              adresse: adresse,
              description: description,
              // phone: 'phone',
              // web: 'web',
              userId: userId,
              // kitchen: kitchen,
              // etablissement: etablissement,
              // general: general,
              // ambiance: ambiance,
            ),
          ],
        ),
      ),
    );
  }
}
