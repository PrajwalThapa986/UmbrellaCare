import 'dart:math';

import 'package:flutter/material.dart';

class ScreenUtils {
  // A constant representing the default screen size in dp
  static const Size defaultSize = Size(360, 690);

  //private constructor
  //This private constructor prevents other classes from instantiating, ensuring that only one instance of the singleton class exists.
  ScreenUtils._internal();

  //factory constructor to ensure that only a single instance of class is created.
  //in singleton class, a class instantiated by its factory constructor will always return the same instance.
  //factory constructors are used to add some logic before object creation.
  //they can either return an existing instance of class or new instance of class.
  //they can return the instance of same class or other class.
  //factory constructor can be used to instantiate a single instance of superclass whose object is modified by subclasses.
  factory ScreenUtils() => _instance;

  //This singleton class maintains a static instance of itself, which is the sole instance.
  //This single object represents the global access point to the instance across the entire application, akin to global variables.
  //This single instance is created using static final variable of the same class type
  static final ScreenUtils _instance = ScreenUtils._internal();

  // The size of the UI design in dp. This is initialized later.
  late Size _uiSize;

  //for holding media query data
  late MediaQueryData _mediaQueryData;

  //initialize screen utils class

  static void init(BuildContext context, {Size designSize = defaultSize}) {
    //! static methods
    //Static methods in Dart belong to the class itself rather than to instances of the class.
    //This means you can call a static method without creating an instance of the class.
    //However, static methods cannot directly access instance members (fields and methods) of the class because...
    // they do not operate on a specific instance.
    //access the instance members
    _instance._uiSize = designSize;
    _instance._mediaQueryData = MediaQuery.of(context);
  }

  //returns the horizontal width of screen
  double get screenWidth => _mediaQueryData.size.width;

  //return vertical height of screen
  double get screenHeight => _mediaQueryData.size.height;

  // The ratio of actual width to UI design
  double get scaleWidth => screenWidth / _uiSize.width;

  //return the ration of screen height to ui height
  double get scaleHeight => screenHeight / _uiSize.height;

  //return scaling factor for text (width based)
  double get scaleText => scaleWidth;

  // this translates the width to the width of the ui design.
  //hence this methods returns the width of the screen in respect to the ui width so that the ui elements usually appear unchanged..
  //i.e they appear as they are in te ui design

  //this method gets the width in pixel size and then returns the respective width of screen relative to the ui design
  double setWidth(num width) => min(width.toDouble(), width * scaleWidth);

  //same for height
  double setHeight(num height) => min(height.toDouble(), height * scaleHeight);

  //font size adaptation method
  double setFontSize(num fontSize) =>
      min(fontSize.toDouble(), fontSize * scaleText);
}
