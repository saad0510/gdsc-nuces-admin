import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/club.dart';
import '../repositories/club_repo.dart';

final clubsProvider = StreamProvider<List<Club>>(
  (ref) => ref.watch(clubRepoProvider).clubsStream(),
);

final openedClubsProvider = Provider<AsyncValue<List<Club>>>(
  (ref) {
    final clubs = ref.watch(clubsProvider);
    return clubs.map(
      data: (clubs) {
        final allClubs = clubs.valueOrNull ?? const [];
        final openedCLubs = allClubs.where((c) => !c.closed);
        return AsyncData(openedCLubs.toList());
      },
      error: (error) => error,
      loading: (loading) => loading,
    );
  },
);

final closedClubsProvider = Provider<AsyncValue<List<Club>>>(
  (ref) {
    final clubs = ref.watch(clubsProvider);
    return clubs.map(
      data: (clubs) {
        final allClubs = clubs.valueOrNull ?? const [];
        final closedCLubs = allClubs.where((c) => c.closed);
        return AsyncData(closedCLubs.toList());
      },
      error: (error) => error,
      loading: (loading) => loading,
    );
  },
);
