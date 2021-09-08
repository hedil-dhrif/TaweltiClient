import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:tawelticlient/widget/NestedBarClient.dart';

import '../widget/AppBar.dart';

class ClientProfil extends StatefulWidget {
  final int userID;
  ClientProfil({this.userID});
  @override
  _ClientProfilState createState() => _ClientProfilState();
}
class _ClientProfilState extends State<ClientProfil> {
  UserServices get userService=>GetIt.I<UserServices>();
  bool _isLoading = false;
  TextEditingController NameController = TextEditingController();
  bool _isEnabled =false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  var user;
  int Id;
  String errorMessage;

  @override
  void initState() {
    setState(() {
      _isLoading=true;
    });
    _getUserInfo();
    super.initState();
  }
  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var userId = localStorage1.getInt('id');
    print(userId);
    setState(() {
      user = userId;
      _getUserProfile(user);
      print(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBarWidget(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ClientProfil()));
            },
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: KBlue,
                backgroundImage: AssetImage('assets/profil.png'),
              ),
            ),
          ),
          title: NameController.text,
          onpressed: () {
            _scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ),      backgroundColor: Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //margin: EdgeInsets.only(top: 30),
                    child: CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage('assets/profil.jpg'),
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.only(left: 150),
                    decoration: BoxDecoration(border: Border.all(color: Colors.black87),borderRadius: BorderRadius.circular(4)),
                    child: IconButton(icon: Icon(Icons.edit), onPressed: (){
                      setState(() {
                        _isEnabled=!_isEnabled;

                      });
                    }),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 20,),
            NestedBarClient(isEnabled: _isEnabled,),
          ],
        ),
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
      NameController.text=response.data.first_name;
      print(response.data.first_name);
      print(response.data.email);
      print(response.data.id);
      // _titleController.text = floor.nom;
      // _contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });

  }
}
