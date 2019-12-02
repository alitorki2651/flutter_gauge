# FlutterGauge

A little widget that given an Observable gives you an updated FlutterGauge.

![](https://github.com/alitorki2651/flutter_gauge.git?raw=true&s=200)


---
## Getting Started

You should ensure that you add the following dependency in your Flutter project.
```yaml
dependencies:
 flutter_gauge: "^1.0.1"
```

You should then run `flutter packages upgrade` or update your packages in IntelliJ.

In your Dart code, to use it:
```dart
import 'package:flutter_gauge/fluttergauge.dart';
```




---
## Example

An example can be found in the `example` folder.  Check it out.

```dart

import 'package:flutter/material.dart';
import 'package:flutter_gauge/fluttergauge.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gauge',
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
  double count = 99;
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

  PublishSubject<double> eventObservable = new PublishSubject();

  @override
  Widget build(BuildContext context) {
    animateHourHand(50.0,7.0);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(color:Colors.black12,child: FlutterGaugeExample(count: count,padding: EdgeInsets.all(30),eventObservable: eventObservable,)),
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
    final ThemeData somTheme = new ThemeData(
      primaryColor: Colors.cyan,
      accentColor: Colors.black,
      backgroundColor: Colors.cyan,
      indicatorColor: Colors.black,
    );
    return  Padding(
      padding: widget.padding == null ?EdgeInsets.all(0) :widget.padding,
      child: new FlutterGauge(start:0, end: (widget.count).toInt(), highlightStart:(widget.count/widget.count.toInt()), highlightEnd:(0/widget.count.toInt()), themeData:somTheme, eventObservable: widget.eventObservable,fontFamily: "Iran",width: 20,colorHourHand: Colors.black,),
    );
  }


}






```

