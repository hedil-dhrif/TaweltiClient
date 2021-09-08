import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/file.dart';
import 'package:tawelticlient/services/file.services.dart';

import '../constants.dart';

class ProfileCarousel extends StatefulWidget {
  final String restaurantId;
  ProfileCarousel({this.restaurantId});
  @override
  _ProfileCarouselState createState() => _ProfileCarouselState();
}

class _ProfileCarouselState extends State<ProfileCarousel> {
  bool _isLoading = false;

  int _currentIndex=0;
  FileServices get fileService => GetIt.I<FileServices>();
  APIResponse<List<File>> _apiResponseFiles;
  List<Item1> restaurantFiles=[];
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
  void initState() {
    _fetchRestaurantFiles();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              autoPlay: false,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: restaurantFiles.map((card){
              return Builder(
                  builder:(BuildContext context){
                    return Container(
                     // height: MediaQuery.of(context).size.height*0.40,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: card,
                      ),
                    );
                  }
              );
            }).toList(),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: map<Widget>(restaurantFiles, (index, url) {
          //     return Container(
          //       width: 10.0,
          //       height: 10.0,
          //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: _currentIndex == index ? KBlue : Colors.grey,
          //       ),
          //     );
          //   }),
          // ),
        ],
      )
    );
  }

  _fetchRestaurantFiles() async{
    setState(() {
      _isLoading = true;
    });

    _apiResponseFiles = await fileService.getListAmbiance(widget.restaurantId);
    print( _apiResponseFiles.data.length);
    print( _apiResponseFiles.data);
    for(int i=0;i<_apiResponseFiles.data.length;i++){
      restaurantFiles.add(Item1(url: _apiResponseFiles.data[i].url,));
      print(restaurantFiles[i].url);
    }    setState(() {
      _isLoading = false;
    });
  }

}
class Item1 extends StatelessWidget {
  final String url;
  const Item1({this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(url),
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
            image: ExactAssetImage('assets/détail2.jpg'),
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
            image: ExactAssetImage('assets/détail3.jpg'),
            fit: BoxFit.cover),
      ),
    );
  }
}
