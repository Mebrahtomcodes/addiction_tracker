import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String currentKey = "current_streak";
  static const String longestKey = "longest_streak";
  static const String seedKey = "motivation_seed";

  Future<void> saveStreak(int current, int longest) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(currentKey, current);
    await prefs.setInt(longestKey, longest);
  }

  Future<void> saveSeed(int seed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(seedKey, seed);
  }

  Future<Map<String, int>> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "current": prefs.getInt(currentKey) ?? 0,
      "longest": prefs.getInt(longestKey) ?? 0,
      "seed": prefs.getInt(seedKey) ?? 0,
    };
  }
}
