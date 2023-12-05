import 'package:flutter/material.dart';

import '../../../app/sizer.dart';
import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_ext.dart';
import '../entities/club.dart';
import '../widgets/club_team_card.dart';
import '../widgets/club_tile.dart';
import '../widgets/delete_club_dialog.dart';
import '../widgets/event_list_view.dart';
import 'add_club_screen.dart';

class ClubDetailScreen extends StatelessWidget {
  const ClubDetailScreen({super.key, required this.club});

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        padding: AppPaddings.normal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClubTile(club: club),
            AppSizes.mediumY,
            Text(club.description),
            AppSizes.mediumY,
            ClubTeamCard(club: club),
            AppSizes.mediumY,
            const Divider(),
            AppSizes.mediumY,
            EventListView(clubId: club.id),
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
