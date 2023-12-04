import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/constants.dart';
import 'app/routes.dart';
import 'app/sizer.dart';
import 'app/theme/theme.dart';
import 'core/utils/app_logger.dart';

void main() async {
  await AppSizer.ensureScreenSize();
  runApp(const GdscAdminApp());
}

class GdscAdminApp extends StatelessWidget {
  const GdscAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [AppLogger()],
      child: Consumer(
        builder: (context, ref, _) {
          final brightness = ref.watch(themeModeProvider);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appTitle,
            theme: AppTheme().withBrightness(brightness),
            initialRoute: AppRoutes.initial.name,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
