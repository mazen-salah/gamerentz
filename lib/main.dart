import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/bottom_bar_provider.dart';
import 'firebase_options.dart';
import 'package:gamerentz/theme/theme_constants.dart';
import 'package:gamerentz/providers/theme_provider.dart';
import 'package:gamerentz/views/buyers/main_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => BottomNavigationBarProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameRentz',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeManager>(context).themeMode,
      home: const MainScreen(),
    );
  }
}
