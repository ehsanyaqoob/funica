import 'package:flutter/material.dart';
import 'package:funica/constants/export.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: AppBar(
              backgroundColor: kDynamicScaffoldBackground(context),
              elevation: 0,
              title: Text(
                'Home'.tr,
                style: TextStyle(color: kDynamicText(context)),
              ),
              iconTheme: IconThemeData(color: kDynamicIcon(context)),
            ),
            body: SafeArea(
              child: Center(
                child: Text(
                  'Welcome Home!'.tr,
                  style: TextStyle(
                    color: kDynamicText(context),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
