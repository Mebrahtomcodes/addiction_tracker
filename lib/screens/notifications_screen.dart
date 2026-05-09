import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/app_drawer.dart';
import '../models/notification_settings_model.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final StorageService _storage = StorageService();
  NotificationSettingsModel _settings = NotificationSettingsModel();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await _storage.loadNotificationSettings();
    setState(() {
      _settings = settings;
      _isLoading = false;
    });
  }

  Future<void> _updateSettings(NotificationSettingsModel newSettings) async {
    setState(() => _settings = newSettings);
    await _storage.saveNotificationSettings(newSettings);
    
    // Reschedule notifications
    final trackers = await _storage.loadTrackers();
    await NotificationService().scheduleAdaptiveNotifications(trackers);
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _settings.hour, minute: _settings.minute),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: AppTheme.backgroundBlack,
              surface: AppTheme.surfaceGrey,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      _updateSettings(_settings.copyWith(hour: picked.hour, minute: picked.minute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTIFICATIONS"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary))
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildSectionHeader("Master Switch"),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Daily Motivation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: const Text("Receive daily quotes and streak updates"),
                  value: _settings.isEnabled,
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (bool value) {
                    _updateSettings(_settings.copyWith(isEnabled: value));
                  },
                ),
                const SizedBox(height: 32),
                _buildSectionHeader("Schedule"),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Reminder Time", style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Currently set to ${_settings.hour.toString().padLeft(2, '0')}:${_settings.minute.toString().padLeft(2, '0')}"),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text("CHANGE", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                  ),
                  onTap: _selectTime,
                ),
                const SizedBox(height: 32),
                _buildSectionHeader("Motivation Style"),
                const SizedBox(height: 16),
                _buildStyleOption(
                  NotificationStyle.empathetic,
                  "Empathetic",
                  "Gentle, supportive, and understanding messages.",
                  Icons.favorite_outline_rounded,
                ),
                _buildStyleOption(
                  NotificationStyle.stoic,
                  "Stoic",
                  "Direct, logical, and focused on self-mastery.",
                  Icons.account_balance_outlined,
                ),
                _buildStyleOption(
                  NotificationStyle.aggressive,
                  "Disciplined",
                  "Strong, no-excuses, and challenging push.",
                  Icons.bolt_rounded,
                ),
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildStyleOption(NotificationStyle style, String title, String description, IconData icon) {
    final isSelected = _settings.style == style;
    return GestureDetector(
      onTap: () => _updateSettings(_settings.copyWith(style: style)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : AppTheme.surfaceGrey,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Theme.of(context).colorScheme.primary : Colors.white)),
                  Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[400])),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle_rounded, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
