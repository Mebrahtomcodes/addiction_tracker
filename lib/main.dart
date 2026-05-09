import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'theme.dart';
import 'services/notification_service.dart';

import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  
  final storage = StorageService();
  final isDarkMode = await storage.getThemeMode();
  
  runApp(MyApp(initialDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool initialDarkMode;
  const MyApp({super.key, required this.initialDarkMode});

  static MyAppState of(BuildContext context) => 
      context.findAncestorStateOfType<MyAppState>()!;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late bool _isDarkMode;
  final StorageService _storage = StorageService();

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.initialDarkMode;
  }

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    _storage.saveThemeMode(_isDarkMode);
  }

  bool get isDarkMode => _isDarkMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discipline Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const DashboardScreen(),
    );
  }
}
