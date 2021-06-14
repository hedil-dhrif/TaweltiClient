import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/Restaurant.dart';
import 'package:tawelticlient/services/restaurant.services.dart';
import 'package:tawelticlient/widget/NestedTab.dart';
import 'package:tawelticlient/widget/RoundedButton.dart';
 class RestaurantProfil extends StatefulWidget {
   final int restaurantId;
   RestaurantProfil({this.restaurantId});
   @override
   _RestaurantProfilState createState() => _RestaurantProfilState();
 }
 class _RestaurantProfilState extends State<RestaurantProfil> {
   RestaurantServices get restaurantService => GetIt.I<RestaurantServices>();

   bool get isEditing => widget.restaurantId != null;
   bool _isLoading = false;
   String errorMessage;
   String adresse;
   String description;
   String name;
   int userId;
   bool _enabled= true;
   Restaurant restaurant;
   @override
  void initState() {
     print(widget.restaurantId);
     if (isEditing) {
       setState(() {
         _isLoading = false;
       });
       restaurantService.getRestaurant(widget.restaurantId.toString()).then((response) {
         setState(() {
           _isLoading = false;
         });

         if (response.error) {
           errorMessage = response.errorMessage ?? 'An error occurred';
         }
         restaurant = response.data;
         adresse=restaurant.adresse;
         description=restaurant.description;
         name=restaurant.NomResto;
         userId=restaurant.userId;
         print(adresse);
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
       body: SingleChildScrollView(
         child: Column(
           children: [
             Container(
               margin: EdgeInsets.only(bottom: 20),
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height*0.3,
               padding: EdgeInsets.fromLTRB(20, 100, 20, 30),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                 image: DecorationImage(
                     colorFilter: ColorFilter.mode(
                         Color(0xFFFEFEFE).withOpacity(0.5), BlendMode.dstATop),
                     image: AssetImage('assets/plaza_corniche.jpg'),
                     fit: BoxFit.cover),
               ),
               child: RichText(
                 text: TextSpan(
                   children: <TextSpan>[
                     TextSpan(text: 'Welcome to\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30 , letterSpacing: 2 , color: KBlue)),
                     TextSpan(text: name, style: TextStyle(fontSize: 30, color: KBlue)),
                   ],
                 ),
               ),
             ),
            NestedTabBar(restaurantId: widget.restaurantId,adresse: adresse,description: description,userId:userId ,),
           ],
         ),
       ),
     );
   }
 }
 