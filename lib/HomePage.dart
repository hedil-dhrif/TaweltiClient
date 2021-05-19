import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/Restaurant/RestaurantProfil.dart';
import 'package:tawelticlient/client/Profil.dart';
import 'package:tawelticlient/widget/AppBar.dart';
import 'package:tawelticlient/widget/RestaurantCard.dart';

import 'constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClientProfil()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: KBlue,
                backgroundImage: AssetImage('assets/profil.png'),
              ),
            ),
          ),
          title: 'Hello Jhon',
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      endDrawer: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer Header'),
                  decoration: BoxDecoration(
                    color: KBlue,
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(CupertinoIcons.settings),
                      Text('paramètres'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.logout),
                      Text('déconnexion'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )),
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
            Container(
              padding: EdgeInsets.only(right: 20, bottom: 25),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cuisine type: ',
                            style: TextStyle(
                              fontSize: 25,
                              color: KBlue
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.square,
                                color: KBeige,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                  'Cuisine arabe',
                                style: TextStyle(
                                  fontSize: 17.5,
                                  color: KBlue
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.square,
                                color: KBeige,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'Cuisine thailandaise',
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: KBlue
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.square,
                                color: KBeige,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'Cuisine japonaise',
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: KBlue
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.square,
                                color: KBeige,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'Cuisine italienne',
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: KBlue
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Location: ',
                            style: TextStyle(
                                fontSize: 25,
                                color: KBlue
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.square,
                                color: KBeige,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'Sea view',
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: KBlue
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.square,
                                color: KBeige,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'Mountain view',
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: KBlue
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.square,
                                color: KBeige,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                'IN the city',
                                style: TextStyle(
                                    fontSize: 17.5,
                                    color: KBlue
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (contest) => RestaurantProfil()));
                  },
                  child: RestaurantCard(
                    image: 'assets/plaza_corniche.jpg',
                    title: 'Plaza cornich',
                    soustitle: 'La marsa',
                  ),
                ),
                RestaurantCard(
                  image: 'assets/the_cliff.jpg',
                  title: 'the cliff',
                  soustitle: 'Sidi Dhrif',
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RestaurantCard(
                  image: 'assets/maison_bleue.jpg',
                  title: 'Le maison bleue',
                  soustitle: 'Sidi Bou Said',
                ),
                RestaurantCard(
                  image: 'assets/villa_didon.jpg',
                  title: 'Villa Didon',
                  soustitle: 'Carthage',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBoxModal {
  String title;
  bool checked;

  CheckBoxModal({@required this.title, @required this.checked = false});
}
