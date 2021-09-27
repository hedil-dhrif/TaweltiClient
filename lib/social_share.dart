import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_social_content_share/flutter_social_content_share.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialShare extends StatefulWidget {
  @override
  _SocialShareState createState() => _SocialShareState();
}

class _SocialShareState extends State<SocialShare> {
  String _platformVersion = 'Unknown';
  String text = 'https://medium.com/@suryadevsingh24032000';
  String subject = 'follow me';
  String url= 'tel:+21626718812';
   String _url = 'https://pub.dev/packages/url_launcher/example';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterSocialContentShare.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  /// SHARE ON FACEBOOK CALL
  shareOnFacebook() async {
    String result = await FlutterSocialContentShare.share(
        type: ShareType.facebookWithoutImage,
        url: "https://www.apple.com",
        quote: "captions");
    print(result);
  }

  /// SHARE ON INSTAGRAM CALL
  shareOnInstagram() async {
    String result = await FlutterSocialContentShare.share(
        type: ShareType.instagramWithImageUrl,
        imageUrl:
            "https://post.healthline.com/wp-content/uploads/2020/09/healthy-eating-ingredients-732x549-thumbnail-732x549.jpg");
    print(result);
  }

  /// SHARE ON WHATSAPP CALL
  shareWatsapp() async {
    String result = await FlutterSocialContentShare.shareOnWhatsapp(
        '52474786', 'hello world');
    print(result);
  }

  /// SHARE ON EMAIL CALL
  shareEmail() async {
    String result = await FlutterSocialContentShare.shareOnEmail(
        recipients: ["maleksouissi751@@gmail.com"],
        subject: "flutter",
        body: "Body appears here",
        isHTML: true); //default isHTML: False
    print(result);
  }

  /// SHARE ON SMS CALL
  shareSMS() async {
    String result = await FlutterSocialContentShare.shareOnSMS(
        recipients: ["52474786"], text: "Text appears here");
    print(result);
  }

  Future<void> _makeSocialMediaRequest(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///Build Context
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Column(
        children: <Widget>[
          Text('Running on: $_platformVersion\n'),
          RaisedButton(
            child: Text("Share to facebook button"),
            color: Colors.red,
            onPressed: () {
              shareOnFacebook();
            },
          ),
          RaisedButton(
            child: Text("Share to instagram button"),
            color: Colors.red,
            onPressed: () {
              shareOnInstagram();
            },
          ),
          RaisedButton(
            child: Text("Share to whatsapp button"),
            color: Colors.red,
            onPressed: () {
              shareWatsapp();
            },
          ),
          RaisedButton(
            child: Text("Share to email button"),
            color: Colors.red,
            onPressed: () {
              shareEmail();
            },
          ),
          RaisedButton(
            child: Text("Share to sms button"),
            color: Colors.red,
            onPressed: () {
              shareSMS();
            },
          ),
      RaisedButton(
        child:  Text('Share'),
        onPressed: ()
        {
          final RenderBox box = context.findRenderObject();
          Share.share(text,
              subject: subject,
              sharePositionOrigin:
              box.localToGlobal(Offset.zero) &
              box.size);
        },
      ),

          TextButton.icon(onPressed: ()async{
              if(await canLaunch(url))
              {
                await launch(url);
              }else
              {
                throw 'call not possible';
              }

          }, icon: Icon(Icons.call), label: Text('call')),

          TextButton.icon(onPressed: ()async{
            final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'contact.tawelty@gmail.com',
                queryParameters: {
                  'subject': 'subject'
                }
            );
            launch(_emailLaunchUri.toString());
          }, icon: Icon(Icons.email_outlined), label: Text('send')),
          TextButton.icon(onPressed: (){
            _makeSocialMediaRequest("http://pratikbutani.com");
          }, icon: Icon(Icons.email_outlined), label: Text('send')),
        ],
      ),
    );
  }
}
