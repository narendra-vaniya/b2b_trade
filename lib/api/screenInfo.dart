import 'package:flutter/widgets.dart';

class ScreenInfo{

 
  BuildContext _context;

  //Con
  ScreenInfo(this._context);
  
  //Getter
  double get getHeight => MediaQuery.of(_context).size.height;
  double get getWidth => MediaQuery.of(_context).size.width;

  //Setter

}