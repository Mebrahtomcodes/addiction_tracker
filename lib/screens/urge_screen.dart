import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';

class UrgeScreen extends StatefulWidget {
  const UrgeScreen({super.key});

  @override
  State<UrgeScreen> createState() => _UrgeScreenState();
}

class _UrgeScreenState extends State<UrgeScreen> {
  int seconds = 60;
  Timer? timer;
  bool isComplete = false;
  int sentenceIndex = 0;
  List<String> activeSentences = [];

  final List<String> allUrgeSentences = [
    "The urge is just a wave. Ride it.",
    "This feeling is temporary. Your integrity is permanent.",
    "Don't trade your future self for a few seconds of pleasure.",
    "You are stronger than a chemical signal in your brain.",
    "Close your eyes. Breathe. This too shall pass.",
    "Think about why you started. Don't let that person down.",
    "Your brain is lying to you right now. Don't believe it.",
    "You've survived every urge so far. You'll survive this one too.",
    "A moment of weakness is not worth a lifetime of regret.",
    "Urges are like clouds; they pass if you just wait.",
    "Focus on your breath. Inhale strength, exhale the urge.",
    "You are the master of your actions, not your impulses.",
    "The power to say no is your greatest strength.",
    "Imagine the pride you'll feel tomorrow if you stay strong now.",
    "One minute of discipline saves hours of guilt.",
    "Your future is being built by the choices you make today.",
    "Don't give up what you want most for what you want now.",
    "The urge will fade. Your progress is what remains.",
    "Stay present. This moment is all you have to conquer.",
    "You are not your thoughts. You are the observer of them.",
    "Every 'no' to an urge is a 'yes' to your freedom.",
    "Feel the urge, then choose to let it go.",
    "You are rewiring your brain every second you resist.",
    "The discomfort of resisting is growth in disguise.",
    "Be patient with yourself. Healing takes time.",
    "You are a warrior. Warriors don't surrender to impulses.",
    "Discipline is choosing between what you want now and what you want most.",
    "Your willpower is a muscle. This is your workout.",
    "The craving is just a thought. It has no power unless you act.",
    "Stay focused on the man you are becoming.",
    "Don't let a temporary feeling destroy a permanent goal.",
    "You have the authority to change your story.",
    "The best way to predict your future is to create it, one choice at a time.",
    "Self-control is the highest form of self-love.",
    "You are not alone in this fight. Stay strong.",
    "Every urge you defeat makes you significantly stronger.",
    "Your potential is far greater than this temporary distraction.",
    "Don't look back. You're not going that way.",
    "The secret of change is to focus all your energy on building the new.",
    "You are worthy of a life free from addiction.",
    "This is a test of your character. Pass it with honor.",
    "The urge is a ghost. It cannot touch you unless you let it.",
    "Breathe deep. You are alive, you are here, and you are in control.",
    "Small steps in the right direction lead to big changes.",
    "Your legacy is defined by your discipline.",
    "Don't throw away days of progress for seconds of impulse.",
    "You are building a version of yourself that cannot be broken.",
    "The only way out is through. Stay the course.",
    "You are the captain of your soul. Steer carefully.",
    "Today is a victory. Claim it by staying strong.",
  ];

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds > 0) {
        setState(() {
          seconds--;
          if (seconds > 0 && seconds % 10 == 0) {
            sentenceIndex = (sentenceIndex + 1) % activeSentences.length;
          }
        });
      } else {
        setState(() {
          isComplete = true;
        });
        t.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Pick 6 random unique sentences from the pool of 50
    final random = Random();
    List<String> tempPool = List.from(allUrgeSentences);
    tempPool.shuffle(random);
    activeSentences = tempPool.take(6).toList();
    
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundBlack,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.accentBlue.withOpacity(0.1),
              AppTheme.backgroundBlack,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppTheme.textWhite, size: 30),
                  ),
                ),
              ),
              const Spacer(),
              if (!isComplete) ...[
                Pulse(
                  infinite: true,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.accentBlue.withOpacity(0.5), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentBlue.withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "$seconds",
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.accentBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                FadeIn(
                  duration: const Duration(seconds: 2),
                  child: const Text(
                    "BREATHE IN... BREATHE OUT",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 4,
                      color: AppTheme.textWhite,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  key: ValueKey(sentenceIndex),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      activeSentences[sentenceIndex],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppTheme.textWhite.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                FadeIn(
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppTheme.primaryGreen, size: 80),
                      const SizedBox(height: 20),
                      const Text(
                        "URGE DEFEATED",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("I'M OKAY NOW"),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Do 10 push-ups. Drink water. Stay present.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
