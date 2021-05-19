import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/widget/EventCard.dart';
import 'package:tawelticlient/widget/profileCarousel.dart';

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 3, vsync: this);
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
              text: "Happy hour",
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.6,
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
                                  text: '22, R. Maroc',
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
                                  text: 'Que vous nous rendiez visite pour des motifs d\'affaires ou de loisirs, un chaleureux accueil vous attend tout comme chez vous. Le Plaza vous offre un jardin paisible et tranquille ainsi qu\'une piscine avec vue panoramique sur la mer Méditerranée.',
                                  style: TextStyle(fontSize: 20, color: KBlue),

                                ),
                              ],
                            ),
                        ),
                      ],
                    ),
                  )),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      EventCard(),
                      SizedBox(
                        height: 20,
                      ),
                      EventCard(),
                      SizedBox(
                        height: 20,
                      ),
                      EventCard(),
                      SizedBox(
                        height: 20,
                      ),
                      EventCard(),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
