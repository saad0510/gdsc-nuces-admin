import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routes.dart';
import '../../../app/sizer.dart';
import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_ext.dart';
import '../controllers/clubs_provider.dart';
import '../widgets/club_tile.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/info_message.dart';
import 'club_detail_screen.dart';
import 'home_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubsAsync = ref.watch(openedClubsProvider);

    return Scaffold(
      appBar: const HomeAppBar(),
      endDrawer: const HomeDrawer(),
      body: Builder(
        builder: (context) {
          if (clubsAsync.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (clubsAsync.hasError) {
            return Center(
              child: InfoMessage.error(
                title: 'An error occured',
                description: clubsAsync.error!.toString(),
              ),
            );
          }

          final clubs = clubsAsync.valueOrNull ?? const [];
          if (clubs.isEmpty)
            return const Center(
              child: InfoMessage.empty(
                title: 'No clubs found',
                description: 'Click the add button to create and see clubs here',
              ),
            );

          return ListView.separated(
            padding: AppPaddings.normal,
            itemCount: clubs.length,
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
          );
        },
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
