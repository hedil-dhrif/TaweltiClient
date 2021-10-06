import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:readmore/readmore.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/event.dart';
import 'package:tawelticlient/services/event.services.dart';
import 'package:tawelticlient/widget/profileCarousel.dart';

class DetailsEvent extends StatefulWidget {
  final int eventId;
  DetailsEvent({this.eventId});
  @override
  _DetailsEventState createState() => _DetailsEventState();
}

class _DetailsEventState extends State<DetailsEvent> {
  bool clickedm = false;
  Color _ContainerColorP = Colors.white;
  Color _TextColorP = KBlue;

  Color _ContainerColorI = Colors.white;
  Color _TextColorI = KBlue;

  bool get isEditing => widget.eventId != null;
  EventServices get eventsService => GetIt.I<EventServices>();
  String errorMessage;
  Event event;
  bool _isLoading = false;
  bool _isEnabled = false;
  String _name;
  DateTime _datedebut;
  DateTime _heuredebut;
  String _category;
  String _description;
  int _restaurantId;

  void initState() {
    super.initState();

    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      eventsService.getEvent(widget.eventId.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        event = response.data;
        print(event);
        _name = event.nom;
        _description = event.description;
        _category = event.category;
        _datedebut = event.dateDebut;
        _restaurantId = event.restaurantId;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xf6f6f6),
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Text(
            'Event Details',
            style: TextStyle(
                fontSize: 25,
                color: KBlue,
                fontFamily: 'ProductSans',
                letterSpacing: 1,
                fontWeight: FontWeight.w100),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/event.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _category,
                            style: TextStyle(
                              fontSize: 22.5,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20, left: 20),
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '15',
                        style: TextStyle(
                            color: KBlue,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _ContainerColorP = KBeige;
                      _TextColorP = Colors.white;
                      _ContainerColorI = Colors.white;
                      _TextColorI = KBlue;
                      clickedm = true;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.075,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _ContainerColorP,
                        border: Border.all(color: KBeige, width: 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.done,
                          size: 30,
                          color: _TextColorP,
                        ),
                        Text(
                          'Participate',
                          style: TextStyle(fontSize: 20, color: _TextColorP),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _ContainerColorI = KBeige;
                      _TextColorI = Colors.white;
                      _ContainerColorP = Colors.white;
                      _TextColorP = KBlue;
                      clickedm = false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.075,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: KBeige, width: 1),
                        color: _ContainerColorI),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 30,
                          color: _TextColorI,
                        ),
                        Text(
                          'Interested',
                          style: TextStyle(fontSize: 20, color: _TextColorI),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 20),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Description:\n',
                    style: TextStyle(
                      color: KBlue,
                      fontSize: 22.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: _description,
                    style: TextStyle(
                      color: KBlue,
                      fontSize: 15,
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, left: 20, bottom: 15),
              child: Text(
                'Images: ',
                style: TextStyle(
                  color: KBlue,
                  fontSize: 22.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ProfileCarousel(
              restaurantId: _restaurantId.toString(),
            )
          ],
        ),
      ),
    );
  }
}
