import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routes.dart';
import '../../../app/sizer.dart';
import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_ext.dart';
import '../controllers/clubs_provider.dart';
import '../widgets/club_tile.dart';
import '../widgets/home_app_bar.dart';
import 'club_detail_screen.dart';
import 'home_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubs = ref.watch(openedClubsProvider);

    return Scaffold(
      appBar: const HomeAppBar(),
      endDrawer: const HomeDrawer(),
      body: SingleChildScrollView(
        padding: AppPaddings.normal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, i) => AppSizes.smallY,
              itemBuilder: (_, i) {
                return ClubTile(
                  club: clubs[i],
                  onPressed: () {
                    context.pushTo(
                      ClubDetailScreen(club: clubs[i]),
                    );
                  },
                );
              },
            ),
            AppSizes.largeY,
            AppSizes.largeY,
            AppSizes.largeY,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Club',
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        onPressed: () => context.push(AppRoutes.addClub),
        child: const Icon(Icons.add),
      ),
    );
  }
}
