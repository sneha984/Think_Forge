import 'package:flutter/material.dart';

import '../utils/responsive.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle title(BuildContext context) {
    final r = Responsive(context);
    return TextStyle(
      fontSize: r.sp(20),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle body(BuildContext context) {
    final r = Responsive(context);
    return TextStyle(fontSize: r.sp(14), color: AppColors.textSecondary);
  }
}
