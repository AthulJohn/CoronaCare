import 'dart:convert';
import 'dart:ui';

import 'package:coronaweb/Screens/Statistics.dart';
import 'package:coronaweb/scrolldata.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ScrollData(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Play',
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double siz = 0;
  int cases = 0, rec = 0, death = 0;
  void onPointerScroll(double pointerSignal) {
    Provider.of<ScrollData>(context, listen: false).increme(pointerSignal);
  }

  void fetchdata() async {
    try {
      http.Response response =
          await http.get('https://api.exchangeratesapi.io/latest');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Map<String, dynamic> json = jsonDecode(response.body);
        cases = json['Global']['TotalConfirmed'];
        rec = json['Global']['TotalRecovered'];
        death = json['Global']['TotalDeaths'];
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        cases = 71070908;
        death = 1594677;
        rec = 45341477;
      }
    } catch (e) {
      cases = 71070908;
      death = 1594677;
      rec = 45341477;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerSignal: (pointerSignal) {
          if (pointerSignal is PointerScrollEvent)
            onPointerScroll(pointerSignal.scrollDelta.dy);
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/virus.jpeg'))),
            child: Consumer<ScrollData>(builder: (context, scrolldata, child) {
              return BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: scrolldata.sc < 300 ? scrolldata.sc / 50 : 6,
                      sigmaY: scrolldata.sc < 300 ? scrolldata.sc / 50 : 6),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: scrolldata.sc <= 1450 ? 0 - scrolldata.sc : -1450,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 2.75,
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    'Its Closer Than You Think',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 50),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 1500),
                                opacity: scrolldata.sc < 400
                                    ? scrolldata.sc / 400
                                    : 1.0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Center(
                                    child: Text(
                                      '''Coronavirus disease (COVID-19) is an infectious disease caused by 
a newly discovered coronavirus.
Most people infected with the COVID-19 virus will experience mild to moderate 
respiratory illness and recover without requiring special treatment.  
Older people, and those with underlying medical problems like cardiovascular 
disease, diabetes, chronic respiratory disease, and cancer are more likely to 
develop serious illness.''',
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: Duration(milliseconds: 1500),
                                opacity: scrolldata.sc > 800
                                    ? 1.0
                                    : scrolldata.sc < 400
                                        ? 0.0
                                        : (scrolldata.sc - 400) / 400,
                                child: Container(
                                  color: Colors.black,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Till now...',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25)),
                                        SizedBox(height: 20),
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            child: Center(
                                                child: Statistics(
                                                    cases, rec, death))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 1500),
                                  opacity: scrolldata.sc >= 1100 &&
                                          scrolldata.sc <= 1700
                                      ? 1.0
                                      : scrolldata.sc <= 700 ||
                                              scrolldata.sc >= 1900
                                          ? 0.0
                                          : scrolldata.sc < 1100
                                              ? (scrolldata.sc - 700) / 400
                                              : (scrolldata.sc - 1700) / 200,
                                  child: Container(
                                      child: Center(
                                          child: Text(
                                              'So how can we Protect ourselves...',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25)))),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: scrolldata.sc < 1900
                              ? //MediaQuery.of(context).size.height -
                              scrolldata.sc - 1700
                              : 200,
                          right: scrolldata.sc < 1900
                              ? //MediaQuery.of(context).size.height -
                              scrolldata.sc - 1700
                              : 200,
                          left: scrolldata.sc < 1900
                              ? //MediaQuery.of(context).size.height -
                              scrolldata.sc - 1700
                              : 200,
                          top: scrolldata.sc < 1900
                              ? //MediaQuery.of(context).size.height -
                              scrolldata.sc - 1700
                              : 200,
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 1500),
                              opacity: scrolldata.sc > 1500
                                  ? 1.0
                                  : scrolldata.sc < 1200
                                      ? 0.0
                                      : (scrolldata.sc - 1200) / 300,
                              child: Image(
                                image: AssetImage('assets/window.png'),
                              ))),
                      Positioned(
                          top: scrolldata.sc < 1900
                              ? MediaQuery.of(context).size.height -
                                  (scrolldata.sc - 1700)
                              : MediaQuery.of(context).size.height - 200,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white,
                          )),
                      Positioned(
                          bottom: scrolldata.sc < 1900
                              ? MediaQuery.of(context).size.height -
                                  (scrolldata.sc - 1700)
                              : MediaQuery.of(context).size.height - 200,
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.white,
                          )),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          left: scrolldata.sc < 1900
                              ? MediaQuery.of(context).size.width -
                                  (scrolldata.sc - 1570)
                              : MediaQuery.of(context).size.width - 340,
                          right: 0,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 1500),
                                  opacity: scrolldata.sc >= 2000 &&
                                          scrolldata.sc <= 2400
                                      ? 1.0
                                      : scrolldata.sc <= 1850 ||
                                              scrolldata.sc >= 2550
                                          ? 0.0
                                          : scrolldata.sc < 2000
                                              ? (scrolldata.sc - 1850) / 150
                                              : (2550 - scrolldata.sc) / 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Text(
                                        "Lockdown is meant to prevent the spread of infection from one person to another" +
                                            ", to protect ourselves and others. This means, not stepping out of the house except" +
                                            " for buying necessities, reducing the number of trips outside, and ideally only a " +
                                            "single, healthy family member making the trips when absolutely necessary. If there " +
                                            "is anyone in the house who is very sick and may need to get medical help, you must be" +
                                            " aware of the health facility nearest to you.",
                                        style: TextStyle(fontSize: 20)),
                                  )),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: scrolldata.sc < 1900
                              ? MediaQuery.of(context).size.width -
                                  (scrolldata.sc - 1570)
                              : MediaQuery.of(context).size.width - 340,
                          child: Container(
                            color: Colors.white,
                            child: Center(
                              child: AnimatedOpacity(
                                  duration: Duration(milliseconds: 1500),
                                  opacity: scrolldata.sc >= 2000 &&
                                          scrolldata.sc <= 2400
                                      ? 1.0
                                      : scrolldata.sc <= 1850 ||
                                              scrolldata.sc >= 2550
                                          ? 0.0
                                          : scrolldata.sc < 2000
                                              ? (scrolldata.sc - 1850) / 150
                                              : (2550 - scrolldata.sc) / 150,
                                  child: Text(" Stay \n Indoors",
                                      style: TextStyle(fontSize: 60))),
                            ),
                          )),
                      BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: scrolldata.sc < 2500
                                  ? 0
                                  : scrolldata.sc < 2800
                                      ? (scrolldata.sc - 2500) / 50
                                      : 6,
                              sigmaY: scrolldata.sc < 2500
                                  ? 0
                                  : scrolldata.sc < 2800
                                      ? (scrolldata.sc - 2500) / 50
                                      : 6),
                          child: Stack(
                            children: [
                              Positioned(
                                  bottom: scrolldata.sc < 1900
                                      ? MediaQuery.of(context).size.height -
                                          (scrolldata.sc - 1700)
                                      : MediaQuery.of(context).size.height -
                                          200,
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/hands.gif'),
                                            fit: BoxFit.contain)),
                                  )),
                              Positioned(
                                  bottom: scrolldata.sc < 1900
                                      ? MediaQuery.of(context).size.height -
                                          (scrolldata.sc - 1700)
                                      : MediaQuery.of(context).size.height -
                                          200,
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                      child: Text('Wash your Hands'))),
                              Positioned(
                                  bottom: scrolldata.sc < 1900
                                      ? MediaQuery.of(context).size.height -
                                          (scrolldata.sc - 1700)
                                      : MediaQuery.of(context).size.height -
                                          200,
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                      child: Text(
                                          'Handwashing is one of the best ways to protect yourself and your family from getting sick.Washing hands can keep you healthy and prevent the spread of respiratory and diarrheal infections from one person to the next. Washing hands with soap and water is the best way to get rid of germs in most situations. If soap and water are not readily available, you can use an alcohol-based hand sanitizer that contains at least 60% alcohol.'))),
                              Positioned(
                                  bottom: scrolldata.sc < 1900
                                      ? MediaQuery.of(context).size.height -
                                          (scrolldata.sc - 1700)
                                      : MediaQuery.of(context).size.height -
                                          200,
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/socdist.gif'),
                                            fit: BoxFit.contain)),
                                  )),
                              Positioned(
                                  bottom: scrolldata.sc < 1900
                                      ? MediaQuery.of(context).size.height -
                                          (scrolldata.sc - 1700)
                                      : MediaQuery.of(context).size.height -
                                          200,
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/hands.gif'),
                                            fit: BoxFit.contain)),
                                  )),
                            ],
                          ))
                      // ColorFiltered(
                      //   colorFilter: ColorFilter.mode(
                      //       Colors.black.withOpacity(0.8),
                      //       BlendMode.srcOut), // This one will create the magic
                      //   child: Stack(
                      //     fit: StackFit.expand,
                      //     children: [
                      //       Container(
                      //         height: 900,
                      //         width: 900,
                      //         decoration: BoxDecoration(
                      //             color: Colors.black,
                      //             backgroundBlendMode: BlendMode
                      //                 .dstOut), // This one will handle background + difference out
                      //       ),
                      //       Container(
                      //         height: 500,
                      //         width: 500,
                      //         decoration: BoxDecoration(
                      //             color: Colors.red,),
                      //       ),
                      //     ],
                      //   ),
                      // )
                      // Center(
                      //     //     top: 100 + siz * 0.9,
                      //     //     left: (siz - 200) * 1.25,
                      //     //     bottom: (siz - 200) / 2,
                      //     child: Container(
                      //   // //height: MediaQuery.of(context).size.height,
                      //   width: 790,
                      //   height: 500,
                      //   color: Colors.red,
                      //   child: Statistics(cases, rec, death,scrolldata.sc),
                      // )),
                      // Positioned(
                      //     top: 100 + siz * 0.9,
                      //     left: (siz - 200) * 1.25,
                      //     bottom: (siz - 200) / 2,
                      //     child: Container(
                      //       //height: MediaQuery.of(context).size.height,
                      //       width: 500 - siz > 0 ? 500 - siz : 0,
                      //       color: Colors.red,
                      //     )),
                      // // Positioned(
                      // //     top: (siz - 300) / 2 <= 0 ? 0 : (siz - 300) / 2,
                      // //     left: (siz - 300) * 1.25 < 0 ? 0 : (siz - 300) * 1.25,
                      // //     bottom: (siz - 300) / 2 < 0 ? 0 : (siz - 300) / 2,
                      // //     child: Container(
                      // //       //height: MediaQuery.of(context).size.height,
                      // //       width: siz < 300
                      // //           ? 0
                      // //           : (800 - siz) < 0
                      // //               ? 0
                      // //               : (800 - siz),
                      // //       color: Colors.green,
                      // //     )),
                      // Positioned(
                      //     top: (siz - 600) / 2 < 0 ? 0 : (siz - 600) / 2,
                      //     left: (siz - 600) / 1 < 0 ? 0 : (siz - 600) / 1,
                      //     bottom: (siz - 600) / 2 < 0 ? 0 : (siz - 600) / 2,
                      //     child: Container(
                      //       //height: MediaQuery.of(context).size.height,
                      //       width: siz < 600
                      //           ? 0
                      //           : (1100 - siz) < 0
                      //               ? 0
                      //               : (1100 - siz),
                      //       color: Colors.red,
                      //     )),
                      // // Container(
                      //   color: Colors.green,
                      //   height: 30,
                      //   width: size,
                      // )
                    ],
                  ));
            }),
          ),
        ));
  }
}
