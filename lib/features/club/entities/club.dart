import '../../../app/constants.dart';
import 'club_team.dart';

class Club {
  final String id;
  final String title;
  final String description;
  final String coverImgUrl;
  final int membersCount;
  final ClubTeam team;
  final bool closed;
  final DateTime createdAt;

  const Club({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImgUrl,
    required this.membersCount,
    required this.team,
    required this.closed,
    required this.createdAt,
  });

  Club.empty()
      : id = '',
        title = '',
        description = '',
        coverImgUrl = AppConstants.coverImages.first,
        membersCount = 0,
        team = const ClubTeam.empty(),
        closed = true,
        createdAt = DateTime.now();

  Club copyWith({
    String? id,
    String? title,
    String? description,
    String? coverImgUrl,
    int? membersCount,
    ClubTeam? team,
    bool? closed,
    DateTime? createdAt,
  }) {
    return Club(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImgUrl: coverImgUrl ?? this.coverImgUrl,
      membersCount: membersCount ?? this.membersCount,
      team: team ?? this.team,
      closed: closed ?? this.closed,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
