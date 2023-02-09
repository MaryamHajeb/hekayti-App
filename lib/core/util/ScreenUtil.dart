import 'dart:core';

import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = ScreenUtil();

  int width;
  int height;
  bool allowFontScaling;

    late MediaQueryData _mediaQueryData;
    late double _screenWidth;
    late double _screenHeight;
    late double _screenHeightNoPadding;
    late double _pixelRatio;
    late double _statusBarHeight;
    late double _bottomBarHeight;
    late double _textScaleFactor;
    late Orientation _orientation;

  ScreenUtil({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = mediaQuery.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
    _orientation = mediaQuery.orientation;
    _screenHeightNoPadding =
        mediaQuery.size.height - _statusBarHeight - _bottomBarHeight;
  }

   MediaQueryData get mediaQueryData => _mediaQueryData;

   double get textScaleFactory => _textScaleFactor;

   double get pixelRatio => _pixelRatio;

   Orientation get orientation => _orientation;

   double get screenWidth => _screenWidth;

   double get screenHeight => _screenHeight;

   double get screenWidthPx => _screenWidth * _pixelRatio;

   double get screenHeightPx => _screenHeight * _pixelRatio;

   double get screenHeightNoPadding => _screenHeightNoPadding;

   double get statusBarHeight => _statusBarHeight * _pixelRatio;

   double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  setWidth(int width) => width * scaleWidth;

  setHeight(int height) => height * scaleHeight;

  setSp(int fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;



}
