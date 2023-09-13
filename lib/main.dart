import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamerentz/providers/my_providers.dart';
import 'package:gamerentz/views/auth/login_screen.dart';
import 'package:gamerentz/theme/theme_constants.dart';
import 'package:gamerentz/views/screens/main_screen.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        StreamProvider<User?>.value(
          initialData: null, 
          value: FirebaseAuth.instance.authStateChanges(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    
    return MaterialApp(
      title: 'GameRentz',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeManager>(context).themeMode,
      home: user == null ? const LoginScreen() : const MainScreen(),
    );
  }
}
