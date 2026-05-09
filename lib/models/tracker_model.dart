import 'dart:convert';

class TrackerModel {
  String id;
  String title;
  int currentStreak;
  int longestStreak;
  DateTime? lastUpdateDate;
  DateTime? lastCheckIn;
  int motivationSeed;
  bool notificationsEnabled;

  TrackerModel({
    required this.id,
    required this.title,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastUpdateDate,
    this.lastCheckIn,
    this.motivationSeed = 0,
    this.notificationsEnabled = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
      'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      'lastCheckIn': lastCheckIn?.toIso8601String(),
      'motivationSeed': motivationSeed,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  factory TrackerModel.fromMap(Map<String, dynamic> map) {
    return TrackerModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      currentStreak: map['currentStreak']?.toInt() ?? 0,
      longestStreak: map['longestStreak']?.toInt() ?? 0,
      lastUpdateDate: map['lastUpdateDate'] != null ? DateTime.parse(map['lastUpdateDate']) : null,
      lastCheckIn: map['lastCheckIn'] != null ? DateTime.parse(map['lastCheckIn']) : null,
      motivationSeed: map['motivationSeed']?.toInt() ?? 0,
      notificationsEnabled: map['notificationsEnabled'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrackerModel.fromJson(String source) => TrackerModel.fromMap(json.decode(source));
}
