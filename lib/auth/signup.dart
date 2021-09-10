import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/api/api.dart';
import 'package:tawelticlient/auth/signin.dart';
import 'package:tawelticlient/widget/CustomInputBox.dart';
import 'package:tawelticlient/widget/MyCostumTitleWidget.dart';
import 'package:tawelticlient/widget/SubmitButton.dart';

import '../HomePage.dart';
import '../constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isLoading = false;
  String token;
  int userId;
  String username;
  bool _validate = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool value = true;

  TextEditingController FirstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                padding: EdgeInsets.only(top: 50, bottom: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Color(0xFFFEFEFE), BlendMode.dstATop),
                      image: ExactAssetImage('assets/uppernejma.png'),
                      fit: BoxFit.cover),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // cross  AxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/logoBlue.png',
                        height: 100,
                      ),
                      MyCostumTitle(
                        MyTitle: 'Sign Up',
                        size: 35,
                      ),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            MyCustomInputBox(
                              validate: _validate,
                              textController: FirstNameController,
                              label: 'first Name',
                              inputHint: 'John',
                              color: KBlue,
                              obscure: false,
                              valid: (value) {
                                if (value.isNotEmpty && value.length > 4) {
                                  return null;
                                } else if (value.isNotEmpty &&
                                    value.length < 3) {
                                  return 'saisir un prénom correcte';
                                } else if (value.isEmpty) {
                                  return 'il faut saisir un prénom';
                                }
                              },
                            ),
                            MyCustomInputBox(
                              valid: (value) {
                                if (value.isNotEmpty && value.length > 4) {
                                  return null;
                                } else if (value.isNotEmpty &&
                                    value.length < 3) {
                                  return 'saisir un nom correcte';
                                } else if (value.isEmpty) {
                                  return 'il faut saisir un nom';
                                }
                              },
                              validate: _validate,
                              obscure: false,
                              textController: lastNameController,
                              label: 'last Name',
                              inputHint: 'Doe',
                              color: KBlue,
                            ),
                            MyCustomInputBox(
                              validate: _validate,
                              textController: phoneController,
                              label: 'phone',
                              inputHint: '+216 ** *** ***',
                              color: KBlue,
                              obscure: false,
                              valid: (input) {
                                final isDigitsOnly = int.tryParse(input);
                                if (input != isDigitsOnly &&
                                    input.length != 8) {
                                  return 'le nombre de téléphone doit être 8 chiffres';
                                }
                              },
                            ),
                            MyCustomInputBox(
                              validate: _validate,
                              textController: mailController,
                              label: 'E-mail',
                              obscure: false,
                              inputHint: 'example@example.com',
                              color: KBlue,
                              valid: (value) {
                                if (value.isNotEmpty &&
                                    RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return null;
                                } else if (value.isNotEmpty &&
                                    !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'vérifier votre email';
                                } else if (value.isEmpty) {
                                  return 'il faut saisir un email';
                                }
                              },
                            ),
                            MyCustomInputBox(
                              validate: _validate,
                              obscure: true,
                              textController: passwordController,
                              label: 'mot de passe',
                              inputHint: '8+ Characters,1 Capital letter',
                              color: KBlue,
                              valid: (value) {
                                if (value.isEmpty) {
                                  return 'il faut saisir en mot de passe';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          "Remember me",
                          style: TextStyle(
                            fontFamily: 'Product Sans',
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff8f9db5).withOpacity(0.45),
                          ),
                          //
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: SubmiButton(
                          scrWidth: scrWidth,
                          scrHeight: scrHeight,
                          tap: () {
                            setState(() {
                              if (!_formkey.currentState.validate()) {
                                return;
                              }
                              _handleLogin();
                            });

                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                          },
                          title: 'Create Account',
                          bcolor: KBlue,
                          size: 20,
                          color: Colors.white70,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'first_name': FirstNameController.text,
      'last_name': lastNameController.text,
      'email': mailController.text,
      'password': passwordController.text,
      //'phone' : phoneController.text,
    };
    print(FirstNameController.text);
    print(mailController.text);
    print(passwordController.text);
    print(phoneController.text);

    var res = await CallApi().postData(data, 'users/register');
    var body = json.decode(res.body);
    print(body);
    if (body['Status'] == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      token = body['token'];
      _getProfile();
      //localStorage.setString('user', json.encode(body['user']));

      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      showError(body['error']);
    }

    //}

    setState(() {
      _isLoading = false;
    });
  }

  void _getProfile() async {
    var res = await CallApi().getProfile('users/profile', token);
    var body = json.decode(res.body);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user', json.encode(body['user']));
    userId = body['id'];
    username = body['first_name'];
    print(userId);
    print(body);
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
}
