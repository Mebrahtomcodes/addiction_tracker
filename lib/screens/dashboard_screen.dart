import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:uuid/uuid.dart';
import '../models/tracker_model.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';
import '../widgets/developer_dialog.dart';
import '../widgets/add_tracker_dialog.dart';
import 'tracker_detail_screen.dart';
import '../theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final StorageService storage = StorageService();
  List<TrackerModel> trackers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTrackers();
  }

  Future<void> loadTrackers() async {
    final loadedTrackers = await storage.loadTrackers();
    
    // Process catch-up logic for all trackers
    bool needsSave = false;
    final now = DateTime.now();
    
    for (var tracker in loadedTrackers) {
      if (tracker.lastUpdateDate != null) {
        final difference = now.difference(tracker.lastUpdateDate!);
        final daysToCatchUp = difference.inDays;

        if (daysToCatchUp >= 1) {
          tracker.currentStreak += daysToCatchUp;
          tracker.lastUpdateDate = tracker.lastUpdateDate!.add(Duration(days: daysToCatchUp));
          
          if (tracker.currentStreak > tracker.longestStreak) {
            tracker.longestStreak = tracker.currentStreak;
          }
          needsSave = true;
        }
      }
    }
    
    if (needsSave) {
      await storage.saveTrackers(loadedTrackers);
    }

    await NotificationService().scheduleAdaptiveNotifications(loadedTrackers);

    setState(() {
      trackers = loadedTrackers;
      isLoading = false;
    });
  }

  void _addTracker(String title) async {
    final newTracker = TrackerModel(
      id: const Uuid().v4(),
      title: title,
      lastUpdateDate: DateTime.now(),
    );
    
    setState(() {
      trackers.add(newTracker);
    });
    
    await storage.saveTrackers(trackers);
    await NotificationService().scheduleAdaptiveNotifications(trackers);
  }

  void _deleteTracker(String id) async {
    setState(() {
      trackers.removeWhere((t) => t.id == id);
    });
    await storage.saveTrackers(trackers);
    await NotificationService().scheduleAdaptiveNotifications(trackers);
  }

  void _navigateToDetails(TrackerModel tracker) async {
    final updatedTracker = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TrackerDetailScreen(tracker: tracker),
      ),
    );

    if (updatedTracker != null) {
      // Update the tracker in the list
      final index = trackers.indexWhere((t) => t.id == updatedTracker.id);
      if (index != -1) {
        setState(() {
          trackers[index] = updatedTracker;
        });
        await storage.saveTrackers(trackers);
        await NotificationService().scheduleAdaptiveNotifications(trackers);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("MY TRACKERS"),
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
          child: isLoading 
            ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryGreen))
            : trackers.isEmpty 
              ? _buildEmptyState() 
              : _buildTrackerList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.add, color: AppTheme.backgroundBlack),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddTrackerDialog(
              onAdd: _addTracker,
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: FadeInUp(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.track_changes,
              size: 80,
              color: AppTheme.textWhite.withOpacity(0.2),
            ),
            const SizedBox(height: 20),
            Text(
              "No trackers yet.",
              style: TextStyle(
                color: AppTheme.textWhite.withOpacity(0.5),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Tap + to start building discipline.",
              style: TextStyle(
                color: AppTheme.textWhite.withOpacity(0.4),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trackers.length,
      itemBuilder: (context, index) {
        final tracker = trackers[index];
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildTrackerCard(tracker),
        );
      },
    );
  }

  Widget _buildTrackerCard(TrackerModel tracker) {
    return GestureDetector(
      onTap: () => _navigateToDetails(tracker),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceGrey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryGreen.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tracker.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textWhite,
                      letterSpacing: 1.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orangeAccent,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Best: ${tracker.longestStreak}",
                        style: TextStyle(
                          color: AppTheme.textWhite.withOpacity(0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.5),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "${tracker.currentStreak}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                  Text(
                    "DAYS",
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.5,
                      color: AppTheme.primaryGreen.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Tracker"),
                    content: Text("Are you sure you want to delete '${tracker.title}'?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          _deleteTracker(tracker.id);
                          Navigator.pop(context);
                        },
                        child: const Text("Delete", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
