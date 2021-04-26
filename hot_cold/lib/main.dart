import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class Responsive {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BodyWidget()));
}


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MyHome()
    );
  }
}

var season;
var serverResponse = '';

class MyHome extends StatefulWidget {
  @override
  MyHomeState createState() => new MyHomeState();
}

class MyHomeState extends State<MyHome> {
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
    Response response = await get(Uri.parse(_localhost()));
    setState(() {
      serverResponse = response.body;
    });
  }

  String _localhost() {
    print('https://02bc96d10276.ngrok.io/season/' + season);
    return 'https://02bc96d10276.ngrok.io/season/' + season;

  }
  bool win = false, spr = false, sum = false, aut = false;

  // AnimationController _animationController;
  // Animation _colorTween;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: '1',
      home: Scaffold(
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
                      image: new AssetImage('assets/images/aa.png'),
                      fit: BoxFit.cover)),
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
                    AnimatedContainer(
                        width: 75.0,
                        height: 90.0,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: win ? Color(0xff585D6A) : Color(0xff2D3039),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                colorwin = Color(0xff585D6A);
                                colorspr = Color(0xff2D3039);
                                colorsum = Color(0xff2D3039);
                                coloraut = Color(0xff2D3039);
                                win = true;
                                spr = false;
                                sum = false;
                                aut = false;
                                season = 'Winter';
                                print(countt);
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
                                Container(
                                  child: Image.asset(
                                    'assets/images/dd.png',
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
                                Container(
                                  height: 15,
                                  width: 20,
                                ),
                                Text(
                                  'Winter',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
                    AnimatedContainer(
                        width: 75.0,
                        height: 90.0,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: spr ? Color(0xff585D6A) : Color(0xff2D3039),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                colorwin = Color(0xff2D3039);
                                colorspr = Color(0xff585D6A);
                                colorsum = Color(0xff2D3039);
                                coloraut = Color(0xff2D3039);
                                win = false;
                                spr = true;
                                sum = false;
                                aut = false;
                                season = 'Spring';
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
                                  // color: Colors.blue,
                                ),
                                Image.asset(
                                  'assets/images/ff.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                Container(
                                  height: 15,
                                  width: 20,
                                ),
                                Text(
                                  'Spring',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
                    AnimatedContainer(
                        width: 75.0,
                        height: 90.0,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: sum ? Color(0xff585D6A) : Color(0xff2D3039),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                colorwin = Color(0xff2D3039);
                                colorspr = Color(0xff2D3039);
                                colorsum = Color(0xff585D6A);
                                coloraut = Color(0xff2D3039);
                                win = false;
                                spr = false;
                                sum = true;
                                aut = false;
                                season = 'Summer';
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
                                  // color: Colors.blue,
                                ),
                                Image.asset(
                                  'assets/images/cc.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                Container(
                                  height: 15,
                                  width: 20,
                                ),
                                Text(
                                  'Summer',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
                    AnimatedContainer(
                        width: 75.0,
                        height: 90.0,
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: aut ? Color(0xff585D6A) : Color(0xff2D3039),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: MaterialButton(
                            onPressed: () {
                              setState(() {
                                colorwin = Color(0xff2D3039);
                                colorspr = Color(0xff2D3039);
                                colorsum = Color(0xff2D3039);
                                coloraut = Color(0xff585D6A);
                                win = false;
                                spr = false;
                                sum = false;
                                aut = true;
                                season = 'Autumn';
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
                                  'assets/images/gg.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                Container(
                                  height: 15,
                                  width: 20,
                                ),
                                Text(
                                  'Autumn',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
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
                      _makeGetRequest();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BodyWidget()));
                    },
                    child: Center (
                      child: Text(
                        'Continue',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFFE6E6E6)),
                      ),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}



class BodyWidget extends StatefulWidget {
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  @override
  String get myVariable => serverResponse;
  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff1D2026),
          shadowColor: Color(0xff1D2026),
          title: Text(season,
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w100,
                fontSize: 23,
                color: Color(0xFFE6E6E6)),

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
                      image: new AssetImage('assets/images/aa.png'),
                      fit: BoxFit.cover)),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Align(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Color(0xff2C2F38),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            height: 150,
                            width: 150,
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(myVariable,
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Color(0xFFE6E6E6)),

                                    ),
                                  ),
                                ]
                            )

                        ),

                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child:  Container(
                              height: 70,
                              width: 390,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xff2D3039),
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LunchWebView()));
                                },
                                child: Center (
                                  child: Text(
                                    'Open Strategies',
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Color(0xFFE6E6E6)),
                                  ),),
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



          ],
        ),
      ),

    );
  }


}

// final String text;
// LunchWebView(this.text);


class LunchWebView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LunchWebViewState();


}

class _LunchWebViewState extends State<LunchWebView> {



  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff1D2026),
          shadowColor: Color(0xff1D2026),
          title: Text('Strategies',
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w100,
                fontSize: 23,
                color: Color(0xFFE6E6E6)),

          ),
        ),
        body:  new MaterialApp(
          routes: {
            "/": (_) => new WebviewScaffold(
              url: "https://github.com/Anti-Alpha/Hot-Cold/blob/master/data.csv",
              appBar: new AppBar(

                title: new Text("Strategies"),
              ),
            ),
          },
        ),
      ),
    );

  }
}

