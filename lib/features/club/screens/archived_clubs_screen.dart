import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/sizer.dart';
import '../../../core/extensions/context_ext.dart';
import '../controllers/clubs_provider.dart';
import '../widgets/club_tile.dart';
import 'club_detail_screen.dart';

class ArchivedClubsScreen extends ConsumerWidget {
  const ArchivedClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubs = ref.watch(closedClubsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Archived Clubs'),
      ),
      body: ListView.separated(
        padding: AppPaddings.normal,
        itemCount: clubs.length,
        separatorBuilder: (_, i) => AppSizes.mediumY,
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
    );
  }
}
