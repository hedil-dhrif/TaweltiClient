import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AppBarWidget extends StatefulWidget {
  String title;
  IconData icon;
  Function onpressed;
  Widget leading;

  AppBarWidget({this.title, this.leading, this.onpressed});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: KBlue,
        ),
        leading: widget.leading,
        backgroundColor: Color(0xf6f6f6),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black87, fontSize: 24),
        ),
        actions: [
        /*  GestureDetector(child: Icon(CupertinoIcons.plus_app,size: 32,), onTap:_showMyDialog,),*/
          IconButton(
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.black87,
            ),
            onPressed: widget.onpressed,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.08),
          child: Divider(
            thickness: 2,
            color: KBeige,
          ),
        ),
      ),
    );
  }
/*

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextButton(
                  child: Text(
                    'Add Floor',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  ),
                  onPressed: () {

                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
                TextButton(
                  child: Text(
                    'Add reservation',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  ),
                  onPressed: () {

                  },
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black54,
                ),
                TextButton(
                  child: Text(
                    'Add event',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  ),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }*/
}

