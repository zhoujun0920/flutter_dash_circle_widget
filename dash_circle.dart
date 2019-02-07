import 'package:flutter/material.dart';
import 'dart:math';

class DashCircle extends StatefulWidget {
  final EdgeInsets padding;
  final Color lineColor;
  final Color dashColor;
  final double radius;
  final double percentage;
  final double width;
  final ImageProvider image;
  final EdgeInsets imageMargin;

  DashCircle(
      {Key key,
      this.padding,
      this.lineColor,
      this.dashColor,
      this.radius,
      this.percentage,
      this.width,
      this.image,
      this.imageMargin})
      : super(key: key);

  @override
  State createState() => DashCircleState();
}

class DashCircleState extends State<DashCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding,
        width: widget.radius,
        height: widget.radius,
        child: CustomPaint(
          foregroundPainter: MyPainter(
              lineColor: widget.lineColor,
              dashColor: widget.dashColor,
              percentage: widget.percentage,
              width: widget.width),
          child: Container(
              margin: widget.imageMargin,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(fit: BoxFit.contain, image: widget.image))),
        ));
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  Color dashColor;
  double percentage;
  double width;

  MyPainter({this.lineColor, this.dashColor, this.percentage, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = dashColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (percentage / 100);
    for (var i = 0; i < 100.0 / percentage; i += 2) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          -pi / 2 + i * arcAngle, arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
