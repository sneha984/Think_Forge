import 'package:flutter/material.dart';
import 'package:technical_test/shared/widgets/common_layout.dart';

import '../../../core/utils/responsive.dart';

class IBScreen extends StatelessWidget {
  final Responsive r;

  const IBScreen({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(currentIndex: 3, child: Container());
  }
}
