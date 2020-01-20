import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gauge/flutter_gauge.dart';

class HandPainter extends CustomPainter {
  final Paint minuteHandPaint;
  double value;
  int start;
  int end;
  Color color;
  double handSize;
  Hand hand;
  double shadowHand;

  HandPainter(
      {this.shadowHand,
      this.hand,
      this.value,
      this.start,
      this.end,
      this.color,
      this.handSize})
      : minuteHandPaint = new Paint() {
    minuteHandPaint.color = this.color;
    minuteHandPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
//      for(int i = 0;i == 2; i++){
    var radius = size.width / 2;
    double gamma = ((2 / 3) * this.end);

    double downSizedValue =
        ((value <= (this.end / 2)) ? value : value - (this.end / 2)) *
            (gamma / this.end);
    double realValue =
        (((value <= (this.end / 2)) ? downSizedValue + gamma : downSizedValue) %
            this.end);

    canvas.save();

    canvas.translate(radius, radius);

    canvas.rotate(2 * pi * ((realValue) / this.end));

    Path path = new Path();
    if (hand == Hand.short) {
      path.moveTo(-1.0, -radius - handSize / 8.0);
      path.lineTo(-5.0, -radius / 1.8);
      path.lineTo(5.0, -radius / 1.8);
      path.lineTo(1.0, -radius - handSize / 8);
    } else {
      path.moveTo(-1.5, -radius - handSize / 3.0);
      path.lineTo(-5.0, -radius / 1.8);
      path.lineTo(-handSize / 3, handSize / 5);

      /// change 2 => 5
      path.lineTo(handSize / 3, handSize / 5);

      /// change 2 => 5
      path.lineTo(5.0, -radius / 1.8);
      path.lineTo(1.5, -radius - handSize / 3);
    }

    path.close();

    canvas.drawPath(path, minuteHandPaint);
    canvas.drawShadow(path, this.color, shadowHand, false);

    canvas.restore();
  }

//    }

  @override
  bool shouldRepaint(HandPainter oldDelegate) {
    return true;
  }
}
