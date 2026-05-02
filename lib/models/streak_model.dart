class StreakModel {
  int currentStreak;
  int longestStreak;
  DateTime? lastCheckIn;

  StreakModel({
    required this.currentStreak,
    required this.longestStreak,
    this.lastCheckIn,
  });
}
