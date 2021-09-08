
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/models/fileEvent.dart';
import 'package:tawelticlient/services/event.services.dart';
import 'package:tawelticlient/services/fileEvent.services.dart';
import 'package:tawelticlient/widget/DisabledInputbox.dart';
import 'package:tawelticlient/widget/EventList.dart';
import 'package:tawelticlient/models/event.dart';
import 'package:tawelticlient/widget/ImageBox.dart';

import '../constants.dart';

class DetailsEvent extends StatefulWidget {
 final int eventId;
 DetailsEvent({this.eventId});
  @override
  _DetailsEventState createState() => _DetailsEventState();
}

class _DetailsEventState extends State<DetailsEvent> {
  bool get isEditing => widget.eventId != null;
  EventServices get waitersService => GetIt.I<EventServices>();
  String errorMessage;
  Event event;
  bool _isLoading= false;
  bool _isEnabled =false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();

  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      waitersService.getEvent(widget.eventId.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        event = response.data;
        print(event);
        _nameController.text=event.nom;
        _descriptionController.text=event.description;
        _startController.text=event.dateDebut as String;
        _endController.text=event.dateFin as String;
        _categoryController.text=event.category;

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EventList()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Text(
            'Event list',
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(right: 50),
              decoration: BoxDecoration(border: Border.all(color: Colors.black87),borderRadius: BorderRadius.circular(4)),
              child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                setState(() {
                  _isEnabled=!_isEnabled;

                });
              }),
            ),
            DisabledInputBox(
              enabled:_isEnabled ,
              controller: _nameController,
              label: 'Event name: ',
              inputHint: 'XXXXX',
              color: KBlue,
            ),
            DisabledInputBox(
              enabled:_isEnabled ,

              controller: _categoryController,
              label: 'Event category: ',
              inputHint: 'XXXXX',
              color: KBlue,
            ),
            DisabledInputBox(
              enabled:_isEnabled ,

              controller: _descriptionController,
              label: 'Event description: ',
              inputHint: 'lorem ipsium ...',
              color: KBlue,
            ),
            DisabledInputBox(
              enabled:_isEnabled ,

              controller: _startController,
              label: 'Start at:',
              inputHint: '20:00',
              color: KBlue,
            ),
            DisabledInputBox(
              enabled:_isEnabled ,

              controller: _endController,
              label: 'End at:',
              inputHint: '22:00',
              color: KBlue,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Text(
                'Event images : ',
                style: TextStyle(
                  fontFamily: 'Product Sans',
                  fontSize: 20,
                  color: Color(0xff8f9db5),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                  SizedBox(
                    width: 20,
                  ),
                  ImageBox(),
                ],
              ),

            ),
            _isEnabled?FlatButton(onPressed: () async{
              setState(() {
                _isLoading = true;
              });
              final event = Event(
                nom: _nameController.text,
                category: _categoryController.text,
                description: _descriptionController.text,
                //createdAt: _startController.text,
              );
              final result = await waitersService.updateEvent(widget.eventId.toString(), event);

              setState(() {
                _isLoading = false;
              });

              final title = 'Done';
              final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your event was updated';

              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(title),
                    content: Text(text),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  )
              );

            }, child: Text('submit')):Container(),
          ],
        ),
      ),
    );
  }


}
