import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/download.dart';
import 'package:tawelticlient/models/bookWaitSeat.dart';
import 'package:tawelticlient/models/table.dart';
import 'package:tawelticlient/services/bookWaitedSeat.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';

class ConfirmPage extends StatefulWidget {
  final List<BookWaitSeat> bookWaitSeat;
  final List<String> demandeSpecial;
  final DateTime startTime;
  final DateTime endTime;
  final String guestName;
  final List<RestaurantTable> Tables;
  final int user;
  final int guestNumber;

  ConfirmPage(
      {this.bookWaitSeat,
      this.startTime,
      this.endTime,
      this.guestName,
        this.demandeSpecial,
        this.user,
        this.guestNumber,
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
      body: Padding(
        padding: EdgeInsets.only(top: 55),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text(DateTime.now().day.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().year.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: KBeige),),
              Text(
                'Table number  ' + widget.Tables[0].id.toString(),
                style: TextStyle(
                  fontSize: 24,
                  color: KBlue,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                 widget.guestName,
                style: TextStyle(fontSize: 20),
              ),
              Text(widget.guestNumber.toString()+' guests'),

              SizedBox(
                height: 10,
              ),
              Text(
                DateFormat.yMMMd().format(widget.startTime) ,
                style: TextStyle(fontSize: 20,color: KBeige,fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat.jm().format(widget.startTime) ,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: QrImage(
                  data: widget.guestName +
                      'reservation date :' +
                      widget.bookWaitSeat[0].debut.toString(),
                  version: QrVersions.auto,
                  size: 175,
                  gapless: false,
                ),
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: KBeige.withOpacity(0.8),
                  child: TextButton(
                      onPressed: () {
                        _buildListBWStoDB();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FileDownload(random:randomValue ,)));
                        print('taped');
                      },
                      child: Text('confirm reservation',style: TextStyle(color: Colors.white,fontSize: 18),)),
                ),
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
        userId: widget.user,
        restaurantId: widget.bookWaitSeat[i].restaurantId,
        id: widget.bookWaitSeat[i].id,
        // ids: widget.bookWaitSeat.ids,
        debut: widget.startTime,
        fin: widget.endTime,
        confResv: '0',
        cancResv: '0',
        guestName: widget.guestName,
        random: randomValue,
        other: widget.demandeSpecial.toString()
      ));
    }

    final result = await bwsService.addBWS(item);
    print(jsonDecode(result));

  }
}
