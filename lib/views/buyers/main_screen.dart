import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gamerentz/views/buyers/settings_screen.dart';
import '../../providers/bottom_bar_provider.dart';
import 'bottom_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabManager = Provider.of<BottomNavigationBarProvider>(context);

    final screens = [
      const Center(child: Text('Home')),
      const Center(child: Text('Search')),
      const Center(child: Text('Cart')),
      const Settings(),
    ];

    return Scaffold(
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: BottomBar(),
      ),
      body: screens[tabManager.currentIndex],
    );
  }
}
