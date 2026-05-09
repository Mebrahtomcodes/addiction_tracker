import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import '../services/quote_service.dart';
import '../widgets/app_drawer.dart';

class UrgeScreen extends StatefulWidget {
  final String trackerTitle;
  
  const UrgeScreen({super.key, this.trackerTitle = "General"});

  @override
  State<UrgeScreen> createState() => _UrgeScreenState();
}

class _UrgeScreenState extends State<UrgeScreen> {
  int seconds = 60;
  Timer? timer;
  bool isComplete = false;
  int sentenceIndex = 0;
  List<String> activeSentences = [];

  // The sentences will be loaded dynamically in initState

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
    // Pick 6 random unique sentences from the pool of dynamic sentences
    final random = Random();
    List<String> dynamicUrgeSentences = QuoteService.getUrgeSentences(widget.trackerTitle);
    List<String> tempPool = List.from(dynamicUrgeSentences);
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("URGE MODE"),
        backgroundColor: Colors.transparent,
      ),
      drawer: const AppDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              Theme.of(context).scaffoldBackgroundColor,
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
                    icon: Icon(Icons.close, color: Theme.of(context).textTheme.bodyLarge?.color, size: 30),
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
                      border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.5), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "$seconds",
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                FadeIn(
                  duration: const Duration(seconds: 2),
                  child: Text(
                    "BREATHE IN... BREATHE OUT",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 4,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
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
                          color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
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
                      Icon(Icons.check_circle_outline, color: Theme.of(context).colorScheme.primary, size: 80),
                      const SizedBox(height: 20),
                      Text(
                        "URGE DEFEATED",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
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
