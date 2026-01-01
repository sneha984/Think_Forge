import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:technical_test/core/constants/image_constants.dart';

import '../../core/utils/responsive.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  const BottomNav({super.key, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: r.w(20),
        vertical: r.h(15).clamp(15.0, 25.0),
      ),
      color: Colors.transparent,
      child: Container(
        height: r.h(70).clamp(70.0, 85.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(r.w(25).clamp(25.0, 40.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _item(context, r, ImageConstants.home, "Home", 0, "/dashboard"),
            _item(context, r, ImageConstants.wallet, "Wallet", 1, "/wallet"),
            _item(context, r, ImageConstants.support, "Support", 2, "/support"),
            _item(context, r, ImageConstants.ib, "IB", 3, "/ib"),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    Responsive r,
    String assetPath,
    String label,
    int index,
    String route,
  ) {
    final active = currentIndex == index;
    final color = active ? const Color(0xFF2D3142) : const Color(0xFF9E9E9E);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.go(route),
      child: SizedBox(
        width: r.w(70).clamp(60.0, 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetPath,
              width: r.w(24).clamp(24.0, 32.0),
              height: r.w(24).clamp(24.0, 32.0),
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(height: r.h(5)),
            Text(
              label,
              style: TextStyle(
                fontSize: r.sp(11).clamp(11.0, 15.0),
                color: color,
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
