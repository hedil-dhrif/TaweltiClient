import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/constants.dart';
import 'package:tawelticlient/widget/NestedBarClient.dart';

class ClientProfil extends StatefulWidget {
  @override
  _ClientProfilState createState() => _ClientProfilState();
}
class _ClientProfilState extends State<ClientProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top:80, left: 190),
              height: 60,
              width: 130,
              decoration: BoxDecoration(
                  color: KBlue,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text(
                  'Edit profil',
                  style: TextStyle(
                      fontSize: 22.5,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/profil.jpg'),
              ),
            ),
            SizedBox(height: 20,),
            NestedBarClient(),
          ],
        ),
      ),
    );
  }
}
