import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var countt;
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
          title: Image.asset('assets/images/ss.png',
            width: 150.0,
            height: 150.0,
          ),
        ),

        body: SingleChildScrollView (
   child: Container (
    child: Center(
      child: Column (
        children: <Widget> [
          Container(
            height: 200,
            width: 300,
            // color: Colors.blue[600],
          ),
          Container(
          height: 50.0,
          width: 300.0,
          decoration: BoxDecoration(
            color: Color(0xff2C2F38),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
            child: CountryCodePicker(
              dialogBackgroundColor: Color(0xff1D2026),
              barrierColor: Color(0xff1D2026),
          searchStyle: TextStyle (color: Color(0xffAEB0B3)),
          backgroundColor: Color(0xff1D2026),
                padding: EdgeInsets.all(16.0),
          onChanged: (c) => (countt = c.name),
          initialSelection: 'UA',
                searchDecoration: InputDecoration (),
        textStyle: TextStyle (color: Color(0xffAEB0B3)),
        dialogTextStyle: TextStyle (color: Color(0xffAEB0B3)),
        favorite: ['+38','UA'],
        showCountryOnly: true,
        showOnlyCountryWhenClosed: true,
        alignLeft: false,
        ),
        ),
          Container(
            height: 100,
            width: 300,
            // color: Colors.yellow[600],
          ),
      Row (
        children: <Widget> [
           Container(
               width: 90.0,
               height: 120.0,
               decoration: BoxDecoration(

                 color: Color(0xff2D3039),
                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
               ),
              child: TextButton(

                  onPressed: () {
                    print("FlatButton tapped");
                  },

                  child: Column (
                    children: <Widget> [
                      Container(
                        height: 10,
                        width: 20,
                      ),
                   Image.asset('assets/images/dd.png',
                    width: 60.0,
                    height: 60.0,),
                      Container(
                        height: 10,
                        width: 20,
                      ),
                      Text(
                        'Winter',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffAEB0B3)),
                      )
                    ],
      )))
        ],
      )

      ],
    ),
        ),

        ),

        ),
      ),
    );
  }
}
