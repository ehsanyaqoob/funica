import 'package:funica/constants/export.dart';

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
