import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/tracker_model.dart';
import 'quote_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    // Assuming local timezone
    tz.setLocalLocation(tz.getLocation('America/New_York')); // Fallback, usually flutter_timezone is used, but we can stick to this or assume UTC offset. Actually we can just use local via fromDateTime.
    // However timezone package requires a location. Let's use local if possible. We will just use tz.local which defaults to UTC if not set, but it's fine for now, or we can use tz.TZDateTime.now(tz.local).

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    final androidImplementation = _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation != null) {
      await androidImplementation.requestNotificationsPermission();
      // await androidImplementation.requestExactAlarmsPermission();
    }
  }

  Future<void> scheduleAdaptiveNotifications(List<TrackerModel> trackers) async {
    // 1. Cancel previously scheduled notifications
    await _flutterLocalNotificationsPlugin.cancelAll();

    if (trackers.isEmpty) return;

    // Check if notifications are globally disabled by checking if all are disabled
    bool anyEnabled = trackers.any((t) => t.notificationsEnabled);
    if (!anyEnabled) return;

    // 2. Determine State
    bool isInRecovery = false;
    String activeTitle = trackers.first.title;
    final now = DateTime.now();

    for (var tracker in trackers) {
      if (tracker.currentStreak == 0) {
        isInRecovery = true;
        activeTitle = tracker.title; // Prioritize the relapsed tracker's title
        break;
      }
    }

    final random = Random();

    // 3. Schedule 7 Days Ahead
    for (int i = 1; i <= 7; i++) {
      // 4. Randomize Time between 6:30 AM and 8:30 AM
      // 6:30 AM is 390 minutes from midnight. 8:30 AM is 510 minutes.
      // Random minutes between 390 and 510.
      int randomMinutes = 390 + random.nextInt(121); // 0 to 120
      int hours = randomMinutes ~/ 60;
      int minutes = randomMinutes % 60;

      final scheduledDate = DateTime(
        now.year,
        now.month,
        now.day,
        hours,
        minutes,
      ).add(Duration(days: i));

      // Convert to TZDateTime
      final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

      // 5. Select Message
      String message;
      
      // Pick a random title from the list if not in recovery to keep it fresh
      if (!isInRecovery && trackers.length > 1) {
        activeTitle = trackers[random.nextInt(trackers.length)].title;
      }
      
      List<String> recoveryMessages = QuoteService.getRecoveryMessages(activeTitle);
      List<String> progressMessages = QuoteService.getProgressMessages(activeTitle);
      List<String> neutralMessages = QuoteService.getNeutralMessages(activeTitle);

      if (isInRecovery) {
        // Pick from recovery or neutral
        if (random.nextBool() && recoveryMessages.isNotEmpty) {
          message = recoveryMessages[random.nextInt(recoveryMessages.length)];
        } else {
          message = neutralMessages[random.nextInt(neutralMessages.length)];
        }
      } else {
        // Pick from progress or neutral
        // 80% chance for progress, 20% for neutral
        if (random.nextInt(100) < 80 && progressMessages.isNotEmpty) {
          message = progressMessages[random.nextInt(progressMessages.length)];
        } else {
          message = neutralMessages[random.nextInt(neutralMessages.length)];
        }
      }

      // 6. Schedule
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id: i, // Use day index as ID
        title: 'Discipline Tracker',
        body: message,
        scheduledDate: tzScheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_motivation_channel',
            'Daily Motivation',
            channelDescription: 'Daily motivational messages',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }
}
