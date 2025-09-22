import 'package:flutter/foundation.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/views/auth/sign-in.dart';
import 'package:funica/views/auth/sign-up.dart';
import 'package:funica/views/home/home-screen.dart';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  Assets.art,
                  fit: BoxFit.cover,
                  cacheWidth: 1080,
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [Colors.transparent, Colors.black],
                    ),
                  ),
                ),

                // Foreground Content
                SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyText(
                            text: 'Funica',
                            color: kWhite,
                            size: 40,
                            weight: FontWeight.bold,
                          ),
                          const Gap(10),
                          MyText(
                            text: 'Everything You Need, Nothing You Don\'t'.tr,
                            color: kWhite,
                            size: 20,
                            weight: FontWeight.bold,
                          ),

                          MyText(
                            text:
                                'Discover a world of products tailored to your needs. Shop smart, live better.'
                                    .tr,
                            color: kWhite,
                            size: 14,
                            weight: FontWeight.w400,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(30),

                          // Usage in your button
                          MyButtonWithIcon(
                            text: 'Sign-In with email'.tr,
                            icon: Icons.email,
                            onTap: () {
                              Get.to(
                                const SignInScreen(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            color: kPrimaryColor,
                            textColor: kWhite,
                          ),

                          const Gap(20),
                          MyButtonWithIcon(
                            text: 'Explore As Guest'.tr,
                            icon: Icons.person,
                            onTap: () {
                              Get.to(
                                HomeScreen(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            color: kWhite,

                            textColor: kPrimaryColor,
                          ),
                          const Gap(20),
                          MyButtonWithIcon(
                            text: 'Sign-up with email'.tr,
                            icon: Icons.email,
                            onTap: () { Get.to(
                                const SignUpScreen(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 500),
                              );

                            },
                            color: kPrimaryColor,
                            textColor: kWhite,
                          ),
                          const Gap(50),
                        ],
                      ),
                    ),
                  ),
                ),
                 if (kDebugMode)
                      Positioned(
                        top: 20,
                        right: 20,
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: kDynamicBackground(context),
                          onPressed: () => themeController.toggleTheme(),
                          child: Icon(
                            isDarkMode ? Icons.light_mode : Icons.dark_mode,
                            color: kDynamicIcon(context),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}


// class YourScreen extends StatefulWidget {
//   const YourScreen({super.key});

//   @override
//   State<YourScreen> createState() => _YourScreenState();
// }

// class _YourScreenState extends State<YourScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ThemeController>(
//       builder: (themeController) {
//         final bool isDarkMode = themeController.isDarkMode;

//         return AnnotatedRegion<SystemUiOverlayStyle>(
//           value: SystemUiOverlayStyle(
//             statusBarColor: Colors.transparent,
//             statusBarIconBrightness: isDarkMode
//                 ? Brightness.light
//                 : Brightness.dark,
//             systemNavigationBarColor: kDynamicBackground(context),
//             systemNavigationBarIconBrightness: isDarkMode
//                 ? Brightness.light
//                 : Brightness.dark,
//           ),
//           child: Scaffold(
//             backgroundColor: kDynamicScaffoldBackground(context),
//             appBar: CustomAppBar(
//               title: 'Your Title'.tr,
//               showLeading: true,
//             ),
//             body: SafeArea(
//               child: YourContent(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }