import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/clubs_provider.dart';
import '../widgets/clubs_list_view.dart';

class ArchivedClubsScreen extends ConsumerWidget {
  const ArchivedClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archived Clubs'),
      ),
      body: ClubsListView(
        clubs: ref.watch(closedClubsProvider),
      ),
    );
  }
}
