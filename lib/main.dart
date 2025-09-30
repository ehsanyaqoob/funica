import 'dart:ui';

import 'package:funica/constants/export.dart';
import 'package:funica/controller/fav-cont.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Create and initialize ThemeController
  final ThemeController themeController = ThemeController();
  await themeController.initialize();

  // Put dependencies in GetX
  Get.put<SharedPreferences>(prefs);
  Get.put<ThemeController>(themeController);

  // For development testing - uncomment to force a specific theme
  //await themeController.switchTheme(ThemeMode.dark);
  //await themeController.switchTheme(ThemeMode.light);
  await themeController.switchTheme(ThemeMode.system);

  // Initialize FavouritesController
  Get.put(FavouritesController(), permanent: true);

  // Error handling setup
  FlutterError.onError = (details) {
    debugPrint('🚨 Flutter Error: ${details.exception}');
    debugPrint('📝 Stack trace: ${details.stack}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('🚨 Platform Error: $error');
    debugPrint('📝 Stack trace: $stack');
    return true;
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: 'Funica',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.themeMode,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          initialRoute: AppLinks.splash_screen,
          getPages: AppRoutes.pages,
          // Global error handling and keyboard dismissal
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                // Hide keyboard when tapping outside
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
