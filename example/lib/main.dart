import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gauge/fluttergauge.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double count = 200;
  animateHourHand(count,oldCount){
    if(count + 10 < oldCount || count - 10 > oldCount){
      if(oldCount < count){
        Timer(Duration(milliseconds: 1000),(){
          eventObservable.add(count+3);
          Timer(Duration(milliseconds: 700),(){
            eventObservable.add(count-2);
            Timer(Duration(milliseconds: 400),(){
              eventObservable.add(count);
            });
          });
        });
      }else{
        Timer(Duration(milliseconds: 1000),(){
          eventObservable.add(count-3);
          Timer(Duration(milliseconds: 700),(){
            eventObservable.add(count+0.5);
            Timer(Duration(milliseconds: 400),(){
              eventObservable.add(count);
            });
          });
        });
      }
    }else{
      eventObservable.add(count);
    }
  }

//  @override
//  void initState() {
//    super.initState();
//    const oneSec = const Duration(seconds:1);
//    var rng = new Random();
//    new Timer.periodic(oneSec, (Timer t) => eventObservable.add(rng.nextInt(200)+rng.nextDouble()));
//
//  }

  PublishSubject<double> eventObservable = new PublishSubject();
//  final ThemeData somTheme = new ThemeData(
//    primaryColor: Colors.cyan,
//    accentColor: Colors.black,
//    backgroundColor: Colors.cyan,
//    indicatorColor: Colors.black,
//  );

  @override
  Widget build(BuildContext context) {
    animateHourHand(150.0,7.0);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Container(color: Colors.black38,child: FlutterGauge(inactiveColor: Colors.white38,activeColor: Colors.white,handSize: 30,width: 200,index: 65.0,fontFamily: "Iran",end: 400,number: Number.none,secondsMarker: SecondsMarker.minutes,isCircle: false,hand: Hand.none,counterAlign: CounterAlign.center,counterStyle: TextStyle(color: Colors.white,fontSize: 30,),isDecimal: false,),),),
              Expanded(child: FlutterGauge(width: 200,index: 65.0,fontFamily: "Iran",),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: FlutterGauge(handSize: 30,width: 200,index: 65.0,fontFamily: "Iran",end: 100,number: Number.endAndCenterAndStart,secondsMarker: SecondsMarker.secondsAndMinute),),
              Expanded(child: FlutterGauge(secondsMarker: SecondsMarker.none,hand: Hand.short,number: Number.none,width: 200,index: 38.0,fontFamily: "Iran",counterStyle: TextStyle(color: Colors.black,fontSize: 35),counterAlign: CounterAlign.center,isDecimal: false,),),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(child: FlutterGauge(handSize: 30,width: 200,index: 65.0,fontFamily: "Iran",end: 500,number: Number.endAndCenterAndStart,secondsMarker: SecondsMarker.minutes,isCircle: false,),),
              Expanded(child: FlutterGauge(handSize: 30,width: 200,index: 80.0,fontFamily: "Iran",end: 100,number: Number.endAndCenterAndStart,secondsMarker: SecondsMarker.secondsAndMinute,hand: Hand.short,),),
            ],
          ),

        ],
      ),
    );
  }
}







class FlutterGaugeExample extends StatefulWidget {
  FlutterGaugeExample({this.padding,@required this.count,this.eventObservable});
  double count;
  EdgeInsetsGeometry padding;
  PublishSubject<double> eventObservable;

  @override
  _FlutterGaugeExampleState createState() => new _FlutterGaugeExampleState();
}

class _FlutterGaugeExampleState extends State<FlutterGaugeExample> {
  int counter = 0;



  @override
  Widget build(BuildContext context) {
    return  FlutterGaugeMain(start:0, end: (widget.count).toInt(), highlightStart:(widget.count/widget.count.toInt()), highlightEnd:(0/widget.count.toInt()), eventObservable: widget.eventObservable,fontFamily: "Iran",widthCircle: 20,colorHourHand: Colors.black,);
  }


}




