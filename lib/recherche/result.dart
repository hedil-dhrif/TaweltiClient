import 'package:flutter/material.dart';
import 'package:tawelticlient/widget/RechercheBar.dart';

import '../constants.dart';

class Resultrecherche extends StatefulWidget {
  const Resultrecherche({Key key}) : super(key: key);

  @override
  _ResultrechercheState createState() => _ResultrechercheState();
}

class _ResultrechercheState extends State<Resultrecherche> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              RechercherBar(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      Text(
                          'Filtred by: ',
                        style: TextStyle(
                          fontSize: 15,
                          color: KBlue,
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
              RechercheCard(),
              SizedBox(height: 15,),
              RechercheCard(),
              SizedBox(height: 15,),
              RechercheCard(),
              SizedBox(height: 15,),
            ],
          )
        ],
      ),
    );
  }
}

class RechercheCard extends StatelessWidget {
  const RechercheCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.325,
      decoration: BoxDecoration(
        color: KBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                  'assets/restaurant.jpg',
                height: 120,
                width: 120,
              ),
              Column(
                children: [
                  Text(
                      'Restaurant name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.5
                    ),
                  ),
                  Text(
                      'Restaurant name',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.5
                    ),
                  ),
                  Text(
                      'Restaurant name',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.5
                    ),
                  ),
                ],
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Resultcontainer(),
                SizedBox(width: 15,),
                Resultcontainer(),
                SizedBox(width: 15,),
                Resultcontainer(),
                SizedBox(width: 15,),
                Resultcontainer(),
                SizedBox(width: 15,),
                Resultcontainer(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Resultcontainer extends StatelessWidget {
  const Resultcontainer({
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
