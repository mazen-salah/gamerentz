import 'package:flutter/material.dart';
import 'package:gamerentz/theme/theme_constants.dart';
import 'package:gamerentz/theme/theme_manager.dart';
import 'package:gamerentz/views/buyers/main_screen.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(() {
      themeListener();
    });
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: const MainScreen(),
    );
  }
}
