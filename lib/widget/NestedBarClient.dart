import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/api/api.dart';
import 'package:tawelticlient/api/api_Response.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/reservation.dart';
import 'package:tawelticlient/models/user.dart';
import 'package:tawelticlient/services/reservation.services.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:tawelticlient/widget/DisabledInputbox.dart';
import '../constants.dart';
import '../reservation/DetailsReservation.dart';
import 'RestauCard.dart';
import 'floorDelete.dart';

class NestedBarClient extends StatefulWidget {
  final bool isEnabled;
  NestedBarClient({this.isEnabled});
  @override
  _NestedBarClientState createState() => _NestedBarClientState();
}

class _NestedBarClientState extends State<NestedBarClient>
    with TickerProviderStateMixin {

   @override
  TabController _nestedTabController;
  UserServices get userService=>GetIt.I<UserServices>();
  bool _isLoading = false;
  TextEditingController NameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  // bool get isEditing => widget.userId != null;
   ReservationServices get reservationService => GetIt.I<ReservationServices>();
   List<Reservation> reservations = [];
   APIResponse<List<Reservation>> _apiResponse;
  String errorMessage;
  var user;
  User userData;
  int Id;
   bool _validate = false;

   @override
  void initState() {
    //_getUserInfo();
    setState(() {
      _isLoading=true;
    });
    _getUserInfo();
    // NameController.text=userData.username;
    // phoneController.text=userData.phone;
    // mailController.text=userData.email;
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }
   void _getUserInfo() async {
     SharedPreferences localStorage1 = await SharedPreferences.getInstance();
     var userId = localStorage1.getInt('id');
     print(userId);
     setState(() {
       user = userId;
       _getUserProfile(user);
       _fetchReservations(user);
       print(user);
     });
   }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TabBar(
            unselectedLabelStyle: TextStyle(fontSize: 20),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: KBeige, width: 1),
            ),
            controller: _nestedTabController,
            indicatorColor: KBeige,
            labelColor: KBlue,
            unselectedLabelColor: KBlue,
            isScrollable: true,
            labelStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            tabs: <Widget>[
              Tab(
                text: "Détails",
              ),
              Tab(
                text: "Historique réservation",
              ),
            ],
          ),
          SingleChildScrollView(
            child: Container(
              height: screenHeight * 0.45,
              child: TabBarView(
                controller: _nestedTabController,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      height: MediaQuery.of(context).size.height*0.5,
                      child: ListView(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DisabledInputBox(
                            validate: _validate,
                            enabled: widget.isEnabled,
                            controller: NameController,
                            label: 'User name:',
                            inputHint: 'Jhon Doe',
                            color: KBlue,
                          ),
                          DisabledInputBox(
                            validate: _validate,
                            enabled: widget.isEnabled,
                            controller: phoneController,
                            label: 'Phone number:',
                            inputHint: '23698514',
                            color: KBlue,
                          ),
                          DisabledInputBox(
                            validate: _validate,

                            enabled: widget.isEnabled,
                            controller: mailController,
                            label: 'Email:',
                            inputHint: 'JhonDoe@email.com',
                            color: KBlue,
                          ),
                          widget.isEnabled?FlatButton(onPressed: () async{
                            setState(() {
                              mailController.text.isEmpty ? _validate = true : _validate = false;
                              phoneController.text.isEmpty ? _validate = true : _validate = false;
                              NameController.text.isEmpty ? _validate = true : _validate = false;

                            });
                           _updateUser(user.toString());
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Done'),
                                  content: Text('your profile is updated succefully ! '),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Ok'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                )
                            );

                          }, child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.78,
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
                                ),),),):Container(),
                        ],
                      ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    padding: EdgeInsets.only(top: 10,left: 20),
                    child: _buildEventsList(_apiResponse.data)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getUserProfile(user)async{
    setState(() {
      _isLoading=true;
    });
    await userService.getUserProfile(user.toString()).then((response) {

      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      Id = response.data.id;
      NameController.text=response.data.username;
      mailController.text=response.data.email;
      phoneController.text=response.data.phone;
      print(response.data.username);
      print(response.data.email);
      print(response.data.id);
      // _titleController.text = floor.nom;
      // _contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });

  }


   _fetchReservations(user) async {
     print(user);
     setState(() {
       _isLoading = true;
     });

     _apiResponse = await reservationService.getUsersListReservations(user.toString());
     print(_apiResponse.data);
     setState(() {
       _isLoading = false;
     });
   }

   _buildEventsList(List data) {
     return Container(
       child: ListView.separated(
         itemCount: data.length,
         itemBuilder: (BuildContext context, int index) {
           return Dismissible(
             key: ValueKey(data[index].id),
             direction: DismissDirection.startToEnd,
             onDismissed: (direction) {},
             confirmDismiss: (direction) async {
               final result = await showDialog(
                   context: context, builder: (_) => FloorDelete());

               if (result) {
                 final deleteResult = await reservationService
                     .deleteReservation(data[index].id.toString());
                 _fetchReservations(user);

                 var message = 'The reservation was deleted successfully';

                 return deleteResult?.data ?? false;
               }
               print(result);
               return result;
             },
             background: Container(
                 color: Colors.red,
                 padding: EdgeInsets.only(left: 16),
                 child: Align(
                   child: Icon(Icons.delete, color: Colors.white),
                   alignment: Alignment.centerLeft,
                 )),
             child:GestureDetector(
               onTap: () {
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) => DetailReservation(reservationId: data[index].id,))).then((__) => _fetchReservations(user));
               },
               child: RestauCard(
                 guestname: data[index].nomPersonne,
                 nbPersonne: data[index].nbPersonne.toString(),
                 reservationId: data[index].id,
                 reservationDate: data[index].id.toString(),
                 reservationTime: data[index].heureReservation,
               ),
             ),
           );
         },
         separatorBuilder: (BuildContext context, int index) => const Divider(
           color: Colors.black87,
         ),
       ),
     );
   }
   void _updateUser(userId) async {
     setState(() {
       _isLoading = true;
     });

     var data = {
       'email' : mailController.text,
       'username': NameController.text,
       'phone': phoneController.text,
       // 'password' : passwordController.text,
       // 'phone' : phoneController.text,
     };
     print(userId);
     print(mailController.text);
     var res = await CallApi().updateData(data, 'users/update/',userId);
     var body = json.decode(res.body.toString());
     print(body);
     setState(() {
       _isLoading = false;
     });
   }
}
