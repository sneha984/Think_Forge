import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/image_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import './app_scaffold.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const CommonLayout({super.key, required this.child, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    return SafeArea(
      child: AppScaffold(
        index: currentIndex,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: r.w(14),
                vertical: r.h(20),
              ),
              child: Row(
                children: [
                  _avatar(r),
                  const Spacer(),
                  SvgPicture.asset(ImageConstants.appLogo, width: r.w(42)),
                  const Spacer(),
                  _notificationIcon(r),
                ],
              ),
            ),

            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  Widget _avatar(Responsive r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.w(8)),
      child: CachedNetworkImage(
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjcoePJ2H1IVmvBB0s_BSRJ8HTDKWpVO-lZA&s",
        width: r.w(36),
        height: r.w(36),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _notificationIcon(Responsive r) {
    return Container(
      padding: EdgeInsets.all(r.w(9)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(r.w(8)),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(Icons.notifications_none, size: r.w(20), color: Colors.white),
    );
  }
}
