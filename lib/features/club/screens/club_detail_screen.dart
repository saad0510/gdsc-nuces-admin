import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/sizer.dart';
import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_ext.dart';
import '../controllers/events_provider.dart';
import '../entities/club.dart';
import '../widgets/banner_widget.dart';
import '../widgets/club_team_card.dart';
import '../widgets/club_tile.dart';
import '../widgets/delete_club_dialog.dart';
import '../widgets/event_list_view.dart';
import 'add_club_screen.dart';

class ClubDetailScreen extends ConsumerWidget {
  const ClubDetailScreen({super.key, required this.club});

  final Club club;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        padding: AppPaddings.normal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BannerWidget(
              message: 'Archived',
              show: club.closed,
              child: ClubTile(club: club),
            ),
            AppSizes.mediumY,
            Text(club.description),
            AppSizes.mediumY,
            ClubTeamCard(club: club),
            AppSizes.mediumY,
            const Divider(),
            AppSizes.mediumY,
            EventListView(
              title: 'Club Events',
              events: ref.watch(approvedEventsProvider(club.id)),
            ),
            AppSizes.mediumY,
            const Divider(),
            AppSizes.mediumY,
            EventListView(
              title: 'Pending Events',
              events: ref.watch(pendingEventsProvider(club.id)),
            ),
          ],
        ),
      ),
      bottomSheet: const Divider(height: 0),
      bottomNavigationBar: Padding(
        padding: AppPaddings.normal,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                DeleteClubForm(club: club).show(context);
              },
              child: const Text('Delete'),
            ),
            AppSizes.smallY,
            ElevatedButton(
              onPressed: () {
                context.pushTo(
                  AddClubScreen(club: club),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
