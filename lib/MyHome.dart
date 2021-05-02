import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

import './BodyWidget.dart';

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> {
  bool connected = false;
  var Season = '';
  var ServerResponse = '';
  var countt = '';

  Color colorwin = Color(0xff2D3039);
  Color colorspr = Color(0xff2D3039);
  Color colorsum = Color(0xff2D3039);
  Color coloraut = Color(0xff2D3039);

  void _handleCountryChanged(var newValue) {
    setState(() {
      countt = newValue.name;
    });
  }

  _makeGetRequest() async {
    try {
      Response response = await get(Uri.parse(_localhost()));
      setState(() {
        ServerResponse = response.body;
      });
    }on Exception catch (_){
      ServerResponse = '';
    }
  }

  String _localhost() {
    return 'https://hot-cold-310815.uc.r.appspot.com/season/' + Season;
  }
  bool win = false, spr = false, sum = false, aut = false;

  Color picker(String season){
    const Color tapped = Color(0xff585D6A), notTapped = Color(0xff2D3039);
    if(season == "Winter"){
      if(win) return tapped;
      else return notTapped;
    } else if(season == "Spring"){
      if(spr) return tapped;
      else return notTapped;
    } else if(season == "Summer"){
      if(sum) return tapped;
      else return notTapped;
    } else if(season == "Autumn"){
      if(aut) return tapped;
      else return notTapped;
    }else{
      return notTapped;
    }
  }

  Widget SeasonButton(String season){
    return AnimatedContainer(
      width: 75.0,
      height: 90.0,
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: picker(season),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            win = (season == "Winter");
            spr = (season == "Spring");
            sum = (season == "Summer");
            aut = (season == "Autumn");
            Season = season;
          });
          _makeGetRequest();
          Timer(Duration(milliseconds: 600), (){
            print(ServerResponse);
            if(ServerResponse.isEmpty) connected = false;
            else connected = true;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 5,
              width: 20,
            ),
            Image.asset(
              'assets/images/'+season+'.png',
              width: 30.0,
              height: 30.0,
            ),
            Container(
              height: 15,
              width: 20,
            ),
            Text(
              season,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Color(0xFFE6E6E6)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff1D2026),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1D2026),
        shadowColor: Color(0xff1D2026),
        title: Image.asset(
          'assets/images/ss.png',
          height: 150,
          width: 150,
        ),
      ),
      body: new Stack(
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                height: 50,
                width: 300,
                // color: Colors.blue[600],
              ),
              Container(
                height: 60.0,
                width: 370.0,
                decoration: BoxDecoration(
                  color: Color(0xff2C2F38),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: CountryCodePicker(

                  dialogBackgroundColor: Color(0xff1D2026),
                  barrierColor: Color(0xff1D2026),
                  searchStyle: TextStyle(color: Color(0xFFE6E6E6)),
                  backgroundColor: Color(0xff1D2026),
                  padding: EdgeInsets.all(5.0),
                  onChanged: _handleCountryChanged,
                  initialSelection: 'UA',
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  searchDecoration: InputDecoration(
                    focusColor: Color(0xFFE6E6E6),
                    hoverColor: Color(0xFFE6E6E6),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff1D2026)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffAEB0B3)),
                    ),
                    prefixIcon: Icon(
                      Icons.search_sharp,
                      color: Color(0xFFE6E6E6),
                      size: 24.0,
                      semanticLabel:
                      'Text to announce in accessibility modes',
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xFFE6E6E6),
                      fontSize: 13,
                    ),
                    // enabledBorder: OutlineInputBorder(
                    //   // borderSide: BorderSide(
                    //   //   color: Color(0xff585D6A),
                    //   // ),
                    //   borderRadius: BorderRadius.circular(10.0),
                    // ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter Your Text...",

                    hintStyle: TextStyle(
                      color: Color(0xffAEB0B3),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  textStyle: TextStyle(color: Color(0xffAEB0B3)),
                  dialogTextStyle: TextStyle(color: Color(0xffAEB0B3)),
                  favorite: ['+38', 'UA'],
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  alignLeft: false,
                ),
              ),
              Container(
                  margin: EdgeInsets.all(24),
                  padding: EdgeInsets.only(top: 24),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Season',
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w700,
                        // style: TextStyle(fontFamily: 'OpenSans'),
                        color: new Color(0xFFE6E6E6)),
                  )
                // color: Colors.yellow[600],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SeasonButton("Winter"),
                  SeasonButton("Spring"),
                  SeasonButton("Summer"),
                  SeasonButton("Autumn")
                ],
              ),
              Container(
                height: 320,
                // color: Colors.blue,
              ),
              Container(
                height: 70,
                width: 390,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xff2D3039),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Timer(Duration(milliseconds: 600), ()
                    {
                      if(connected)
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BodyWidget(Season, ServerResponse)));
                      else
                        Fluttertoast.showToast(
                            msg: "No Internet Connection. Try again",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            fontSize: 13.0
                        );
                        print("Not connected to the Internet");
                    });
                  },
                  child: Center (
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xFFE6E6E6)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}