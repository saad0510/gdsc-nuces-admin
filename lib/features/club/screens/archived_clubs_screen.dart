import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/sizer.dart';
import '../../../core/extensions/context_ext.dart';
import '../controllers/clubs_provider.dart';
import '../widgets/club_tile.dart';
import '../widgets/info_message.dart';
import 'club_detail_screen.dart';

class ArchivedClubsScreen extends ConsumerWidget {
  const ArchivedClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubsAsync = ref.watch(closedClubsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Archived Clubs'),
      ),
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
    );
  }
}
