import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ProfileCarousel extends StatefulWidget {
  @override
  _ProfileCarouselState createState() => _ProfileCarouselState();
}

class _ProfileCarouselState extends State<ProfileCarousel> {

  int _currentIndex=0;

  List cardList=[
    Item1(),
    Item2(),
    Item3(),
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: false,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: cardList.map((card){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: card,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(cardList, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? KBlue : Colors.grey,
                ),
              );
            }),
          ),
        ],
      )
    );
  }
}
class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Color(0xFFFEFEFE), BlendMode.dstATop),
            image: ExactAssetImage('assets/restaurant.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Color(0xFFFEFEFE), BlendMode.dstATop),
            image: ExactAssetImage('assets/restaurant1.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(
                Color(0xFFFEFEFE), BlendMode.dstATop),
            image: ExactAssetImage('assets/restaurant2.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}
