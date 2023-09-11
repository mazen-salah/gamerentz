import 'package:flutter/material.dart';
import 'package:gamerentz/theme/theme_constants.dart';
import 'package:gamerentz/views/screens/main_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
    required this.update,
  }) : super(key: key);
  final ValueChanged<int> update;

  @override
  Widget build(BuildContext context) {
    return GNav(
      gap: 8,
      color: primaryColor,
      selectedIndex: MainScreen.index,
      activeColor: Colors.white,
      tabBackgroundColor: primaryColor,
      padding: const EdgeInsets.all(8),
      onTabChange: (value) => update(value),
      tabs: [
        GButton(
          icon: MainScreen.index == 0 ? Icons.home_outlined : Icons.home,
          text: 'Home',
        ),
        GButton(
          icon: MainScreen.index == 1 ? Icons.games_outlined : Icons.games,
          text: 'Games',
        ),
        GButton(
          icon: MainScreen.index == 2
              ? Icons.shopping_cart_outlined
              : Icons.shopping_cart,
          text: 'Cart',
        ),
        GButton(
          icon: MainScreen.index == 3 ? Icons.person_outlined : Icons.person,
          text: 'Profile',
        ),
      ],
    );
  }
}
