library flutter_gauge;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gauge/fluttergauge.dart';
import 'package:rxdart/rxdart.dart';

enum SecondsMarker {
  minutes,
  secondsAndMinute,
  all,
  none,
  seconds
}

enum Number {
  all,
  endAndStart,
  endAndCenterAndStart,
  none,

}

enum NumberInAndOut {
  inside,
  outside
}


enum CounterAlign{
  none,
  center,
  top,
  bottom,
}


enum Hand{
  none,
  long,
  short
}


enum Animate{
  none,
  knock,
  forget
}




class FlutterGauge extends StatefulWidget {
  int start;
  int end;
  String fontFamily;
  double widthCircle;
  double index;
  double width;
  Color colorHourHand;
  Number number;
  NumberInAndOut numberInAndOut;
  CounterAlign counterAlign;
  Hand hand;
  bool isCircle;

  double handSize;
  bool isDecimal;
  SecondsMarker secondsMarker;
  double shadowHand;
  Color primaryColor;
  Color accentColor;
  Color backgroundColor;
  Color indicatorColor;
  Color inactiveColor;
  Color activeColor;
  double paddingHand;
  Animate animate;
  TextStyle counterStyle;
  TextStyle textStyle;

  FlutterGauge({this.isDecimal=true,this.inactiveColor = Colors.black,this.activeColor = Colors.red,this.textStyle,this.counterStyle,this.numberInAndOut = NumberInAndOut.inside,this.width/*,this.animate=Animate.none*/,this.paddingHand=30.0,this.primaryColor = Colors.cyan,this.accentColor = Colors.black,this.backgroundColor = Colors.cyan,this.indicatorColor = Colors.black,this.shadowHand=4.0,this.counterAlign=CounterAlign.bottom,this.number=Number.all,this.isCircle=true,this.hand= Hand.long,this.secondsMarker=SecondsMarker.all,this.handSize=30,this.start=0,this.end=100,@required this.index,this.fontFamily="",this.widthCircle=20,this.colorHourHand=Colors.black,});


  @override
  _FlutterGaugeState createState() => _FlutterGaugeState();
}

class _FlutterGaugeState extends State<FlutterGauge> {


  PublishSubject<double> eventObservable = new PublishSubject();
//  animateHourHand(index,oldIndex){
//    if(widget.hand ==Hand.short || widget.animate == Animate.none){
//      eventObservable.add(index);
//    }else if(widget.animate == Animate.forget){
//      if(index + 10 < oldIndex || index - 10 > oldIndex){
//        if(oldIndex < index){
//          eventObservable.add(index+(widget.end/30));
//          Timer(Duration(milliseconds: 1100),(){
//            eventObservable.add(index-(widget.end/30));
//            Timer(Duration(milliseconds: 400),(){
//              eventObservable.add(index);
//            });
//          });
//        }else{
//          Timer(Duration(milliseconds: 1000),(){
//            eventObservable.add(index-3);
//            Timer(Duration(milliseconds: 700),(){
//              eventObservable.add(index+0.5);
//              Timer(Duration(milliseconds: 400),(){
//                eventObservable.add(index);
//              });
//            });
//          });
//        }
//      }
//    }else if(widget.animate == Animate.forget){
//      if(index + 10 < oldIndex || index - 10 > oldIndex){
//        if(oldIndex < index){
//          Timer(Duration(milliseconds: 1000),(){
//            eventObservable.add(index);
//            Timer(Duration(milliseconds: 700),(){
//              eventObservable.add(index-3);
//              Timer(Duration(milliseconds: 400),(){
//                eventObservable.add(index);
//                Timer(Duration(milliseconds: 400),(){
//                  eventObservable.add(index-2);
//                  Timer(Duration(milliseconds: 400),(){
//                    eventObservable.add(index);
//                  });
//                });
//              });
//            });
//          });
//        }else{
//          Timer(Duration(milliseconds: 1000),(){
//            eventObservable.add(index-3);
//            Timer(Duration(milliseconds: 700),(){
//              eventObservable.add(index+0.5);
//              Timer(Duration(milliseconds: 400),(){
//                eventObservable.add(index);
//              });
//            });
//          });
//        }
//      }
//    }else{
//      eventObservable.add(index);
//    }
//
//
//
//  }



  @override
  Widget build(BuildContext context) {
//    animateHourHand(widget.index,7.0);
    eventObservable.add(widget.index);
    return FlutterGaugeMain(
      isDecimal: widget.isDecimal,
      counterStyle: widget.counterStyle,
      textStyle: widget.textStyle,
      numberInAndOut: widget.numberInAndOut,
      paddingHand : widget.paddingHand,
      primaryColor : widget.primaryColor,
      accentColor : widget.accentColor,
      backgroundColor : widget.backgroundColor,
      indicatorColor : widget.indicatorColor ,
      shadowHand : widget.shadowHand,
      counterAlign : widget.counterAlign,
      number : widget.number,
      isCircle : widget.isCircle,
      hand : widget.hand,
      secondsMarker : widget.secondsMarker,
      handSize : widget.handSize,
      start : widget.start,
      end : widget.end,
      highlightStart : (widget.end/widget.end.toInt()),
      highlightEnd : (0/widget.end.toInt()),
      eventObservable : eventObservable,
      fontFamily : widget.fontFamily,
      widthCircle : widget.widthCircle > 30 ? 30 :widget.widthCircle,
      colorHourHand : widget.colorHourHand,
      inactiveColor : widget.inactiveColor,
      activeColor : widget.activeColor,
      width : (
          widget.width == null
              ?MediaQuery.of(context).size.width/2
              :widget.width < (MediaQuery.of(context).size.width/2)
              ?(MediaQuery.of(context).size.width/2)
              :(
              widget.width > (MediaQuery.of(context).size.width)
                  ?MediaQuery.of(context).size.width
                  :widget.width
          )
      )
    );
  }


}




