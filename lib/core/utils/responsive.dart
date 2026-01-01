import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  late double _width;
  late double _height;

  Responsive(this.context) {
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
  }

  double w(double value) => (_width / 375) * value;

  double h(double value) => (_height / 812) * value;

  double sp(double value) => value * (_width / 375);

  bool get isTablet => _width >= 600;
}
