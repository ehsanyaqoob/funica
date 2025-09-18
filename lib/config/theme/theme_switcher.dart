// lib/widgets/theme_switcher.dart
import 'package:flutter/material.dart';
import 'package:funica/config/theme/theme-cont.dart';
import 'package:funica/constants/export.dart';
import 'package:get/get.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    
    return Obx(() {
      return SwitchListTile(
        title: Text(themeController.isDarkMode ? 'Dark Mode' : 'Light Mode'),
        value: themeController.isDarkMode,
        onChanged: (value) {
          themeController.toggleTheme();
        },
      );
    });
  }
}