import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp>{
  var countt;
  var season;
  Color colorwin = Color(0xff2D3039);
  Color colorspr = Color(0xff2D3039);
  Color colorsum = Color(0xff2D3039);
  Color coloraut = Color(0xff2D3039);


  bool win = false, spr = false, sum = false, aut = false;
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

        body:
   Container (
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget> [

           Container(
               width: 80.0,
               height: 110.0,
               decoration: BoxDecoration(
                 color: colorwin,
                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
               ),
              child: TextButton(
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
                    });
                  },

                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        height: 10,
                        width: 20,
                      ),
                   Image.asset('assets/images/dd.png',
                    width: 40.0,
                    height: 40.0,),
                      Container(
                        height: 10,
                        width: 20,
                      ),
          Text(
            'Winter',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffAEB0B3)),
          ),


        ],

      ))),
          Container(
              width: 80.0,
              height: 110.0,
              decoration: BoxDecoration(

                color: colorspr,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: TextButton(

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

                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        height: 5,
                        width: 20,
                      ),
                      Image.asset('assets/images/ff.png',
                        width: 40.0,
                        height: 40.0,),
                      Container(
                        height: 10,
                        width: 20,
                      ),
                      Text(
                        'Spring',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffAEB0B3)),
                      ),


                    ],

                  ))),
          Container(
              width: 80.0,
              height: 110.0,
              decoration: BoxDecoration(

                color: colorsum,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: TextButton(

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

                  child: Column (

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        height: 5,
                        width: 20,
                      ),
                      Image.asset('assets/images/cc.png',
                        width: 40.0,
                        height: 40.0,),
                      Container(
                        height: 10,
                        width: 20,
                      ),
                      Text(
                        'Summer',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffAEB0B3)),
                      ),


                    ],

                  ))),
          Container(
              width: 80.0,
              height: 110.0,
              decoration: BoxDecoration(

                color: coloraut,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: TextButton(

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
                      season = 'autmn';
                    });
                  },

                  child: Column (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Container(
                        height: 5,
                        width: 20,
                      ),
                      Image.asset('assets/images/gg.png',
                        width: 40.0,
                        height: 40.0,),
                      Container(
                        height: 10,
                        width: 20,
                      ),
                      Text(
                        'Autmn',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffAEB0B3)),
                      ),


                    ],

                  ))),
        ],
      )

      ],
    ),
        ),

        ),


      ),
    );
  }
}
