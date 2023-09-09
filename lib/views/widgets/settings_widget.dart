import 'package:flutter/material.dart';
import 'package:gamerentz/utils/helper_widgets.dart';
import 'package:provider/provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../theme/theme_constants.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: Theme.of(context).textTheme.titleLarge),
          themeSwitch(themeManager, context),
        ],
      ),
    );
  }

  Row themeSwitch(ThemeManager themeManager, BuildContext context) {
    return Row(
      children: [
        Icon(
            themeManager.themeMode == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode,
            color: primaryColor),
        horizontalSpace(10),
        Text(
          'Theme:',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        horizontalSpace(10),
        Switch(
          value: themeManager.themeMode == ThemeMode.system
              ? MediaQuery.of(context).platformBrightness == Brightness.dark
              : themeManager.themeMode == ThemeMode.dark,
          onChanged: (isDarkMode) async {
            themeManager.toggleTheme(isDarkMode);
          },
        ),
      ],
    );
  }
}
