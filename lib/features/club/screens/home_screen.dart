import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/routes.dart';
import '../../../app/theme/colors.dart';
import '../../../core/extensions/context_ext.dart';
import '../controllers/clubs_provider.dart';
import '../widgets/clubs_list_view.dart';
import '../widgets/home_app_bar.dart';
import 'home_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const HomeAppBar(),
      endDrawer: const HomeDrawer(),
      body: ClubsListView(
        clubs: ref.watch(openedClubsProvider),
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
