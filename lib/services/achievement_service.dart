import 'package:flutter/material.dart';
import '../models/achievement_model.dart';
import '../models/tracker_model.dart';

class AchievementService {
  static final List<AchievementModel> allAchievements = [
    AchievementModel(
      id: '24_hours',
      title: 'The Spark',
      description: 'Reach a 24-hour streak',
      daysRequired: 1,
      icon: Icons.flash_on_rounded,
      color: Colors.amber,
    ),
    AchievementModel(
      id: '3_days',
      title: 'Sprout',
      description: 'Stay disciplined for 3 days',
      daysRequired: 3,
      icon: Icons.eco_rounded,
      color: Colors.greenAccent,
    ),
    AchievementModel(
      id: '7_days',
      title: 'Warrior',
      description: 'Reach a 1-week streak',
      daysRequired: 7,
      icon: Icons.shield_rounded,
      color: Colors.blueAccent,
    ),
    AchievementModel(
      id: '14_days',
      title: 'Unstoppable',
      description: 'Stay disciplined for 2 weeks',
      daysRequired: 14,
      icon: Icons.auto_awesome_rounded,
      color: Colors.purpleAccent,
    ),
    AchievementModel(
      id: '30_days',
      title: 'Iron Will',
      description: 'Reach a 1-month streak',
      daysRequired: 30,
      icon: Icons.fitness_center_rounded,
      color: Colors.orangeAccent,
    ),
    AchievementModel(
      id: '90_days',
      title: 'Legend',
      description: 'Stay disciplined for 3 months',
      daysRequired: 90,
      icon: Icons.workspace_premium_rounded,
      color: Colors.deepOrange,
    ),
    AchievementModel(
      id: '365_days',
      title: 'Indestructible',
      description: 'Reach a 1-year streak',
      daysRequired: 365,
      icon: Icons.diamond_rounded,
      color: Colors.cyanAccent,
    ),
  ];

  static List<AchievementModel> getUnlockedAchievements(TrackerModel tracker) {
    final streak = tracker.longestStreak;
    return allAchievements.where((a) => streak >= a.daysRequired).toList();
  }

  static double getProgressToNext(TrackerModel tracker) {
    final streak = tracker.longestStreak;
    
    final nextAchievement = allAchievements.firstWhere(
      (a) => a.daysRequired > streak,
      orElse: () => allAchievements.last,
    );

    if (streak >= nextAchievement.daysRequired) return 1.0;

    final prevAchievement = allAchievements.lastWhere(
      (a) => a.daysRequired <= streak,
      orElse: () => AchievementModel(id: '', title: '', description: '', daysRequired: 0, icon: Icons.error, color: Colors.transparent),
    );

    final range = nextAchievement.daysRequired - prevAchievement.daysRequired;
    final current = streak - prevAchievement.daysRequired;
    
    return (current / range).clamp(0.0, 1.0);
  }

  static AchievementModel? getNextAchievement(TrackerModel tracker) {
    final streak = tracker.longestStreak;
    
    try {
      return allAchievements.firstWhere((a) => a.daysRequired > streak);
    } catch (e) {
      return null; // All achievements unlocked!
    }
  }
}
