library flutter_gauge;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gauge/fluttergauge.dart';
import 'package:rxdart/rxdart.dart';

enum SecondsMarker { minutes, secondsAndMinute, all, none, seconds }

enum Number {
  all,
  endAndStart,
  endAndCenterAndStart,
  none,
}

enum NumberInAndOut { inside, outside }

enum CounterAlign {
  none,
  center,
  top,
  bottom,
}

enum Hand { none, long, short }

enum Animate { none, knock, forget }

class FlutterGauge extends StatefulWidget {
  int start;
  int end;
  String fontFamily;
  double widthCircle;
  double index;
  double width;
  Number number;
  NumberInAndOut numberInAndOut;
  CounterAlign counterAlign;
  Hand hand;
  bool isCircle;
  double handSize;
  bool isDecimal;
  SecondsMarker secondsMarker;
  double shadowHand;
  Color circleColor;
  Color handColor;
  Color backgroundColor;
  Color indicatorColor;
  Color inactiveColor;
  Color activeColor;
  double paddingHand;
  Animate animate;
  TextStyle counterStyle;
  TextStyle textStyle;

  FlutterGauge({
    this.isDecimal = true,
    this.inactiveColor = Colors.black,
    this.activeColor = Colors.red,
    this.textStyle,
    this.counterStyle,
    this.numberInAndOut = NumberInAndOut.inside,
    this.width /*,this.animate=Animate.none*/,
    this.paddingHand = 30.0,
    this.circleColor = Colors.cyan,
    this.handColor = Colors.black,
    this.backgroundColor = Colors.cyan,
    this.indicatorColor = Colors.black,
    this.shadowHand = 4.0,
    this.counterAlign = CounterAlign.bottom,
    this.number = Number.all,
    this.isCircle = true,
    this.hand = Hand.long,
    this.secondsMarker = SecondsMarker.all,
    this.handSize = 30,
    this.start = 0,
    this.end = 100,
    @required this.index,
    this.fontFamily = "",
    this.widthCircle = 20,
  });

  @override
  _FlutterGaugeState createState() => _FlutterGaugeState();
}

class _FlutterGaugeState extends State<FlutterGauge> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 400), () {
      eventObservable.add(widget.index);
    });
  }

  PublishSubject<double> eventObservable = new PublishSubject();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        FlutterGaugeMain(
            isDecimal: widget.isDecimal,
            counterStyle: widget.counterStyle,
            textStyle: widget.textStyle,
            numberInAndOut: widget.numberInAndOut,
            paddingHand: widget.paddingHand,
            circleColor: widget.circleColor,
            handColor: widget.handColor,
            backgroundColor: widget.backgroundColor,
            indicatorColor: widget.indicatorColor,
            shadowHand: widget.shadowHand,
            counterAlign: widget.counterAlign,
            number: widget.number,
            isCircle: widget.isCircle,
            hand: widget.hand,
            secondsMarker: widget.secondsMarker,
            handSize: widget.handSize,
            start: widget.start,
            end: widget.end,
            highlightStart: (widget.end / widget.end.toInt()),
            highlightEnd: (0 / widget.end.toInt()),
            eventObservable: eventObservable,
            fontFamily: widget.fontFamily,
            widthCircle: widget.widthCircle > 30 ? 30 : widget.widthCircle,
            inactiveColor: widget.inactiveColor,
            activeColor: widget.activeColor,
            width: (widget.width == null
                ? MediaQuery.of(context).size.width / 2
                : widget.width < (MediaQuery.of(context).size.width / 2)
                    ? (MediaQuery.of(context).size.width / 2)
                    : (widget.width > (MediaQuery.of(context).size.width)
                        ? MediaQuery.of(context).size.width
                        : widget.width)))
      ],
    );
  }
}
