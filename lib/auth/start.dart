import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/accueil.dart';
import 'package:tawelticlient/auth/signin.dart';
import 'package:tawelticlient/widget/Rounded_button.dart';
import "package:http/http.dart" as http;

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
            padding: EdgeInsets.symmetric(vertical: 70),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Color(0xFF1C3956), BlendMode.dstATop),
                  image: ExactAssetImage('assets/background-01.png'),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 200),
                    child: Image.asset(
                      'assets/logoTawelti.png',
                      width: 250,
                    ),
                  ),
                  RoundedButton(
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    text: 'Continue with email',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
loginFacebook();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(5),
                          //border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.facebook,
                            color: Colors.white,
                            size: 24,
                          ),
                          Text(
                            'Continue with facebook',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void loginFacebook() async {
    final facebookLogin = FacebookAuth;
    const FACEBOOK_PERMISSIONS = ['public_profile', 'email'];
    final facebookLoginResult = await FacebookAuthPlatform.instance.login(permissions: FACEBOOK_PERMISSIONS).then((value)async {
      print(value.accessToken.token);
      final token = value.accessToken.token;

      /// for profile details also use the below code
      final graphResponse = await http.get(
          Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token'));
      final profile = json.decode(graphResponse.body);
      print(profile);
      postData(value.accessToken.token).then((value)async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', value['token']);
        SharedPreferences localStorage1 = await SharedPreferences.getInstance();
        localStorage1.setInt('id', json.decode(value['userData']['id'].toString()));
        print(value['userData']['id']);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => Accueil(userId:value['userData']['id'] ,)));
      });
    });



    /*
    from profile you will get the below params
    {
     "name": "Iiro Krankka",
     "first_name": "Iiro",
     "last_name": "Krankka",
     "email": "iiro.krankka\u0040gmail.com",
     "id": "<user id here>"
    }
   */
  }
Future postData(token) async{
  var data = {
    'access_token':token,

  };
  final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/oauth/facebook'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(data));

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    throw Exception('exception occured!!!!!!');
  }
}

}
