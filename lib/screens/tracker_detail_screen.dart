import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import '../models/tracker_model.dart';
import '../services/quote_service.dart';
import '../widgets/developer_dialog.dart';
import 'urge_screen.dart';
import '../theme.dart';

class TrackerDetailScreen extends StatefulWidget {
  final TrackerModel tracker;

  const TrackerDetailScreen({super.key, required this.tracker});

  @override
  State<TrackerDetailScreen> createState() => _TrackerDetailScreenState();
}

class _TrackerDetailScreenState extends State<TrackerDetailScreen> {
  late TrackerModel tracker;
  int buttonLabelIndex = 0;
  bool isLabelLocked = false;
  Timer? buttonTimer;
  Timer? streakUpdaterTimer;

  final List<String> buttonLabels = [
    "STAYED STRONG TODAY",
    "VICTORY CLAIMED",
    "I CONQUERED THE DAY",
    "ANOTHER DAY OF GROWTH",
    "I CHOSE DISCIPLINE",
    "MY WILL IS UNBROKEN",
    "I OWNED MY CHOICES",
    "STRENGTH WAS MY CHOICE",
    "I STAYED THE COURSE",
    "ONE MORE DAY OF FREEDOM",
    "I MASTERED MY MIND",
    "CHARACTER WAS BUILT",
    "I AM IN CONTROL",
    "PROUD OF MY PROGRESS",
    "I REJECTED TEMPTATION",
    "POWERED THROUGH TODAY",
    "UNSTOPPABLE DISCIPLINE",
    "I KEPT THE PROMISE",
    "TODAY WAS A WIN",
    "REWIRING MY FUTURE",
  ];

  @override
  void initState() {
    super.initState();
    tracker = widget.tracker;
    startButtonTimer();
    startStreakUpdater();
  }

  void startStreakUpdater() {
    // Refresh the UI every hour to check for automatic increments
    streakUpdaterTimer = Timer.periodic(const Duration(hours: 1), (timer) {
      if (mounted) {
        catchUpStreak();
      }
    });
  }

  void startButtonTimer() {
    buttonTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!isLabelLocked) {
        if (mounted) {
          setState(() {
            buttonLabelIndex = (buttonLabelIndex + 1) % buttonLabels.length;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    buttonTimer?.cancel();
    streakUpdaterTimer?.cancel();
    super.dispose();
  }

  void catchUpStreak() {
    if (tracker.lastUpdateDate == null) return;

    final now = DateTime.now();
    final difference = now.difference(tracker.lastUpdateDate!);
    final daysToCatchUp = difference.inDays;

    if (daysToCatchUp >= 1) {
      setState(() {
        tracker.currentStreak += daysToCatchUp;
        // Move the update date forward by the number of full days caught up
        tracker.lastUpdateDate = tracker.lastUpdateDate!.add(Duration(days: daysToCatchUp));
        
        if (tracker.currentStreak > tracker.longestStreak) {
          tracker.longestStreak = tracker.currentStreak;
        }
      });
    }
  }

  void checkIn() {
    final now = DateTime.now();

    setState(() {
      tracker.currentStreak++;
      tracker.lastUpdateDate = now;
      tracker.lastCheckIn = now;

      if (tracker.currentStreak > tracker.longestStreak) {
        tracker.longestStreak = tracker.currentStreak;
      }
    });

    if (tracker.currentStreak > 0 && tracker.currentStreak % 3 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("CONGRATULATIONS! ${tracker.currentStreak} DAYS FREE FROM ${tracker.title.toUpperCase()}!"),
          backgroundColor: AppTheme.primaryGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void resetStreak() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Relapse"),
        content: const Text(
          "Are you sure? Honesty is the first step to recovery.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                tracker.currentStreak = 0;
                tracker.lastUpdateDate = DateTime.now();
                tracker.motivationSeed = Random().nextInt(10000);
              });
              if (mounted) Navigator.pop(context);
            },
            child: const Text(
              "Yes, I relapsed",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // Pop back and return the modified tracker so dashboard can save it
  void _onBackPressed() {
    Navigator.pop(context, tracker);
  }

  String getMessage() {
    List<String> dynamicMotivations = QuoteService.getMotivations(tracker.title);
    
    if (tracker.currentStreak == 0) return dynamicMotivations[0];

    // Create a shuffled copy of the motivations list using the unique streak seed
    // This ensures quotes don't repeat during a single attempt.
    List<String> shuffledMotivations = List.from(dynamicMotivations)
      ..shuffle(Random(tracker.motivationSeed));

    // Pick the quote based on the 3-day block index
    int blockIndex = (tracker.currentStreak / 3).floor();

    // If we run out of unique quotes, we wrap around
    int quoteIndex = blockIndex % shuffledMotivations.length;

    String msg = shuffledMotivations[quoteIndex];

    if (tracker.currentStreak > 0 && tracker.currentStreak % 3 == 0) {
      return "CONGRATULATIONS! $msg";
    }

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(tracker.title.toUpperCase()),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _onBackPressed,
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const DeveloperDialog(),
                );
              },
              icon: const Icon(Icons.info_outline_rounded),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.5,
              colors: [
                AppTheme.primaryGreen.withOpacity(0.1),
                AppTheme.backgroundBlack,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  FadeInDown(
                    duration: const Duration(milliseconds: 800),
                    child: _buildStreakCircle(),
                  ),
                  const SizedBox(height: 40),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildLongestStreakBadge(),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      getMessage(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppTheme.textWhite.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const Spacer(),
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: _buildActionButtons(),
                  ),
                  const SizedBox(height: 30),
                  FadeIn(
                    delay: const Duration(milliseconds: 1000),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const DeveloperDialog(),
                        );
                      },
                      child: Text(
                        "Developed by Mebre lala",
                        style: TextStyle(
                          color: AppTheme.textWhite.withOpacity(0.3),
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStreakCircle() {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.2),
          width: 8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${tracker.currentStreak}",
              style: const TextStyle(
                fontSize: 84,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryGreen,
              ),
            ),
            Text(
              "DAYS",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 4,
                fontWeight: FontWeight.w300,
                color: AppTheme.textWhite.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLongestStreakBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceGrey,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppTheme.accentBlue.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.emoji_events_outlined,
            color: AppTheme.accentBlue,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            "BEST: ${tracker.longestStreak} DAYS",
            style: const TextStyle(
              color: AppTheme.accentBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: checkIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  elevation: 8,
                  shadowColor: AppTheme.primaryGreen.withOpacity(0.5),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    buttonLabels[buttonLabelIndex],
                    key: ValueKey<int>(buttonLabelIndex),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isLabelLocked = !isLabelLocked;
                  });
                },
                icon: Icon(
                  isLabelLocked ? Icons.lock : Icons.lock_open_outlined,
                  color: AppTheme.backgroundBlack.withOpacity(0.5),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UrgeScreen(trackerTitle: tracker.title)),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.accentBlue),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "I HAVE AN URGE",
                  style: TextStyle(color: AppTheme.accentBlue),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: resetStreak,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.withOpacity(0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "I RELAPSED",
                  style: TextStyle(color: Colors.red.withOpacity(0.8)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
