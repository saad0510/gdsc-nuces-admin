import 'package:flutter/material.dart';

import '../../../app/assets.dart';
import '../../../app/constants.dart';
import '../../../app/routes.dart';
import '../../../app/sizer.dart';
import '../../../core/extensions/context_ext.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Image.asset(
                  AppImages.appLogo,
                  width: 100.w,
                ),
                AppSizes.largeY,
                Text(
                  AppConstants.appTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => context.push(AppRoutes.archivedClubs),
            contentPadding: AppPaddings.normal,
            style: ListTileStyle.list,
            title: const Text('Archived Clubs'),
            trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
          ),
        ],
      ),
    );
  }
}
