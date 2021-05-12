import 'package:flutter/material.dart';

const KBackgroundColor = Color(0xFFFEFEFE);
const KBlue = Color(0xFF1C3956);
const KBeige = Color(0xFFAF8F61);

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kAnimationDuration = Duration(milliseconds: 200);


const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";


const kPrimaryColor = Color(0xFFFFC61F);
const kSecondaryColor = Color(0xFFB5BFD0);
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

const FOOD_DATA = [
  {
    "name":"Burger",
    "brand":"Hawkers",
    "price":2.99,
    "image":"burger.png"
  },{
    "name":"Cheese Dip",
    "brand":"Hawkers",
    "price":4.99,
    "image":"cheese_dip.png"
  },
  {
    "name":"Cola",
    "brand":"Mcdonald",
    "price":1.49,
    "image":"cola.png"
  },
  {
    "name":"Fries",
    "brand":"Mcdonald",
    "price":2.99,
    "image":"fries.png"
  },
  {
    "name":"Ice Cream",
    "brand":"Ben & Jerry's",
    "price":9.49,
    "image":"ice_cream.png"
  },
  {
    "name":"Noodles",
    "brand":"Hawkers",
    "price":4.49,
    "image":"noodles.png"
  },
  {
    "name":"Pizza",
    "brand":"Dominos",
    "price":17.99,
    "image":"pizza.png"
  },
  {
    "name":"Sandwich",
    "brand":"Hawkers",
    "price":2.99,
    "image":"sandwich.png"
  },
  {
    "name":"Wrap",
    "brand":"Subway",
    "price":6.99,
    "image":"wrap.png"
  }
];