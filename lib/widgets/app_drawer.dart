import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/storage_service.dart';
import '../models/tracker_model.dart';
import '../screens/urge_screen.dart';
import 'urge_selector_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Future<void> _handleUrgeMode(BuildContext context) async {
    final storage = StorageService();
    final trackers = await storage.loadTrackers();

    if (!context.mounted) return;

    if (trackers.isEmpty) {
      // Navigate to general urge mode
      Navigator.pushNamed(context, "/urge");
    } else if (trackers.length == 1) {
      // Navigate directly to the only tracker's urge mode
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UrgeScreen(trackerTitle: trackers.first.title),
        ),
      );
    } else {
      // Show selector dialog
      showDialog(
        context: context,
        builder: (context) => UrgeSelectorDialog(
          trackers: trackers,
          onSelected: (tracker) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UrgeScreen(trackerTitle: tracker.title),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.dashboard_rounded,
                  label: "Home",
                  route: "/",
                  isSelected: currentRoute == "/" || currentRoute == null,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.edit_note_rounded,
                  label: "Journal",
                  route: "/journal",
                  isSelected: currentRoute == "/journal",
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.bolt_rounded,
                  label: "Urge Mode",
                  route: "/urge",
                  isSelected: currentRoute == "/urge",
                  onCustomTap: () => _handleUrgeMode(context),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.emoji_events_rounded,
                  label: "Achievements",
                  route: "/achievements",
                  isSelected: currentRoute == "/achievements",
                ),
                const Divider(height: 40, indent: 20, endIndent: 20),
                _buildMenuItem(
                  context,
                  icon: Icons.notifications_none_rounded,
                  label: "Notifications",
                  route: "/notifications",
                  isSelected: currentRoute == "/notifications",
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_outlined,
                  label: "Settings",
                  route: "/settings",
                  isSelected: currentRoute == "/settings",
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.info_outline_rounded,
                  label: "About",
                  route: "/about",
                  isSelected: currentRoute == "/about",
                ),
              ],
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.2),
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.track_changes_rounded,
              color: AppTheme.backgroundBlack,
              size: 30,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "DISCIPLINE",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          Text(
            "TRACKER",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isSelected,
    VoidCallback? onCustomTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context); // Close drawer
          if (onCustomTap != null) {
            onCustomTap();
            return;
          }
          if (!isSelected) {
            if (route == "/") {
              Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
            } else {
              Navigator.pushNamed(context, route);
            }
          }
        },
        leading: Icon(
          icon,
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Theme.of(context).colorScheme.primary : null,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          const Text(
            "v1.0.0",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const Spacer(),
          Text(
            "STAY STRONG",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
