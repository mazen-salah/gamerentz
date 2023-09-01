
import 'package:flutter/material.dart';
import 'package:gamerentz/theme/theme_constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../../providers/bottom_bar_provider.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabManager = Provider.of<BottomNavigationBarProvider>(context);
    
    return GNav(
      gap: 8,
      color: primaryColor,
      activeColor: Colors.white,
      tabBackgroundColor: primaryColor,
      padding: const EdgeInsets.all(8),
      onTabChange: (value) {
        tabManager.currentIndex = value;
      },
      tabs: const [
        GButton(
          icon: Icons.gamepad_outlined,
          text: 'Games',
        ),
        GButton(
          icon: Icons.search,
          text: 'Search',
        ),
        GButton(
          icon: Icons.shopping_cart,
          text: 'Cart',
        ),
        GButton(
          icon: Icons.person,
          text: 'Profile',
        ),
      ],
    );
  }
}