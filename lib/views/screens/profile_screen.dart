import 'package:flutter/material.dart';
import 'package:gamerentz/views/widgets/account_widget.dart';
import 'package:gamerentz/views/widgets/settings_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AccountWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:20),
          child: Divider(),
        ),
        SettingsWidget(),
      ],
    );
  }
}
