import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:tawelticlient/models/reservation.dart';
import 'package:tawelticlient/services/reservation.services.dart';
import '../constants.dart';
import '../widget/DisabledInputbox.dart';
import 'ReservationList.dart';

class DetailReservation extends StatefulWidget {
  final reservationId;
  DetailReservation({this.reservationId});
  @override
  _DetailReservationState createState() => _DetailReservationState();
}

class _DetailReservationState extends State<DetailReservation> {
  ReservationServices get reservationService => GetIt.I<ReservationServices>();

  bool get isEditing => widget.reservationId != null;
  bool _isLoading = false;
  String errorMessage;
  bool _enabled= true;
  Reservation reservation;
  TextEditingController codeController = TextEditingController();
  TextEditingController nbPersonController = TextEditingController();
  TextEditingController nomPersonController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    print(widget.reservationId);
    if (isEditing) {
      setState(() {
        _isLoading = false;
      });
      reservationService.getReservation(widget.reservationId.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        reservation = response.data;
        codeController.text=widget.reservationId.toString();
        nbPersonController.text=reservation.nbPersonne.toString();
        nomPersonController.text=reservation.nomPersonne;
        timeController.text=reservation.heureReservation;
        dateController.text=reservation.dateReservation;
        //phoneController.text=reservation.etat.toString();
        //_contentController.text = note.noteContent;
      });
    }

    super.initState();
  }

  DateTime datetime;

  String getText() {
    if (datetime == null) {
      return 'Select Date';
    } else {
      return DateFormat('dd-MM-yyyy').format(datetime);
    }
  }

  TimeOfDay time;

  String getTextTime() {
    if (time == null) {
      return reservation.heureReservation;
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if (newTime == null) return;

    setState(() => time = newTime);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: KBlue,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReservationtList()));
            },
            icon: Icon(CupertinoIcons.arrow_left),
          ),
          title: Center(
            child: Text(
              'Detail reservation',
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 50),
                decoration: BoxDecoration(border: Border.all(color: Colors.black87),borderRadius: BorderRadius.circular(4)),
                child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                  setState(() {
                    _enabled=!_enabled;

                  });
                }),
              ),
              SizedBox(height: 20,),
              DisabledInputBox(
                validate:_validate ,
                enabled:_enabled ,
                controller: codeController,
                label: 'Reservation code: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                validate:_validate ,
                enabled: _enabled,
                controller: nomPersonController,
                label: 'Guest name: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              DisabledInputBox(
                validate:_validate ,
                controller: nbPersonController,
                enabled: _enabled,
                label: 'Guest numbers: ',
                inputHint: 'XXXXX',
                color: KBlue,
              ),
              Padding(
                padding: const EdgeInsets.only(left:50,bottom: 8),
                child: Text(
                  'time',
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 20,
                    color: Color(0xff8f9db5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: Container(
                  // width: MediaQuery.of(context).size.width*0.8,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: KBlue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.timer,
                        color: KBlue,
                        size: 30,
                      ),
                      GestureDetector(
                        child: Text(
                          getTextTime(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          pickTime(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:50,bottom: 8),
                child: Text(
                  'Date',
                  style: TextStyle(
                    fontFamily: 'Product Sans',
                    fontSize: 20,
                    color: Color(0xff8f9db5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                child: Container(
                  // width: MediaQuery.of(context).size.width*0.8,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: KBlue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: KBlue,
                        size: 30,
                      ),
                      GestureDetector(
                        child: Text(
                          getText(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate:
                            datetime == null ? DateTime.now() : datetime,
                            initialDatePickerMode: DatePickerMode.day,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2040),
                          ).then((date) {
                            setState(() {
                              datetime = date;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              _enabled?FlatButton(onPressed: () async{
                setState(() {
                  _isLoading = true;
                });
                final reservation = Reservation(
                  nbPersonne: int.parse(nbPersonController.text),
                  nomPersonne: nomPersonController.text,

                  //createdAt: _startController.text,
                );
                final result = await reservationService.updateReservation(widget.reservationId.toString(), reservation);

                setState(() {
                  _isLoading = false;
                });

                final title = 'Done';
                final text = result.error ? (result.errorMessage ?? 'An error occurred') : 'Your note was updated';

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

              }, child: Padding(
                padding: const EdgeInsets.only(left: 25,right: 25,top: 20),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: KBlue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20,
                            color: KBackgroundColor,
                            letterSpacing: 2),
                      ),
                    )),
              )):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
