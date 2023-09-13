import 'package:flutter/material.dart';
import 'package:gamerentz/utils/responsive.dart';
import 'package:gamerentz/views/screens/category_screen.dart';
import '../widgets/bottom_bar.dart';
import 'my_main_screens.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static int index = 0;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _updateIndex(int value) {
    setState(() {
      MainScreen.index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    final bottomBar = Padding(
      padding: const EdgeInsets.all(8.0),
      child: BottomBar(update: _updateIndex),
    );

    final appBar = Responsive.isDesktop(context)
        ? PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: bottomBar,
          )
        : null;

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: Responsive.isDesktop(context) ? null : bottomBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: GameScreen(),
        child: screens[MainScreen.index],
      ),
    );
  }
}
