import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tawelticlient/api/api.dart';
import 'package:tawelticlient/auth/forget_password.dart';
import 'package:tawelticlient/auth/show_dialog.dart';
import 'package:tawelticlient/auth/signup.dart';
import 'package:tawelticlient/widget/CustomInputBox.dart';
import 'package:tawelticlient/widget/SubmitButton.dart';
import 'package:http/http.dart' as http;

import '../accueil.dart';
import '../constants.dart';
import 'getpassword.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isLoading = false;
  String token;
  int userId;
  String username;
  bool _validate = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool value = true;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/logoBlue.png',
                      height: 100,
                    ),
                    SizedBox(height: 20,),
                    // MyCostumTitle(
                    //   MyTitle: 'Sign In',
                    //   size: 35,
                    // ),
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
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => GetPassword()));

                        CustomShowDialog.instance.showFormDialog(
                            context,
                            ForgetPassword(
                              screenHeight: MediaQuery.of(context).size.height,
                              emailController: mailController,
                            ), acceptButton: () async {
                          print(mailController.text);
                          // if (_formkey.currentState.validate()) {
                          //   _formkey.currentState.save();
                          Navigator.of(context).pop();
                          await CallApi()
                              .forgetPassword(mailController.text)
                              .then((value) {
                            showSnackbarMessage(value['message'], value['ok'] ? true : false);
                            mailController.clear();
                          });
                          //}
                        });
                      },
                      child: Text(
                        'forgot my password',
                        style: TextStyle(
                          fontSize: 15,
                          color: KBlue,
                        ),
                      ),
                    ),
                    //SizedBox(height: MediaQuery.of(context).size.height*0.055,),
                    SubmiButton(
                      scrWidth: scrWidth,
                      scrHeight: scrHeight,
                      tap: () {
                        setState(() {
                          if (!_formkey.currentState.validate()) {
                            return;
                          }
                          //postData();
                          _login();
                        });
                      },
                      title: 'Sign In',
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
            ),
          ],
        ),
      ),
    );
  }

  void _login() async{
  
    setState(() {
      _isLoading = true;
    });
    var data = {

      'email': mailController.text,
      'password': passwordController.text,
      //'phone' : phoneController.text,
    };
    print(mailController.text);
    print(passwordController.text);

    var res = await CallApi().postData(data, 'users/login');
   // var body = json.decode(res.body);
    print(res.body);
   var body = jsonDecode(res.body.toString());
    print(body);
   // if(body['status']==200){
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', body['token']);
    token=body['token'];
    _getProfile();
    print(body);
    // localStorage.setString('user', json.decode(body['userData']));
    // print(body['userData']);
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => Accueil(userId: userId,)));
    // }else{
    //   print('error');
    // }


    setState(() {
      _isLoading = false;
    });

  }


  Future postData() async{
    var data = {
      'email' : mailController.text,
      'password' : passwordController.text,
    };
    print(data['password']);
    final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/users/login'),
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

  showSnackbarMessage(String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: CustomMessageDialog.instance.showMessageDialog(
          context: context, isSuccess: isSuccess, message: message),
      duration: Duration(milliseconds: Styles.instance.snackbarMessageDuration),
    ));
  }


  void _getProfile()async{
    var res = await CallApi().getProfile('users/profile',token);
    var body = json.decode(res.body);
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    localStorage1.setInt('id', json.decode(body['id'].toString()));
    print(body['id']);
    userId=body['id'];
    // username=body['username'];
    print(userId);
    // print(body);
  }
}

class CustomMessageDialog {
  static CustomMessageDialog _instance;
  static CustomMessageDialog get instance {
    if (_instance == null) _instance = CustomMessageDialog._initialize();
    return _instance;
  }

  Widget showMessageDialog({BuildContext context, String message, bool isSuccess}) {
    return Container(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Icon(
              isSuccess ? Icons.done : Icons.error_outline,
              color: isSuccess ? Styles.instance.successIconColor : Styles.instance.errorIconColor,
              size: Styles.instance.messageDialogIconSize,
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            flex: 3,
            child: Text(
              message,
              style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  CustomMessageDialog._initialize();
}


class Styles {
  static Styles _instance;
  static Styles get instance {
    if (_instance == null) _instance = Styles._initialize();
    return _instance;
  }

  Styles._initialize();

  TextStyle defaultButtonTextStyle = TextStyle(fontSize: 18, color: Colors.white);
  TextStyle defaultTitleStyle = TextStyle(fontSize: 18, color: Colors.black, letterSpacing: 1.3);
  Color defaultPrefixIconColor = Colors.white; double defaultPrefixIconSize = 32.0;
  Color formPrefixIconColor = Colors.black;
  TextStyle snackbarTitleStyle = TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 1.1);

  Color successIconColor = Colors.green;
  Color errorIconColor = Colors.red;
  double messageDialogIconSize = 24;
  int snackbarMessageDuration = 1300;
}