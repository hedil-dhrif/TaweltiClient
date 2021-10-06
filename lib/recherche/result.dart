import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/Restaurant/RestaurantProfil.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/services/restaurant.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:tawelticlient/widget/RechercheBar.dart';

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
  String adresse;
  String description;
  String name;
  String phone;
  String email;
  String web;
  int userId;
  String kitchen;
  bool _enabled = true;
  String etablissement;
  String general;
  String ambiance;
  int restaurantID;
  @override
  void initState() {
    print(widget.restaurantsIDs);
    _fetchFilteredRestaurants();
    super.initState();
  }

  _fetchFilteredRestaurants() async {
    print(widget.restaurantsIDs);
    for (int i = 0; i < widget.restaurantsIDs.length; i++) {
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
          adresse = restaurant.adresse;
          description = restaurant.description;
          name = restaurant.NomResto;
          restaurantID = restaurant.id;
          userId = restaurant.userId;
          //kitchen = cuisine.type;
          print(adresse);
          print('the id is ${restaurantID}');
          //print(kitchen);
          print(description);
          print(name);
          print(userId);
          //_foundRestaurants.add(restaurant);
        });
      }
    }
  }

  _buildRestaurant(restaurant) {
    print(restaurant);
    //List ListPhotos=['assets/plaza_corniche.jpg','assets/the_cliff.jpg','assets/villa_didon.jpg','assets/maison_bleue.jpg','assets/maison_bleue.jpg','assets/maison_bleue.jpg',];
    return _isLoading
        ? CircularProgressIndicator()
        : GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantProfil(
                restaurantId: restaurantID,
              )));
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
      backgroundColor: Color(0XFFF4F4F4),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: RechercheBarFilter(),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Filtrer par: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            color: KBlue,
                            fontSize: 20
                        ),
                      ),
                      FilterParameter(
                        ontapped: (){},
                        parameter: 'Les plus proches',
                      ),
                      FilterParameter(
                        ontapped: (){},
                        parameter: 'Prix',
                      ),
                      FilterParameter(
                        ontapped: (){},
                        parameter: 'Ouvert maintement',
                      ),
                      FilterParameter(
                        ontapped: (){},
                        parameter: 'évaluation',
                      ),
                    ],
                  ),
                ),
              ),
              _buildRestaurant(restaurant),
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
  RechercheCard({this.adresse, this.description, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Image.asset(
                    'assets/restaurant.jpg',
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(color: KBlue, fontSize: 17.5),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        ' * * * *',
                        style: TextStyle(color: KBlue, fontSize: 20),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        adresse,
                        style: TextStyle(color: KBlue, fontSize: 15),
                      ),
                      Divider(
                        color: KBlue,
                        thickness: 0.25,
                        height: 15,
                      ),
                      Text(
                        '\$ ' + '22.5',
                        style: TextStyle(color: KBlue, fontSize: 17.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FilterParameter extends StatelessWidget {

  final Function ontapped;
  final String parameter;

  const FilterParameter({Key key, this.ontapped, this.parameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapped,
      child: Container(
        margin: EdgeInsets.only(left: 7.5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: KBlue.withOpacity(0.75), width: 1)
        ),
        child: Center(
          child: Text(
            parameter,
            style: TextStyle(
              color: KBlue,
              fontSize: 17
            ),
          ),
        ),
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
            colorFilter: ColorFilter.mode(Color(0xFF1C3956), BlendMode.dstATop),
            image: ExactAssetImage('assets/restaurant1.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class RechercheBarFilter extends StatelessWidget {
  final TextEditingController editingController;
  final Function changed;

  const RechercheBarFilter({Key key, this.editingController, this.changed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.85,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TextField(
            controller: editingController,
            onChanged: changed,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(
                color: KBlue,
                fontSize: 17.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: KBlue, width: 1),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: KBlue,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
