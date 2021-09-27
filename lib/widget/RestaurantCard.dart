// import 'package:flutter/material.dart';
//
// import '../constants.dart';
//
// class RestaurantCard extends StatefulWidget {
//
//   final String image;
//   final String title;
//   final String soustitle;
//   final Function choose;
//
//   const RestaurantCard({Key key, this.image, this.title, this.choose, this.soustitle}) : super(key: key);
//
//
//   @override
//   _RestaurantCardState createState() => _RestaurantCardState();
// }
//
// class _RestaurantCardState extends State<RestaurantCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //height: MediaQuery.of(context).size.height*0.25,
//       width: MediaQuery.of(context).size.width*0.45,
//       decoration: BoxDecoration(
//           color: Color(0xFFF4F4F4),
//           borderRadius: BorderRadius.circular(15)
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width*0.45,
//             //height: MediaQuery.of(context).size.height*0.125,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(widget.image),
//                   //fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.circular(15)
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(left: 20, top: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.title,
//                   style: TextStyle(
//                     color: KBlue,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   widget.soustitle,
//                   style: TextStyle(
//                     color: KBlue,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/file.dart';
import 'package:tawelticlient/services/file.services.dart';
import 'package:http/http.dart' as http;

class RestoCard extends StatefulWidget {
  final String id;
  final String name;
  final String imagePath;
  final String category;
  final double discount;
  final double ratings;
  final String adresse;

  RestoCard(
      {this.id,
        this.name,
        this.imagePath,
        this.category,
        this.discount,
        this.adresse,
        this.ratings});

  @override
  _RestoCardState createState() => _RestoCardState();
}

class _RestoCardState extends State<RestoCard> {
  var cardText = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  bool _isLoading = false;
  int _currentIndex=0;
  FileServices get fileService => GetIt.I<FileServices>();
  APIResponse<List<File>> _apiResponseFiles;
  List restaurantFiles=[];
@override
  void initState() {
    // TODO: implement initState
  print(widget.id);
  _fetchRestaurantFiles();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            height: 220.0,
            width: width*0.9,
              child:CarouselSlider(
                options: CarouselOptions(height: 400.0),
                items: restaurantFiles.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.amber
                          ),
                        child:FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(i)),
                      );
                    },
                  );
                }).toList(),
              )
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            width: width*0.9,
            height: 100.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black12],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10.0,
            bottom: 20.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex:8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        widget.adresse,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 16.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 16.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 16.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 16.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Theme.of(context).primaryColor,
                            size: 16.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "(" + widget.ratings.toString() + " Reviews)",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _fetchRestaurantFiles() async{
    setState(() {
      _isLoading = true;
    });

    _apiResponseFiles = await fileService.getListAmbiance(widget.id);
    print( _apiResponseFiles.data.length);
    print( _apiResponseFiles.data);
    for(int i=0;i<_apiResponseFiles.data.length;i++){
      restaurantFiles.add(_apiResponseFiles.data[i].url.toString(),);
      print(restaurantFiles[i].toString());
    }    setState(() {
      _isLoading = false;
    });

  }
}