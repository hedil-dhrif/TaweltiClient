import 'package:flutter/material.dart';
import 'package:tawelticlient/accueil.dart';
import 'package:tawelticlient/auth/signin.dart';
import 'package:tawelticlient/widget/CustomInputBox.dart';
import 'package:tawelticlient/widget/MyCostumTitleWidget.dart';
import 'package:tawelticlient/widget/SubmitButton.dart';

import '../constants.dart';


class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 180, bottom: 40),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyCostumTitle(
                      MyTitle: 'Sign Up',
                      size: 60,
                    ),
                    MyCustomInputBox(
                      label: 'Name',
                      inputHint: 'John',
                      color: KBlue,
                    ),
                    MyCustomInputBox(
                      label: 'Email',
                      inputHint: 'example@example.com',
                      color: KBlue,
                    ),
                    MyCustomInputBox(
                      label: 'Password',
                      inputHint: '8+ Characters,1 Capital letter',
                      color: KBlue,
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8f9db5).withOpacity(0.45),
                      ),
                      //
                    ),
                    SubmiButton(
                      scrWidth: scrWidth,
                      scrHeight: scrHeight,
                      tap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Accueil()));
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
                                builder: (context) => SignIn()));
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontFamily: 'Product Sans',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff8f9db5).withOpacity(0.45),
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
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
      ),
    );
  }
}
