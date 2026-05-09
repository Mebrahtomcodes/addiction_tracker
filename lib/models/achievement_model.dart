import 'package:flutter/material.dart';

class AchievementModel {
  final String id;
  final String title;
  final String description;
  final int daysRequired;
  final IconData icon;
  final Color color;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.daysRequired,
    required this.icon,
    required this.color,
  });
}
