import 'package:flutter/material.dart';
import 'package:tawelticlient/widget/CustomInputBox.dart';
import 'package:tawelticlient/widget/MyCostumTitleWidget.dart';
import 'package:tawelticlient/widget/SubmitButton.dart';

import '../constants.dart';

class GetPassword extends StatefulWidget {
  @override
  _GetPasswordState createState() => _GetPasswordState();
}

class _GetPasswordState extends State<GetPassword> {

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
                  MyCostumTitle(
                    MyTitle: 'Get password',
                    size: 30,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  //
                  MyCustomInputBox(
                    label: 'Email',
                    inputHint: 'Johndoe@mail.com',
                    color: KBlue,
                  ),
                  //
                  SubmiButton(
                    scrWidth: scrWidth,
                    scrHeight: scrHeight,
                    tap: () {},
                    title: 'Get',
                    bcolor: KBlue,
                    size: 30,
                    color: Colors.white70,
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
