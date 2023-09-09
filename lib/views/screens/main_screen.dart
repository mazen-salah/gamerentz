import 'package:flutter/material.dart';
import '../widgets/bottom_bar.dart';
import 'my_main_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static int index = 0;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const GameScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomBar(
          update: (value) {
            setState(() {
              MainScreen.index = value;
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: screens[MainScreen.index],
      ),
    );
  }
}
