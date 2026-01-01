import 'package:flutter/material.dart';
import 'package:technical_test/shared/widgets/common_layout.dart';

import '../../../core/utils/responsive.dart';

class SupportScreen extends StatelessWidget {
  final Responsive r;

  const SupportScreen({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(currentIndex: 2, child: Container());
  }
}
