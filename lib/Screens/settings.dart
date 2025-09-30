// // Add this to any screen, typically in settings
// import 'package:formify/config/theme/theme-cont.dart';
// import 'package:formify/config/theme/theme_selector.dart';
// import 'package:formify/config/theme/theme_switcher.dart';
// import 'package:formify/constants/export.dart';

// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Settings')),
//       body: ListView(
//         children: [
//           // Theme switcher
//           ThemeSwitcher(),
//           // Other settings...
//         ],
//       ),
//     );
//   }
// }

// // // Get the theme controller
// // final ThemeController themeController = Get.find<ThemeController>();

// // // Switch to specific theme
// // themeController.switchTheme(ThemeMode.light); // Force light mode
// // themeController.switchTheme(ThemeMode.dark);  // Force dark mode  
// // themeController.switchTheme(ThemeMode.system); // Follow system

// // // Toggle between light/dark
// // themeController.toggleTheme();

// // // In your AppBar actions
// // AppBar(
// //   title: Text('My App'),
// //   actions: [
// //     Obx(() {
// //       final ThemeController themeController = Get.find();
// //       return IconButton(
// //         icon: Icon(themeController.isDarkMode 
// //             ? Icons.light_mode 
// //             : Icons.dark_mode),
// //         onPressed: () => themeController.toggleTheme(),
// //       );
// //     }),
// //   ],
// // )

// // // Wrap your scaffold with a GestureDetector
// // GestureDetector(
// //   onDoubleTap: () {
// //     final ThemeController themeController = Get.find();
// //     themeController.toggleTheme();
// //   },
// //   child: Scaffold(...),
// // )

// // // Add this to your ThemeController
// // void listenToSystemChanges() {
// //   WidgetsBinding.instance.addObserver(
// //     LifecycleEventHandler(
// //       resumeCallBack: () => _checkSystemTheme(),
// //     ),
// //   );
// // }


// class SettingsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//         actions: [
//           Obx(() {
//             final themeController = Get.find<ThemeController>();
//             return IconButton(
//               icon: Icon(themeController.isDarkMode 
//                   ? Icons.light_mode 
//                   : Icons.dark_mode),
//               onPressed: themeController.toggleTheme,
//             );
//           }),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             ThemeSelector(), // Your custom selector
//             SizedBox(height: 20),
//             ThemeSwitcher(), // The basic switch
//           ],
//         ),
//       ),
//     );
//   }
// }