import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/client/Profil.dart';
import 'package:tawelticlient/widget/RestauCard.dart';
import 'package:tawelticlient/widget/RestaurantCard.dart';

import 'constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClientProfil()));
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: KBlue,
                    backgroundImage: AssetImage('assets/profil.png'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Hello Jhon!',
                  style: TextStyle(
                      fontSize: 25,
                      color: KBlue,
                      fontFamily: 'ProductSans',
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height * 0.08),
            child: Divider(
              thickness: 2,
              color: KBeige,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(30),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: KBlue,
                      fontSize: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: KBlue, width: 1),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: KBlue,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RestauCard(
                    image: 'assets/tunisienne.jpg',
                    title: 'Cuisine\n tunisienne',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RestauCard(
                    image: 'assets/tunisienne.jpg',
                    title: 'Cuisine\n tunisienne',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RestauCard(
                    image: 'assets/tunisienne.jpg',
                    title: 'Cuisine\n tunisienne',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RestauCard(
                    image: 'assets/tunisienne.jpg',
                    title: 'Cuisine\n tunisienne',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RestauCard(
                    image: 'assets/tunisienne.jpg',
                    title: 'Cuisine\n tunisienne',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RestaurantCard(
                  image: 'assets/restaurant.jpg',
                  title: 'Mon restau',
                  soustitle: 'Rue habib bourguiba',
                ),
                RestaurantCard(
                  image: 'assets/restaurant.jpg',
                  title: 'Mon restau',
                  soustitle: 'Rue habib bourguiba',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
