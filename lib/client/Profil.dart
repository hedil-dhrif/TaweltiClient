import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/HomePage.dart';
import 'package:tawelticlient/api/api.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/models/user.dart';
import 'package:tawelticlient/services/user.services.dart';
import 'package:tawelticlient/widget/DisabledInputbox.dart';
import 'package:tawelticlient/widget/NestedBarClient.dart';

import '../widget/AppBar.dart';

class ClientProfil extends StatefulWidget {
  final int userID;
  final bool isEnabled;
  ClientProfil({this.userID, this.isEnabled});
  @override
  _ClientProfilState createState() => _ClientProfilState();
}

class _ClientProfilState extends State<ClientProfil> {
  UserServices get userService => GetIt.I<UserServices>();
  bool _isLoading = false;
  TextEditingController NameController = TextEditingController();
  bool _isEnabled = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  var user;
  int Id;
  String errorMessage;
  String token;
  bool _validate = false;
  TextEditingController FirstNameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _isLoading = true;
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
      appBar: AppBar(
        backgroundColor: KBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          icon: Icon(
            Icons.arrow_back,
            color: KBackgroundColor,
            size: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEnabled = true;
              });
            },
            icon: Icon(
              Icons.edit,
              color: KBackgroundColor,
              size: 20,
            ),
          )
        ],
      ),
      key: _scaffoldKey,
      backgroundColor: Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: KBlue.withOpacity(0.75),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/profil.jpg'),
                    ),
                    GestureDetector(
                      child: Text(
                        'Changer la photo de profil',
                        style: TextStyle(color: KBackgroundColor, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: KBlue,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Column(
                children: [
                  textrow(
                    enabled: _isEnabled,
                    name: 'Prénom',
                    input: FirstNameController.text,
                  ),
                  devider(),
                  textrow(
                    enabled: _isEnabled,
                    name: 'Nom',
                    input: LastNameController.text,
                  ),
                  devider(),
                  textrow(
                    enabled: _isEnabled,
                    name: 'E-mail',
                    input: mailController.text,
                  ),
                  devider(),
                  textrow(
                    enabled: _isEnabled,
                    name: 'Adresse',
                    input: 'abcdefg',
                  ),
                  devider(),
                  textrow(
                    enabled: _isEnabled,
                    name: 'Téléphone',
                    input: '12345678',
                  ),
                  _isEnabled
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEnabled = false;
                              _handleUpdate();
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                                color: KBackgroundColor,
                                borderRadius: BorderRadius.circular(12.5)),
                            child: Center(
                                child: Text(
                              'enregistrer',
                              style: TextStyle(
                                  color: KBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )),
                          ))
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleUpdate() async {
    setState(() {
      _isLoading = true;
    });
    var user = User(
      id: Id,
      first_name:  FirstNameController.text,
      last_name: LastNameController.text,
      email: mailController.text,
    );

    print(FirstNameController.text);
    print(LastNameController.text);
    print(mailController.text);

    var res = await userService.updateUser(Id.toString(), user).then((value) => _getUserProfile(user));
    print(res);

    setState(() {
      _isLoading = false;
    });
  }

  showError(msg) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Done'),
              content: Text(msg.toString()),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _getUserProfile(user) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserProfile(user.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      Id = response.data.id;
      FirstNameController.text = response.data.first_name;
      LastNameController.text = response.data.last_name;
      mailController.text = response.data.email;
      // phoneController.text = response.data.phone;
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

class devider extends StatelessWidget {
  const devider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 50,
      thickness: 1,
      indent: 0,
      endIndent: 0,
      color: KBackgroundColor.withOpacity(0.5),
    );
  }
}

class textrow extends StatelessWidget {
  final String name;
  final String input;
  final bool enabled;

  const textrow({Key key, this.name, this.input, this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
              color: KBackgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.035,
          width: MediaQuery.of(context).size.width * 0.45,
          child: TextFormField(
            style: TextStyle(color: KBackgroundColor, fontSize: 16),
            enabled: enabled,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: KBackgroundColor, fontSize: 16),
              hintText: input,
              hintStyle: TextStyle(color: KBackgroundColor, fontSize: 16),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
