import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawelticlient/auth/signin.dart';
import 'package:tawelticlient/widget/Rounded_button.dart';
class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 100),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Color(0xFF1C3956), BlendMode.dstATop),
                  image: ExactAssetImage('assets/background-01.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RoundedButton(
                  ontap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignIn()));
                  },
                  image: 'assets/email.png',
                  text: 'Signup with email',
                ),
                SizedBox(height: 30,),
                RoundedButton(
                  ontap: (){},
                  image: 'assets/google.png',
                  text: 'Signup with google',
                ),
                SizedBox(height: 30,),
                RoundedButton(
                  ontap: (){},
                  image: 'assets/facebook.png',
                  text: 'Signup with facebook',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
