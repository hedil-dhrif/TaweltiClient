import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/widget/DisabledInputbox.dart';
import 'package:tawelticlient/widget/EventCard.dart';
import 'package:tawelticlient/widget/profileCarousel.dart';
import 'package:tawelticlient/widget/reservecard.dart';

class NestedBarClient extends StatefulWidget {
  @override
  _NestedBarClientState createState() => _NestedBarClientState();
}

class _NestedBarClientState extends State<NestedBarClient>
    with TickerProviderStateMixin {
  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
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
              text: "Historique réservation",
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
                        DisabledInputBox(
                          label: 'User name:',
                          inputHint: 'Jhon Doe',
                          color: KBlue,
                        ),
                        DisabledInputBox(
                          label: 'Phone number:',
                          inputHint: '23698514',
                          color: KBlue,
                        ),
                        DisabledInputBox(
                          label: 'governorate:',
                          inputHint: 'Nabeul',
                          color: KBlue,
                        ),
                        DisabledInputBox(
                          label: 'Email:',
                          inputHint: 'JhonDoe@email.com',
                          color: KBlue,
                        ),
                      ],
                    ),
                  ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      ReservationCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
