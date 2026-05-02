import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import '../services/storage_service.dart';
import 'urge_screen.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentStreak = 0;
  int longestStreak = 0;
  int motivationSeed = 0;
  int buttonLabelIndex = 0;
  bool isLabelLocked = false;
  Timer? buttonTimer;

  final StorageService storage = StorageService();

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
    loadData();
    startButtonTimer();
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
    super.dispose();
  }

  void loadData() async {
    final data = await storage.loadData();
    setState(() {
      currentStreak = data["current"]!;
      longestStreak = data["longest"]!;
      motivationSeed = data["seed"]!;
    });
  }

  void checkIn() async {
    setState(() {
      currentStreak++;
      if (currentStreak > longestStreak) {
        longestStreak = currentStreak;
      }
    });

    if (currentStreak > 0 && currentStreak % 3 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("CONGRATULATIONS! $currentStreak DAYS OF DISCIPLINE!"),
          backgroundColor: AppTheme.primaryGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    await storage.saveStreak(currentStreak, longestStreak);
  }

  void resetStreak() async {
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
            onPressed: () async {
              setState(() {
                currentStreak = 0;
                motivationSeed = Random().nextInt(10000);
              });
              await storage.saveStreak(currentStreak, longestStreak);
              await storage.saveSeed(motivationSeed);
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

  final List<String> motivations = [
    "Every journey starts with a single step.",
    "The first few days are the hardest. Stay focused.",
    "You're building real momentum. Don't stop now.",
    "Two weeks! Your brain is starting to rewire.",
    "You are becoming the master of your own mind.",
    "Discipline is the bridge between goals and accomplishment.",
    "Freedom is not the absence of discipline, but the presence of it.",
    "Strength does not come from physical capacity. It comes from an indomitable will.",
    "He who conquers himself is the mightiest warrior.",
    "Success is the sum of small efforts, repeated day in and day out.",
    "The only person you are destined to become is the person you decide to be.",
    "Character is what you do when no one is watching.",
    "The secret of your future is hidden in your daily routine.",
    "Don't wait for motivation. Cultivate discipline.",
    "Consistency is the playground of excellence.",
    "Your future self will thank you for what you do today.",
    "Small wins lead to massive victories.",
    "Focus on the process, and the results will follow.",
    "Discipline is doing what needs to be done, even if you don't feel like it.",
    "Your habits define your destiny.",
    "The pain of discipline is far less than the pain of regret.",
    "Excellence is not an act, but a habit.",
    "Stay patient and trust your journey.",
    "Growth begins at the end of your comfort zone.",
    "You are stronger than your strongest excuse.",
    "Every day is a new chance to be better than yesterday.",
    "Believe in the power of your choices.",
    "The discipline you learn today will serve you forever.",
    "Keep going. You're further than you were yesterday.",
    "Integrity is choosing courage over comfort.",
    "The harder the struggle, the more glorious the triumph.",
    "Success is not final, failure is not fatal: it is the courage to continue that counts.",
    "Your mind is a powerful thing. When you fill it with positive thoughts, your life will start to change.",
    "Discipline is the soul of an army. It makes small numbers formidable.",
    "Motivation gets you going, but habit keeps you going.",
    "The difference between a successful person and others is not a lack of strength, but a lack of will.",
    "You don't have to be great to start, but you have to start to be great.",
    "Energy and persistence conquer all things.",
    "The path to success is to take massive, determined action.",
    "Be the master of your will and the slave of your conscience.",
    "Action is the foundational key to all success.",
    "Do not be embarrassed by your failures, learn from them and start again.",
    "It does not matter how slowly you go as long as you do not stop.",
    "Everything you've ever wanted is on the other side of fear.",
    "Success is walking from failure to failure with no loss of enthusiasm.",
    "The successful warrior is the average man, with laser-like focus.",
    "Discipline is the ability to do what is right even when it's hard.",
    "The more you practice discipline, the easier it becomes.",
    "You are the architect of your own recovery.",
    "A year from now, you will wish you had started today. But you already did.",
    "One day at a time. One choice at a time.",
    "You are capable of more than you know.",
    "The only limit to our realization of tomorrow will be our doubts of today.",
    "Stay hungry, stay foolish, stay disciplined.",
    "The journey of a thousand miles begins with a single check-in.",
    "Victory belongs to the most persevering.",
  ];

  String getMessage() {
    if (currentStreak == 0) return motivations[0];

    // Create a shuffled copy of the motivations list using the unique streak seed
    // This ensures quotes don't repeat during a single attempt.
    List<String> shuffledMotivations = List.from(motivations)
      ..shuffle(Random(motivationSeed));

    // Pick the quote based on the 3-day block index
    int blockIndex = (currentStreak / 3).floor();

    // If we run out of unique quotes, we wrap around (though with 50+ quotes this takes 150+ days)
    int quoteIndex = blockIndex % shuffledMotivations.length;

    String msg = shuffledMotivations[quoteIndex];

    if (currentStreak > 0 && currentStreak % 3 == 0) {
      return "CONGRATULATIONS! $msg";
    }

    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("DISCIPLINE"),
        actions: [
          IconButton(
            onPressed: () {}, // Settings or Profile could go here
            icon: const Icon(Icons.account_circle_outlined),
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
                const SizedBox(height: 40),
              ],
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
              "$currentStreak",
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
            "BEST: $longestStreak DAYS",
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
                    MaterialPageRoute(builder: (_) => const UrgeScreen()),
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
