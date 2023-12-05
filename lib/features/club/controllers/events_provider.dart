import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/constants.dart';
import '../entities/event.dart';

const _names = [
  'Intro to Programming',
  'Git / Github Workshop',
  'Cyber Security in Pakistan',
];
const _description =
    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptatibus, sequi suscipit quisquam quos, quidem laboriosam alias earum, quas atque eius architecto. Rem aut distinctio repellat, vero molestias dolore sit laborum.';
const _point = 'Lorem ipsum dolor sit amet consectetur';

final eventsProvider = FutureProvider.autoDispose.family<List<Event>, String>(
  (ref, clubId) async {
    await Future.delayed(const Duration(seconds: 1));

    final now = DateTime.now();
    final seed = now.microsecondsSinceEpoch;
    final random = Random(seed);
    final images = AppConstants.coverImages.toList();

    return List.generate(
      random.nextInt(5),
      (i) {
        final start = now.add(Duration(days: random.nextInt(10)));
        final end = start.add(Duration(hours: random.nextInt(3)));

        return Event(
          id: 'event_$i',
          clubId: 'e_club_$i',
          title: _names[i % 3],
          description: _description,
          venue: 'Lab 11, EE Building',
          startAt: start,
          endAt: end,
          coverImgUrl: images[i % 9],
          createdAt: now,
          summary: List.filled(random.nextInt(3) + 2, _point),
          registeredUids: List.generate(
            random.nextInt(20),
            (i) => 'user_${random.nextInt(20)}',
          ),
          attendedUids: List.generate(
            random.nextInt(20),
            (i) => 'user_${random.nextInt(20)}',
          ),
        );
      },
    );
  },
);
