import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Filtrage extends StatefulWidget {
  @override
  _FiltrageState createState() => _FiltrageState();
}

class _FiltrageState extends State<Filtrage> {
  bool estclick = false;
  bool kitclick = false;
  bool budclick = false;
  bool ambclick = false;
  bool genclick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: KBlue,
        ),
        title: Center(
          child: Text(
            'filter parameters',
            style: TextStyle(
                fontSize: 25,
                color: KBlue,
                fontFamily: 'ProductSans',
                letterSpacing: 1,
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterParameter(
                  title: 'Type of establishment :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Lounge',
                        ),
                        MyStatefulWidget(
                          title: 'Beachbar',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        MyStatefulWidget(
                          title: 'Tea room',
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                  title: 'Kitchen :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Frensh',
                        ),
                        MyStatefulWidget(
                          title: 'Tunisian',
                        ),
                        MyStatefulWidget(
                          title: 'Italian',
                        ),
                        MyStatefulWidget(
                          title: 'Turkish',
                        ),
                        MyStatefulWidget(
                          title: 'American',
                        ),
                        MyStatefulWidget(
                          title: 'Lebanese',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Seafood',
                        ),
                        MyStatefulWidget(
                          title: 'Steak',
                        ),
                        MyStatefulWidget(
                          title: 'Mexican',
                        ),
                        MyStatefulWidget(
                          title: 'European',
                        ),
                        MyStatefulWidget(
                          title: 'African',
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                  title: 'Budget :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyStatefulWidget(
                      title: '*',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    MyStatefulWidget(
                      title: '**',
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    MyStatefulWidget(
                      title: '***',
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                    title: 'Ambiance :',
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Festive',
                        ),
                        MyStatefulWidget(
                          title: 'Calm',
                        ),
                        MyStatefulWidget(
                          title: 'Romantic',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Buisness',
                        ),
                        MyStatefulWidget(
                          title: 'Family',
                        ),
                      ],
                    )
                  ],
                ) ,
                SizedBox(
                  height: 10,
                ),
                FilterParameter(
                  title: 'General :',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Requires reservation',
                        ),
                        MyStatefulWidget(
                          title: 'Car park',
                        ),
                        MyStatefulWidget(
                          title: 'Smoking area',
                        ),
                        MyStatefulWidget(
                          title: 'No smoking',
                        ),
                        MyStatefulWidget(
                          title: 'Children area',
                        ),
                        MyStatefulWidget(
                          title: 'Ticket restaurant',
                        ),
                        MyStatefulWidget(
                          title: 'Check',
                        ),
                        MyStatefulWidget(
                          title: 'Animals',
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyStatefulWidget(
                          title: 'Alcohol',
                        ),
                        MyStatefulWidget(
                          title: 'shisha',
                        ),
                        MyStatefulWidget(
                          title: 'Outdoors',
                        ),
                        MyStatefulWidget(
                          title: 'Indoors',
                        ),
                        MyStatefulWidget(
                          title: 'TPE',
                        ),
                        MyStatefulWidget(
                          title: 'Wifi',
                        ),
                        MyStatefulWidget(
                          title: 'Karaoke',
                        ),
                      ],
                    )
                  ],
                ) ,
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: KBlue
                    ),
                    child: Text(
                      'Check result',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class FilterParameter extends StatelessWidget {
  final String title;

  const FilterParameter({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 22.5,
            color: KBlue,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  final String title;

  const MyStatefulWidget({Key key, this.title}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return KBlue;
    }

    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool value) {
            setState(() {
              isChecked = value;
            });
          },
        ),
        Text(
          widget.title ,
          style: TextStyle(color: KBlue, fontSize: 20),
        ),
      ],
    );
  }
}
