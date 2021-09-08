import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/download.dart';
import 'package:tawelticlient/models/bookWaitSeat.dart';
import 'package:tawelticlient/models/table.dart';
import 'package:tawelticlient/services/bookWaitedSeat.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';

class ConfirmPage extends StatefulWidget {
  final List<BookWaitSeat> bookWaitSeat;
  final DateTime startTime;
  final DateTime endTime;
  final String guestName;
  final List<RestaurantTable> Tables;
  ConfirmPage(
      {this.bookWaitSeat,
      this.startTime,
      this.endTime,
      this.guestName,
      this.Tables});
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool _isLoading = false;
  BookWaitSeatServices get bwsService => GetIt.I<BookWaitSeatServices>();
  String randomValue;
  @override
  void initState() {
    // TODO: implement initState
    for(int i =0;i<widget.bookWaitSeat.length;i++){
      print(widget.bookWaitSeat[i].id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          title: 'Add reservation',
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 55),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Table number  ' + widget.Tables[0].id.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: KBlue,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Guest name:  ' + widget.guestName,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Reservation time:  ' +
                      widget.startTime.hour.toString() +
                      ':' +
                      widget.startTime.minute.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Reservation date:  ' +
                      widget.startTime.day.toString() +
                      '-' +
                      widget.startTime.month.toString() +
                      '-' +
                      widget.startTime.year.toString(),
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              QrImage(
                data: widget.guestName +
                    'reservation date :' +
                    widget.bookWaitSeat[0].debut.toString(),
                version: QrVersions.auto,
                size: 175,
                gapless: false,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        _buildListBWStoDB();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FileDownload(random:randomValue ,)));
                        print('taped');
                      },
                      child: Text('confirm reservation')),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // _addBWS() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final List<BookWaitSeat> item =[
  //     BookWaitSeat(
  //     restaurantId: widget.bookWaitSeat[0].restaurantId,
  //     id: widget.bookWaitSeat[0].id,
  //     // ids: widget.bookWaitSeat.ids,
  //     debut: widget.startTime,
  //     fin: widget.endTime,
  //     confResv: '0',
  //     cancResv: '0',
  //     guestName: widget.guestName,
  //   )];
  //   final result = await bwsService.addBWS(item);
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }


  _buildListBWStoDB()async{
    Random random=Random();
    randomValue=random.nextInt(10000).toString();
    print(randomValue);
    final List<BookWaitSeat> item=[];
    for(int i=0 ; i <widget.bookWaitSeat.length;i++){
      item.add(BookWaitSeat(
        userId: 30,
        restaurantId: widget.bookWaitSeat[i].restaurantId,
        id: widget.bookWaitSeat[i].id,
        // ids: widget.bookWaitSeat.ids,
        debut: widget.startTime,
        fin: widget.endTime,
        confResv: '0',
        cancResv: '0',
        guestName: widget.guestName,
        random: randomValue,
      ));
    }

    final result = await bwsService.addBWS(item);
    print(jsonDecode(result));

  }
}
