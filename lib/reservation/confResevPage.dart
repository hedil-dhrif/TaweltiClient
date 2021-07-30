import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tawelticlient/models/bookWaitSeat.dart';
import 'package:tawelticlient/services/bookWaitedSeat.services.dart';
import 'package:tawelticlient/widget/AppBar.dart';

class ConfirmPage extends StatefulWidget {
  final BookWaitSeat bookWaitSeat;
  final DateTime startTime;
  final DateTime endTime;
  ConfirmPage({this.bookWaitSeat, this.startTime, this.endTime});
  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool _isLoading = false;
  String guestName = "malek souissi";
  BookWaitSeatServices get bwsService => GetIt.I<BookWaitSeatServices>();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.bookWaitSeat.id);
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
        child: Column(
          children: [
            Text(widget.bookWaitSeat.id.toString()),
            Text(widget.bookWaitSeat.debut.toString()),
            Text(widget.bookWaitSeat.fin.toString()),
            Text(widget.bookWaitSeat.ids.toString()),
            Text(widget.bookWaitSeat.restaurantId.toString()),
            Text(widget.startTime.toString()),
            Text(widget.endTime.toString()),
            Text(guestName),
            QrImage(
              data: guestName + 'reservation date :' + widget.bookWaitSeat.debut.toString(),
              version: QrVersions.auto,
              size: 160,
              gapless: false,
            ),
            TextButton(
                onPressed: () {
                  _addBWS();
                  print('taped');
                },
                child: Text('confirm reservation')),
          ],
        ),
      ),
    );
  }

  _addBWS() async {
    setState(() {
      _isLoading = true;
    });
    final item = BookWaitSeat(
      restaurantId: widget.bookWaitSeat.restaurantId,
      id: widget.bookWaitSeat.id,
     // ids: widget.bookWaitSeat.ids,
      debut: widget.startTime,
      fin: widget.endTime,
      confResv: '0',
      cancResv: '0',
      guestName: guestName,
    );
    final result = await bwsService.addBWS(item);
    setState(() {
      _isLoading = false;
    });
  }
}
