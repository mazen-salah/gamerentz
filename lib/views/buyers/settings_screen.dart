import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../theme/theme_constants.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Provider.of<ThemeManager>(context).themeMode.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  themeManager.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: primaryColor),
              const Text(
                'Theme:',
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                value: themeManager.themeMode == ThemeMode.system
                    ? MediaQuery.of(context).platformBrightness ==
                        Brightness.dark
                    : themeManager.themeMode == ThemeMode.dark,
                onChanged: (isDarkMode) async {
                  themeManager.toggleTheme(isDarkMode);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
