import 'package:flutter/material.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/widget/NestedTab.dart';
import 'package:tawelticlient/widget/RoundedButton.dart';
 class RestaurantProfil extends StatefulWidget {
   @override
   _RestaurantProfilState createState() => _RestaurantProfilState();
 }
 class _RestaurantProfilState extends State<RestaurantProfil> {
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
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                 image: DecorationImage(
                     colorFilter: ColorFilter.mode(
                         Color(0xFFFEFEFE).withOpacity(0.7), BlendMode.dstATop),
                     image: AssetImage('assets/restau.jpg'),
                     fit: BoxFit.cover),
               ),
               child: RichText(
                 text: TextSpan(
                   children: <TextSpan>[
                     TextSpan(text: 'Welcome to\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30 , letterSpacing: 2 , color: KBlue)),
                     TextSpan(text: ' My restaurant', style: TextStyle(fontSize: 30, color: KBlue)),
                   ],
                 ),
               ),
             ),
            NestedTabBar(),
           ],
         ),
       ),
     );
   }
 }
 