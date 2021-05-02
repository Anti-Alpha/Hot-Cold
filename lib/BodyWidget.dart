import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  _launchUrl() async{
    const url = "https://github.com/Anti-Alpha/Hot-Cold/blob/master/data.csv";
    if(await canLaunch(url)){
      await launch(url,
        forceWebView: true,
        forceSafariVC: true
      );
    }else{
      throw 'could not launch url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Align(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: mq.size.height*0.25,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Color(0xff2C2F38),
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          height: mq.size.width*0.55,
                          width: mq.size.width*0.55,
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/'+widget.Season+'.png',
                                  width: mq.size.width*0.17,
                                  height: mq.size.width*0.17,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("\tCompany should choose strategy #${response()}",
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      color: Color(0xFFE6E6E6),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                // child: Card(
                  // margin: EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: mq.size.height*0.08,
                    width: mq.size.width*0.9,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xff2D3039),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        _launchUrl();
                        print("Hello, World!");
                      },
                      child: Center (
                        child: Text(
                          'Open Strategies',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: Color(0xFFE6E6E6)),
                        ),
                      ),
                    ),
                  ),
                ),
              // ),
            ],
          ),
        ],
      ),
    );
  }


}
