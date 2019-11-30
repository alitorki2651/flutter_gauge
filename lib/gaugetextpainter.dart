import 'dart:math';
import 'package:flutter/material.dart';

class GaugeTextPainter extends CustomPainter {
  final hourTickMarkLength = 30.0;
  final minuteTickMarkLength = 0.0;

  final hourTickMarkWidth = 1.5;
  final minuteTickMarkWidth = 1.0;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  int end;
  int start;
  double value;
  String fontFamily;
  Color color;

  GaugeTextPainter({this.start, this.end, this.value,this.fontFamily,this.textStyle,@required this.color})
      : tickPaint = new Paint(),
        textPainter = new TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ){
    tickPaint.color = Colors.red;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = ((2/3) * 2) * pi / end;
    final radius = size.width / 2;
    canvas.save();

    // drawing
    canvas.translate(radius, radius);
    canvas.rotate(-2.1);
    for (var i = 0; i <= end; i++) {
      //make the length and stroke of the tick marker longer and thicker depending
      tickMarkLength = i % 5 == 0
          ? hourTickMarkLength
          : minuteTickMarkLength;
      tickPaint.strokeWidth = i % 5 == 0
          ? hourTickMarkWidth
          : minuteTickMarkWidth;

      if(value.toInt() == i){
        tickPaint.color = Colors.black;

      }

      if(i != 0 && i != end){ //(end / 1.5).toInt() > i && i != 0
        canvas.drawLine(new Offset(0.0, -radius - 25), new Offset(0.0, -radius - 15 + tickMarkLength), tickPaint);
      }

      //draw the text
      if (i % (end < 100 ?5 :10) == 0 || i == end) {
//                String label = i == 40 ? start.toString() : this.end.toString();
        String label = i.toString();
        canvas.save();
        canvas.translate(i == 40 ? -0.0 : 0.0, -radius + 40.0);
        textPainter.text = new TextSpan(
          text: label,
          style: textStyle,
        );

        //helps make the text painted vertically
        canvas.rotate(-angle * i);

        textPainter.layout();

//                if((i >= 0 && i <= (end / 3) * 2)){
        textPainter.paint(canvas, new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
//                }

        canvas.restore();
      }


      /*  if (i == end/2) {
                String label = this.value.toStringAsFixed(1);
                canvas.save();
                canvas.translate(0.0, -radius + 50.0);

                textPainter.text = new TextSpan(
                    text: label,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                      fontFamily: fontFamily
                    ),
                );
                canvas.rotate(-angle * i);

                textPainter.layout();



                textPainter.paint(canvas, new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

                canvas.restore();
            }*/

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(GaugeTextPainter oldDelegate) {
    return false;
  }
}










///counter text bottom
class GaugeTextCounter extends CustomPainter {
  final hourTickMarkLength = 30.0;
  final minuteTickMarkLength = 0.0;

  final hourTickMarkWidth = 1.5;
  final minuteTickMarkWidth = 1.0;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  int end;
  int start;
  double value;
  String fontFamily;
  Color color;

  GaugeTextCounter({this.start, this.end, this.value,this.fontFamily,this.textStyle,@required this.color})
      : tickPaint = new Paint(),
        textPainter = new TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ){
    tickPaint.color = color;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();
    canvas.translate(radius, radius);
    for (var i = 0; i <= 60; i++) {

      if (i == 30) {
        String label = this.value.toStringAsFixed(1);
        canvas.save();
        canvas.translate(0.0, -radius + 50.0);

        textPainter.text = new TextSpan(
          text: label,
          style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontFamily: fontFamily
          ),
        );
        canvas.rotate(-angle * i);

        textPainter.layout();



        textPainter.paint(canvas, new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

        canvas.restore();
      }

      canvas.rotate(angle);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(GaugeTextCounter oldDelegate) {
    return false;
  }
}











