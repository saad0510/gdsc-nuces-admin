import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.message,
    this.show = true,
    this.location = BannerLocation.topEnd,
    required this.child,
  });

  final String message;
  final bool show;
  final Widget child;
  final BannerLocation location;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: show
          ? Banner(
              message: message,
              location: location,
              color: AppColors.red,
              child: child,
            )
          : child,
    );
  }
}
