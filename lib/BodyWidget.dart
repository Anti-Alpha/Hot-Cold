import 'package:flutter/material.dart';

class BodyWidget extends StatefulWidget {
  String Season;
  String ServerResponse;
  BodyWidget(this.Season, this.ServerResponse);
  @override
  BodyWidgetState createState() {
    return new BodyWidgetState();
  }
}

class BodyWidgetState extends State<BodyWidget> {
  String response() => widget.ServerResponse.substring(12, widget.ServerResponse.length - 1);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1D2026),
        shadowColor: Color(0xff1D2026),
        title: Text(widget.Season,
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
                image: new AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
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
                                Image.asset(
                                  'assets/images/'+widget.Season+'.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("\tCompany should choose strategy #${response()}",
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

                      // Expanded(
                      //   child: Align(
                      //     alignment: FractionalOffset.bottomCenter,
                      //     child:  Container(
                      //       height: 70,
                      //       width: 390,
                      //       margin: EdgeInsets.all(20),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xff2D3039),
                      //         borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      //       ),
                      //       child: MaterialButton(
                      //         onPressed: () {
                      //           print("Hello, World!");
                      //         },
                      //         child: Center (
                      //           child: Text(
                      //             'Open Strategies',
                      //             style: TextStyle(
                      //                 fontFamily: 'OpenSans',
                      //                 fontWeight: FontWeight.w700,
                      //                 fontSize: 17,
                      //                 color: Color(0xFFE6E6E6)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}

