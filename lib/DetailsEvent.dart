import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/event.dart';
import 'package:tawelticlient/models/fileEvent.dart';
import 'package:tawelticlient/services/event.services.dart';
import 'package:tawelticlient/services/fileEvent.services.dart';
import 'package:tawelticlient/widget/ImageBox.dart';
import 'package:http/http.dart' as http;
import 'widget/DisabledInputbox.dart';

class DetailsEvent extends StatefulWidget {
 final int eventId;
 DetailsEvent({this.eventId});
  @override
  _DetailsEventState createState() => _DetailsEventState();
}

class _DetailsEventState extends State<DetailsEvent> {
  bool get isEditing => widget.eventId != null;
  EventServices get eventsService => GetIt.I<EventServices>();
  String errorMessage;
  Event event;
  bool _isLoading= false;
  bool _isEnabled =false;
  APIResponse<List<FileEvent>> _apiResponseFiles;
  List<FileEvent> eventFiles=[];
  FileEventServices get fileEventsService => GetIt.I<FileEventServices>();

  String _name;
  String _category;
  String _description;
  void initState() {
    super.initState();
print(widget.eventId);
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
        _name=event.nom;
        _description=event.description;
        _category=event.category;

      });
    }
_fetchEventsFiles();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         _buildList(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Event name: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: KBlue),
                      ),
                      TextSpan(
                        text: _name,
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
                        text: 'Category: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: KBlue),
                      ),
                      TextSpan(
                        text: _category,
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
                        text: _description,
                        style: TextStyle(fontSize: 20, color: KBlue),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          //   child: Text(
          //     'Event images : ',
          //     style: TextStyle(
          //       fontFamily: 'Product Sans',
          //       fontSize: 20,
          //       color: Color(0xff8f9db5),
          //     ),
          //   ),
          // ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: [
          //       ImageBox(),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       ImageBox(),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       ImageBox(),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       ImageBox(),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       ImageBox(),
          //     ],
          //   ),
          //
          // ),
        ],
      ),
    );
  }

  _fetchEventsFiles() async{
    setState(() {
      _isLoading = true;
    });

    _apiResponseFiles = await fileEventsService.getListAmbiance(widget.eventId.toString());
    print( _apiResponseFiles.data.length);
    print( _apiResponseFiles.data);
    for(int i=0;i<_apiResponseFiles.data.length;i++){
      eventFiles.add( _apiResponseFiles.data[i]);
      print(eventFiles[i].url);
    }    setState(() {
      _isLoading = false;
    });

    // final response = await http
    //     .get(Uri.parse('http://10.0.2.2:3000/fileEvent/info/'+widget.eventId.toString()));
    //
    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   print(jsonDecode(response.body));
    //   //return FileEvent.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  _buildList() {
    return Container(
      height: MediaQuery.of(context).size.height*0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eventFiles.length,
        itemBuilder: (context, int i) {
          return Container(
            child: Image.network(eventFiles[i].url),
          );
        },
      ),
    );
  }
}
