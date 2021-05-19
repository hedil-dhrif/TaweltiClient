import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/widget/CustomInputBox.dart';
import 'package:tawelticlient/widget/SubmitButton.dart';


import 'AddReservation.dart';
import 'AddreservationNext.dart';

class AddReservationDetails extends StatefulWidget {
  @override
  _AddReservationDetailsState createState() => _AddReservationDetailsState();
}

class _AddReservationDetailsState extends State<AddReservationDetails> {

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
                  MaterialPageRoute(builder: (context) => AddReservationNext()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Center(
            child: Text(
              'Add Reservation',
              style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w100),
            ),
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
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Guest credentials',style: TextStyle(
                  fontSize: 25,
                  color: KBlue,
                  //fontFamily: 'ProductSans',
                  letterSpacing: 1,
                  fontWeight: FontWeight.w300)),
              SizedBox(height: 20,),
              MyCustomInputBox(
                label: 'Guest name',
                inputHint: 'John',
                color: KBeige,
              ),
              SizedBox(
                height: 10,
              ),
              MyCustomInputBox(
                label: 'Phone number',
                inputHint: '22 222 222',
                color: KBeige,
              ),
              //
              SizedBox(
                height: 10,
              ),
              MyCustomInputBox(
                label: 'email',
                inputHint: 'guest@gmail.com',
                color: KBeige,
              ),
              MyCustomInputBox(
                label: 'special request',
                inputHint: 'special request',
                color: KBeige,
              ),
              SubmiButton(
                scrWidth: MediaQuery.of(context).size.width,
                scrHeight: MediaQuery.of(context).size.height,
                tap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddReservation()));
                },
                title: 'Add Reservation',
                bcolor: KBlue,
                size: 25,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
