import 'package:flutter/material.dart';
import '../theme.dart';
import '../main.dart';
import '../widgets/app_drawer.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final StorageService _storage = StorageService();

  final List<Color> _palette = [
    const Color(0xFF00E676), // Green
    const Color(0xFF00D2FF), // Blue
    const Color(0xFFE040FB), // Purple
    const Color(0xFFFF5252), // Red
    const Color(0xFFFFD740), // Gold
    const Color(0xFF64FFDA), // Teal
  ];

  void _resetData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("RESET ALL DATA"),
        content: const Text(
          "This will permanently delete all your trackers, journal entries, and trophies. This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmReset();
            },
            child: const Text("RESET", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmReset() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("ARE YOU SURE?"),
        content: const Text("Please confirm one last time. Everything will be gone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () async {
              await _storage.clearAllData();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All data has been wiped.")),
                );
              }
            },
            child: const Text("DELETE EVERYTHING", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final currentThemeColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("SETTINGS"),
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader(context, "Appearance"),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.bold)),
            secondary: Icon(isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
            value: isDarkMode,
            activeColor: currentThemeColor,
            onChanged: (bool value) {
              MyApp.of(context).toggleTheme();
            },
          ),
          const SizedBox(height: 24),
          const Text(
            "Accent Color",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _palette.length,
              itemBuilder: (context, index) {
                final color = _palette[index];
                final isSelected = currentThemeColor.value == color.value;
                return GestureDetector(
                  onTap: () => MyApp.of(context).setThemeColor(color),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Colors.white : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: color.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                      ],
                    ),
                    child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          _buildSectionHeader(context, "Data Management"),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
            title: const Text("Reset All Data", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
            subtitle: const Text("Wipe everything and start fresh"),
            onTap: _resetData,
          ),
          const SizedBox(height: 40),
          _buildSectionHeader(context, "Support"),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text("About Discipline Tracker"),
            onTap: () => Navigator.pushNamed(context, "/about"),
          ),
          const SizedBox(height: 60),
          Center(
            child: Column(
              children: [
                Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  "STAY DISCIPLINED. STAY FREE.",
                  style: TextStyle(
                    color: currentThemeColor.withOpacity(0.3),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: MyApp.of(context).themeColor,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: 12,
        ),
      ),
    );
  }
}
