import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/providers.dart';
import '../entities/club.dart';

class ClubRepo {
  final FirebaseFirestore firestore;

  ClubRepo({
    required this.firestore,
  });

  late final clubsCollection = firestore
      .collection('clubs') //
      .withConverter(
        fromFirestore: (doc, _) => Club.fromMap(doc.data()!),
        toFirestore: (club, _) => club.toMap(),
      );

  Stream<List<Club>> clubsStream() {
    return clubsCollection.snapshots().map(
      (event) {
        return event.docs
            .map((doc) => doc.data()) //
            .toList();
      },
    );
  }

  Future<void> addClub(Club club) async {
    final doc = clubsCollection.doc();
    club = club.copyWith(id: doc.id);
    await doc.set(club);
  }

  Future<void> updateClub(Club club) async {
    await clubsCollection.doc(club.id).set(club);
  }

  Future<void> deleteClub(Club club) async {
    await clubsCollection.doc(club.id).delete();
  }
}

final clubRepoProvider = Provider(
  (ref) => ClubRepo(
    firestore: ref.read(firestoreProvider),
  ),
);
