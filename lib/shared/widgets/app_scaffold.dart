import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'bottom_nav.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final int index;

  const AppScaffold({super.key, required this.body, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,

      body: body,
      bottomNavigationBar: BottomNav(currentIndex: index),
    );
  }
}
