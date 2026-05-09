import 'package:flutter/material.dart';
import '../models/tracker_model.dart';
import '../theme.dart';

class UrgeSelectorDialog extends StatelessWidget {
  final List<TrackerModel> trackers;
  final Function(TrackerModel) onSelected;

  const UrgeSelectorDialog({
    super.key,
    required this.trackers,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "PICK YOUR CHALLENGE",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Which urge are we defeating?",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: trackers.length,
                itemBuilder: (context, index) {
                  final tracker = trackers[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        onSelected(tracker);
                      },
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.bolt_rounded, color: AppTheme.primaryGreen),
                      ),
                      title: Text(
                        tracker.title.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("NOT NOW", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
