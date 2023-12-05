import '../../../core/extensions/text_ext.dart';

enum ClubLevels {
  member,
  colead,
  lead;

  @override
  String toString() => name.capitalize();

  String toMap() => name;

  factory ClubLevels.fromMap(dynamic data) {
    final name = data as String;
    return values.byName(name);
  }
}
