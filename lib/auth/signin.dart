import 'package:flutter/material.dart';
import 'package:tawelticlient/auth/signup.dart';
import 'package:tawelticlient/widget/CustomInputBox.dart';
import 'package:tawelticlient/widget/MyCostumTitleWidget.dart';
import 'package:tawelticlient/widget/SubmitButton.dart';

import '../constants.dart';
import 'getpassword.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 100),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Color(0xFFFEFEFE), BlendMode.dstATop),
                    image: ExactAssetImage('assets/uppernejma.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      'assets/logoBlue.png',
                    height: 120,
                  ),
                  SizedBox(height: 50,),
                  MyCostumTitle(
                    MyTitle: 'Sign In',
                    size: 50,
                  ),
                  MyCustomInputBox(
                    label: 'User name',
                    inputHint: 'John',
                    color: KBlue,
                  ),
                  MyCustomInputBox(
                    label: 'Password',
                    inputHint: '8+ Characters,1 Capital letter',
                    color: KBlue,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetPassword()));
                    },
                    child: Text(
                      'forgot my password',
                      style: TextStyle(
                        fontSize: 15,
                        color: KBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.075,),
                  SubmiButton(
                    scrWidth: scrWidth,
                    scrHeight: scrHeight,
                    tap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddRestaurant()));*/
                    },
                    title: 'Create Account',
                    bcolor: KBlue,
                    size: 20,
                    color: Colors.white70,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff8f9db5).withOpacity(0.45),
                            ),
                          ),
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: KBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
