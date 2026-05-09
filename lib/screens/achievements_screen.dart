import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme.dart';
import '../widgets/app_drawer.dart';
import '../models/achievement_model.dart';
import '../models/tracker_model.dart';
import '../services/storage_service.dart';
import '../services/achievement_service.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final StorageService _storage = StorageService();
  List<TrackerModel> _trackers = [];
  TrackerModel? _selectedTracker;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final trackers = await _storage.loadTrackers();
    setState(() {
      _trackers = trackers;
      if (_trackers.isNotEmpty) {
        _selectedTracker = _trackers.first;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TROPHY ROOM"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
          : _trackers.isEmpty
              ? _buildEmptyState()
              : _buildContent(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events_outlined, size: 80, color: Colors.grey.withOpacity(0.3)),
          const SizedBox(height: 20),
          const Text("No trackers found", style: TextStyle(fontSize: 20, color: Colors.grey)),
          const Text("Add a tracker to start earning trophies!", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final unlocked = _selectedTracker != null 
        ? AchievementService.getUnlockedAchievements(_selectedTracker!)
        : <AchievementModel>[];
    final next = _selectedTracker != null 
        ? AchievementService.getNextAchievement(_selectedTracker!)
        : null;
    final progress = _selectedTracker != null 
        ? AchievementService.getProgressToNext(_selectedTracker!)
        : 0.0;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildTrackerSelector(),
        ),
        SliverToBoxAdapter(
          child: _buildProgressHeader(next, progress),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final achievement = AchievementService.allAchievements[index];
                final isUnlocked = unlocked.any((a) => a.id == achievement.id);
                return _buildAchievementCard(achievement, isUnlocked);
              },
              childCount: AchievementService.allAchievements.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 40),
        ),
      ],
    );
  }

  Widget _buildTrackerSelector() {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 16),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _trackers.length,
        itemBuilder: (context, index) {
          final tracker = _trackers[index];
          final isSelected = _selectedTracker?.id == tracker.id;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(tracker.title.toUpperCase()),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() => _selectedTracker = tracker);
                }
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              backgroundColor: AppTheme.surfaceGrey,
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.backgroundBlack : Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressHeader(AchievementModel? next, double progress) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.15),
            Theme.of(context).colorScheme.secondary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          if (next != null) ...[
            Text(
              "NEXT FOR ${_selectedTracker?.title.toUpperCase()}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              next.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              next.description,
              style: TextStyle(color: Colors.grey[400]),
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: Colors.grey[800],
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "${(progress * 100).toInt()}% towards greatness",
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
            ),
          ] else ...[
            Icon(Icons.stars_rounded, color: Theme.of(context).colorScheme.primary, size: 48),
            const SizedBox(height: 16),
            Text(
              "${_selectedTracker?.title.toUpperCase()} IS MAXED OUT",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "All milestones achieved for this habit!",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAchievementCard(AchievementModel achievement, bool isUnlocked) {
    return FadeInUp(
      key: ValueKey("${_selectedTracker?.id}_${achievement.id}"),
      child: Container(
        decoration: BoxDecoration(
          color: isUnlocked ? AppTheme.surfaceGrey : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isUnlocked ? achievement.color.withOpacity(0.5) : Colors.white10,
            width: isUnlocked ? 2 : 1,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: achievement.color.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUnlocked ? achievement.color.withOpacity(0.1) : Colors.grey.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                achievement.icon,
                color: isUnlocked ? achievement.color : Colors.grey.withOpacity(0.3),
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                achievement.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isUnlocked ? Colors.white : Colors.grey.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${achievement.daysRequired} DAYS",
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1,
                color: isUnlocked ? achievement.color : Colors.grey.withOpacity(0.3),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
