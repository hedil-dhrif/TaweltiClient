import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/services/restaurant.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:tawelticlient/widget/RechercheBar.dart';
import 'package:tawelticlient/widget/RestaurantCard.dart';

import '../constants.dart';

class ResultRecherche extends StatefulWidget {
// final List<String> ambiance;
// final List<String> general;
// final List<String> cuisine;
// final List<String> etablissemnt;
// final List<String> budget;
//ResultRecherche({this.general,this.ambiance,this.budget,this.cuisine,this.etablissemnt});
final List<int> restaurantsIDs;
ResultRecherche({this.restaurantsIDs});
  @override
  _ResultRechercheState createState() => _ResultRechercheState();
}



class _ResultRechercheState extends State<ResultRecherche> {
  RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();
  List<APIResponse<Restaurant>> _apiResponse;
  List<Restaurant> _foundRestaurants = [];
  bool _isLoading = false;
  bool get isEditing => widget.restaurantsIDs != null;
  String errorMessage;
Restaurant restaurant;
  @override
  void initState() {
    print(widget.restaurantsIDs);
   _fetchFilteredRestaurants();
    super.initState();
  }
  _fetchFilteredRestaurants() async {
    print(widget.restaurantsIDs);
    for(int i=0;i<widget.restaurantsIDs.length;i++){
      if (isEditing) {
        setState(() {
          _isLoading = false;
        });
        restaurantService
            .getRestaurant(widget.restaurantsIDs[i].toString())
            .then((response) {
          setState(() {
            _isLoading = false;
          });

          if (response.error) {
            errorMessage = response.errorMessage ?? 'An error occurred';
          }
          restaurant = response.data;
          print(restaurant);
          //_foundRestaurants.add(restaurant);
        });
      }
    }

  }
  _buildRestaurant(restaurant) {
    print(restaurant);
    //List ListPhotos=['assets/plaza_corniche.jpg','assets/the_cliff.jpg','assets/villa_didon.jpg','assets/maison_bleue.jpg','assets/maison_bleue.jpg','assets/maison_bleue.jpg',];
        return _isLoading?CircularProgressIndicator():GestureDetector(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => RestaurantProfil(
            //           restaurantId: _apiResponse[index].id,
            //         )));
          },
          child: RechercheCard(
            name: restaurant.NomResto,
            adresse: restaurant.adresse,
            description: restaurant.description,
          ),
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          title: 'Result page',
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Text(
                          'Filtred by: ',
                        style: TextStyle(
                          fontSize: 18,
                          color: KBlue,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: KBlue, width: 1)
                        ),
                        child: Text(
                            'Location',
                          style: TextStyle(
                            fontSize: 15,
                            color: KBlue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: KBlue, width: 1)
                        ),
                        child: Text(
                            'Rate',
                          style: TextStyle(
                            fontSize: 15,
                            color: KBlue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: KBlue, width: 1)
                        ),
                        child: Text(
                            'Price',
                          style: TextStyle(
                            fontSize: 15,
                            color: KBlue,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: KBlue, width: 1)
                        ),
                        child: Text(
                            'Open now',
                          style: TextStyle(
                            fontSize: 15,
                            color: KBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _buildRestaurant(restaurant),
              //RechercheCard(),
              Divider(thickness: 3.0,),
              // SizedBox(height: 15,),
              // RechercheCard(),
              // SizedBox(height: 15,),
              // RechercheCard(),
              // SizedBox(height: 15,),
            ],
          )
        ],
      ),
    );
  }
}

class RechercheCard extends StatelessWidget {

  final String name;
  final String adresse;
  final String description;
  RechercheCard({this.adresse,this.description,this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      // width: MediaQuery.of(context).size.width*0.8,
      // height: MediaQuery.of(context).size.height*0.325,
      // decoration: BoxDecoration(
      //   color: KBlue,
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  child: Image.asset(
                      'assets/restaurant.jpg',
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: KBlue,
                            fontSize: 17.5
                        ),
                      ),
                      Text(
                        adresse,
                        style: TextStyle(
                            color: KBlue,
                            fontSize: 17.5
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        child: Text(
                          description,
                          style: TextStyle(
                              color: KBlue,
                              fontSize: 12
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ResultContainer(),
                SizedBox(width: 15,),
                ResultContainer(),
                SizedBox(width: 15,),
                ResultContainer(),
                SizedBox(width: 15,),
                ResultContainer(),
                SizedBox(width: 15,),
                ResultContainer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Color(0xFF1C3956), BlendMode.dstATop),
            image: ExactAssetImage('assets/restaurant1.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}
