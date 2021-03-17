import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';

void main() => runApp(MyApp());

class Responsive {
  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }

  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  var countt = '';
  var season;

  Color colorwin = Color(0xff2D3039);
  Color colorspr = Color(0xff2D3039);
  Color colorsum = Color(0xff2D3039);
  Color coloraut = Color(0xff2D3039);

  void _handleCountryChanged(var newValue) {
    setState(() {
      countt = newValue.name;
    });
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
                  height: 200,
                  width: 300,
                  // color: Colors.blue[600],
                ),
                Container(
                  height: 50.0,
                  width: 350.0,
                  decoration: BoxDecoration(
                    color: Color(0xff2C2F38),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: CountryCodePicker(
                    dialogBackgroundColor: Color(0xff1D2026),
                    barrierColor: Color(0xff1D2026),
                    searchStyle: TextStyle(color: Color(0xffAEB0B3)),
                    backgroundColor: Color(0xff1D2026),
                    padding: EdgeInsets.all(5.0),
                    onChanged: _handleCountryChanged,
                    initialSelection: 'UA',
                    flagDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    searchDecoration: InputDecoration(
                      focusColor: Color(0xffAEB0B3),
                      hoverColor: Color(0xffAEB0B3),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff1D2026)),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffAEB0B3)),
                      ),
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: Color(0xffAEB0B3),
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      labelStyle: TextStyle(
                        color: Colors.white,
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
                        width: 80.0,
                        height: 110.0,
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
                                season = 'winter';
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
                                  height: 10,
                                  width: 20,
                                ),
                                Image.asset(
                                  'assets/images/dd.png',
                                  width: 40.0,
                                  height: 40.0,
                                ),
                                Container(
                                  height: 10,
                                  width: 20,
                                ),
                                Text(
                                  'Winter',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
                    AnimatedContainer(
                        width: 80.0,
                        height: 110.0,
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
                                season = 'spring';
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
                                  width: 40.0,
                                  height: 40.0,
                                ),
                                Container(
                                  height: 10,
                                  width: 20,
                                ),
                                Text(
                                  'Spring',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
                    AnimatedContainer(
                        width: 80.0,
                        height: 110.0,
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
                                season = 'summer';
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
                                  width: 40.0,
                                  height: 40.0,
                                ),
                                Container(
                                  height: 10,
                                  width: 20,
                                ),
                                Text(
                                  'Summer',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
                    AnimatedContainer(
                        width: 80.0,
                        height: 110.0,
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
                                season = 'autumn';
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
                                  width: 40.0,
                                  height: 40.0,
                                ),
                                Container(
                                  height: 10,
                                  width: 20,
                                ),
                                Text(
                                  'Autumn',
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                      color: Color(0xFFE6E6E6)),
                                ),
                              ],
                            ))),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
