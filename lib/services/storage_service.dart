import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tracker_model.dart';
import '../models/journal_model.dart';
import '../models/notification_settings_model.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class StorageService {
  static const String trackersKey = "all_trackers";
  static const String journalKey = "all_journal_entries";
  static const String notificationSettingsKey = "notification_settings";
  static const String colorKey = "theme_seed_color";
  
  // Old keys for migration
  static const String currentKey = "current_streak";
  static const String longestKey = "longest_streak";
  static const String seedKey = "motivation_seed";
  static const String lastUpdateKey = "last_update_date";
  static const String lastCheckInKey = "last_check_in";
  static const String startDateKey = "start_date";
  static const String themeKey = "is_dark_mode";

  Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkMode);
  }

  Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeKey) ?? true; // Default to dark mode
  }

  Future<void> saveTrackers(List<TrackerModel> trackers) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      trackers.map((tracker) => tracker.toMap()).toList(),
    );
    await prefs.setString(trackersKey, encodedData);
  }

  Future<List<TrackerModel>> loadTrackers() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Check if we have old data to migrate
    if (!prefs.containsKey(trackersKey) && prefs.containsKey(currentKey)) {
      return await _migrateOldData(prefs);
    }

    final String? trackersString = prefs.getString(trackersKey);
    if (trackersString == null || trackersString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decodedData = json.decode(trackersString);
      return decodedData.map((item) => TrackerModel.fromMap(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<TrackerModel>> _migrateOldData(SharedPreferences prefs) async {
    int current = prefs.getInt(currentKey) ?? 0;
    int longest = prefs.getInt(longestKey) ?? 0;
    int seed = prefs.getInt(seedKey) ?? Random().nextInt(10000);
    String? lastUpdateStr = prefs.getString(lastUpdateKey) ?? prefs.getString(startDateKey);
    String? lastCheckInStr = prefs.getString(lastCheckInKey);

    DateTime? lastUpdateDate;
    if (lastUpdateStr != null) {
      lastUpdateDate = DateTime.parse(lastUpdateStr);
    } else if (current == 0) {
      lastUpdateDate = DateTime.now();
    }

    DateTime? lastCheckIn;
    if (lastCheckInStr != null) {
      lastCheckIn = DateTime.parse(lastCheckInStr);
    }

    TrackerModel defaultTracker = TrackerModel(
      id: const Uuid().v4(),
      title: 'Default Tracker',
      currentStreak: current,
      longestStreak: longest,
      lastUpdateDate: lastUpdateDate,
      lastCheckIn: lastCheckIn,
      motivationSeed: seed,
    );

    List<TrackerModel> trackers = [defaultTracker];
    await saveTrackers(trackers);
    
    // Cleanup old keys
    await prefs.remove(currentKey);
    await prefs.remove(longestKey);
    await prefs.remove(seedKey);
    await prefs.remove(lastUpdateKey);
    await prefs.remove(lastCheckInKey);
    await prefs.remove(startDateKey);

    return trackers;
  }

  Future<void> saveJournalEntries(List<JournalModel> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
      entries.map((entry) => entry.toJson()).toList(),
    );
    await prefs.setString(journalKey, encodedData);
  }

  Future<List<JournalModel>> loadJournalEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? journalString = prefs.getString(journalKey);
    if (journalString == null || journalString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decodedData = json.decode(journalString);
      return decodedData.map((item) => JournalModel.fromJson(item)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveNotificationSettings(NotificationSettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(notificationSettingsKey, json.encode(settings.toJson()));
  }

  Future<NotificationSettingsModel> loadNotificationSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? settingsString = prefs.getString(notificationSettingsKey);
    if (settingsString == null) {
      return NotificationSettingsModel();
    }
    return NotificationSettingsModel.fromJson(json.decode(settingsString));
  }

  Future<void> saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(colorKey, color.value);
  }

  Future<Color> getThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final int? colorValue = prefs.getInt(colorKey);
    if (colorValue == null) {
      return const Color(0xFF00E676); // Default green
    }
    return Color(colorValue);
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
