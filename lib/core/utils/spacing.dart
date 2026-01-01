import 'package:flutter/material.dart';

import 'responsive.dart';

class Spacing {
  static EdgeInsets all(BuildContext context, double value) {
    final r = Responsive(context);
    return EdgeInsets.all(r.w(value));
  }

  static EdgeInsets horizontal(BuildContext context, double value) {
    final r = Responsive(context);
    return EdgeInsets.symmetric(horizontal: r.w(value));
  }

  static EdgeInsets vertical(BuildContext context, double value) {
    final r = Responsive(context);
    return EdgeInsets.symmetric(vertical: r.h(value));
  }
}
