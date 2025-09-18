import 'package:funica/constants/export.dart';

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
        );
      },
    );
  }  
}