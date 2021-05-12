import 'package:flutter/material.dart';
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
              margin: EdgeInsets.only(top: 80),
             /* margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.3,
              padding: EdgeInsets.fromLTRB(20, 100, 20, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xFFFEFEFE).withOpacity(0.7), BlendMode.dstATop),
                    image: AssetImage('assets/restau.jpg'),
                    fit: BoxFit.cover),
              ),*/
              child: CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/profil.jpg'),
              ),
            ),
            NestedBarClient(),
          ],
        ),
      ),
    );
  }
}
