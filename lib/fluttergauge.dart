library flutter_gauge;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gauge/handpainter.dart';
import 'package:flutter_gauge/linepainter.dart';
import 'package:rxdart/rxdart.dart';

import 'gaugetextpainter.dart';

class FlutterGauge extends StatefulWidget {

  int start;
  int end;
  double highlightStart;
  double highlightEnd;
  ThemeData themeData;
  String fontFamily;
  double width;
  PublishSubject<double> eventObservable;
  Color colorHourHand;
  FlutterGauge({this.start,this.end,this.highlightStart,this.highlightEnd,this.themeData, this.eventObservable,@required this.fontFamily,@required this.width,@required this.colorHourHand,}){
//        print(this.highlightEnd);

  }

  @override
  _FlutterGaugeState createState() => new _FlutterGaugeState(this.start,this.end,this.highlightStart,this.highlightEnd,this.eventObservable);
}

class _FlutterGaugeState extends State<FlutterGauge>  with TickerProviderStateMixin{
  int start;
  int end;
  double highlightStart;
  double highlightEnd;
  PublishSubject<double> eventObservable;
  double val = 0.0;
  double newVal;
  AnimationController percentageAnimationController;


  _FlutterGaugeState(int start, int end, double highlightStart, double highlightEnd, PublishSubject<double> eventObservable) {
    this.start = start;
    this.end = end;
    this.highlightStart = highlightStart;
    this.highlightEnd = highlightEnd;
    this.eventObservable = eventObservable;


    percentageAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 1000)
    )
      ..addListener((){
        setState(() {
          val = lerpDouble(val,newVal,percentageAnimationController.value);
        });
      });
    this.eventObservable.listen((value) => reloadData(value));
  }

  reloadData(double value){
    print(value);
    newVal = value;
    percentageAnimationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return new Container(
              height: constraints.maxWidth,
              width: constraints.maxWidth,
              child: new Stack(
                  fit: StackFit.expand,

                  children: <Widget>[new Container(
                    child: new CustomPaint(
                        foregroundPainter: new LinePainter(
                            lineColor: this.widget.themeData.backgroundColor,
                            completeColor: this.widget.themeData.primaryColor,
                            startValue: this.start,
                            endValue: this.end,
                            startPercent: this.widget.highlightStart,
                            endPercent: this.widget.highlightEnd,
                            width: this.widget.width,
                            value: this.val
                        )
                    ),
                  ),
                    new Center(
                      //   aspectRatio: 1.0,
                        child: new Container(
                            height: constraints.maxWidth,
                            width: double.infinity,
                            padding: const EdgeInsets.all(30.0),
                            child: new Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  new CustomPaint(
                                    painter: new HandPainter(
                                        value: val,
                                        start: this.start,
                                        end: this.end,
                                        color: this.widget.themeData.accentColor),
                                  ),
                                ]
                            )
                        )
                    ),
                    new Center(
                      child: new Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: this.widget.themeData.indicatorColor,
                        ),
                      ),
                    ),

                    new CustomPaint(
                        painter: new GaugeTextPainter(
                            start: this.start,
                            end: this.end,
                            value: this.val,
                            fontFamily: widget.fontFamily,
                            color: this.widget.colorHourHand,
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontFamily: widget.fontFamily
                            )
                        )),



                    new CustomPaint(
                        painter: new GaugeTextCounter(
                            start: this.start,
                            end: this.end,
                            value: this.val,
                            fontFamily: widget.fontFamily,
                            color: this.widget.colorHourHand,
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontFamily: widget.fontFamily
                            )
                        )),





                  ]
              ),
            );
          }),
    );
  }
}