import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'theme.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';
import 'screens/journal_screen.dart';
import 'screens/urge_screen.dart';
import 'screens/achievements_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  
  final storage = StorageService();
  final isDarkMode = await storage.getThemeMode();
  final themeColor = await storage.getThemeColor();
  
  runApp(MyApp(initialDarkMode: isDarkMode, initialColor: themeColor));
}

class MyApp extends StatefulWidget {
  final bool initialDarkMode;
  final Color initialColor;
  const MyApp({super.key, required this.initialDarkMode, required this.initialColor});

  static MyAppState of(BuildContext context) => 
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late bool _isDarkMode;
  late Color _themeColor;
  final StorageService _storage = StorageService();

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialDarkMode;
    _themeColor = widget.initialColor;
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    _storage.saveThemeMode(_isDarkMode);
  }

  void setThemeColor(Color color) {
    setState(() {
      _themeColor = color;
    });
    _storage.saveThemeColor(color);
  }

  bool get isDarkMode => _isDarkMode;
  Color get themeColor => _themeColor;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discipline Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(false, _themeColor),
      darkTheme: AppTheme.getTheme(true, _themeColor),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/journal': (context) => const JournalScreen(),
        '/urge': (context) => const UrgeScreen(),
        '/achievements': (context) => const AchievementsScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
