import 'package:flutter/material.dart';

class ReuseWidget {
  //Background Color
  Color getBGColor() {
    return Colors.blue.shade700;
  }

  TextStyle getTextStyle() {
    return TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans');
  }

  


  TextStyle getPlaceholderStyle() {
    return TextStyle(color: Colors.black45, fontFamily: 'OpenSans');
  }

  TextStyle getTextStyle2() {
    return TextStyle(
        color: Colors.black45,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold);
  }

  InputDecoration getInputPostDecoration(hintname) {
    return InputDecoration(
      hintText: hintname,
      hintStyle: reuse.getPlaceholderStyle(),
    );
  }
}

ReuseWidget reuse = ReuseWidget();
