import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/sizer.dart';
import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_ext.dart';
import '../entities/club.dart';
import '../repositories/club_repo.dart';

class DeleteClubForm extends ConsumerWidget {
  const DeleteClubForm({
    super.key,
    required this.club,
  });

  final Club club;

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      insetPadding: AppPaddings.normal,
      titlePadding: AppPaddings.normal,
      contentPadding: AppPaddings.normal,
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      title: const Text(
        'Are you sure you want to\ndelete this club?',
        textAlign: TextAlign.center,
      ),
      children: [
        ElevatedButton(
          onPressed: () {
            context.showLoadingUntil(
              ref.read(clubRepoProvider).deleteClub(club),
              then: (_) {
                context.pop();
                context.pop();
              },
            );
          },
          child: const Text('Delete Forever'),
        ),
        AppSizes.smallY,
        ElevatedButton(
          onPressed: () {
            context.pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.green),
          child: const Text('Nope'),
        ),
      ],
    );
  }
}
