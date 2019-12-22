import 'package:flutter/material.dart';
import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';


class MyPainter extends CustomPainter {
  ScreenInfo _info;
  MyPainter(this._info);
  @override
  void paint(Canvas canvas, Size size) {
    var c = Offset(-40, _info.getHeight * 0.7);
    final radius = _info.getHeight * 0.3;
    Paint paint = Paint()
      ..color = reuse.getBGColor()
      ..style = PaintingStyle.fill;
    canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
