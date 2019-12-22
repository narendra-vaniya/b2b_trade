/*
 * This page is Login Page for both user and admin
 *  Body LoginForm()
 * App bar and Canvas
*/

import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/widgets/loginForm.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
    
  @override
  Widget build(BuildContext context) {
    final _screen = ScreenInfo(context);
    return Scaffold(
      body: CustomPaint(
        painter: MyPaint(_screen),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: _screen.getWidth * 0.25,
                  padding: EdgeInsets.all(10),
                  child: FittedBox(
                    child: Text(
                      "Login",
                      style: reuse.getTextStyle(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: LoginForm(),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}


//!Custom Painter

class MyPaint extends CustomPainter {
  ScreenInfo _screen;
  MyPaint(this._screen);
  @override
  void paint(Canvas canvas, Size size) {
    //! Offset
    var c1 = Offset(_screen.getWidth, _screen.getHeight * 0.19);
    var c2 = Offset(_screen.getWidth * 0.7, _screen.getHeight * 0.19);
    var c3 = Offset(0, _screen.getHeight * 0.9);
    var c4 = Offset(_screen.getWidth * 0.3, _screen.getHeight * 0.89);

    //!Radius
    final radius1 = _screen.getWidth * 0.2;
    final radius2 = _screen.getWidth * 0.055;

    //!Paint
    Paint paint1 = Paint()
      ..color = reuse.getBGColor()
      ..style = PaintingStyle.fill;

    canvas.drawCircle(c1, radius1, paint1);
    canvas.drawCircle(c2, radius2, paint1);
    canvas.drawCircle(c3, radius1, paint1);
    canvas.drawCircle(c4, radius2, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
