import 'package:flutter/foundation.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/Screens/auth/sign-in.dart';
import 'package:funica/Screens/auth/sign-up.dart';
import 'package:funica/Screens/home/home-screen.dart';

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
            statusBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(Assets.art, fit: BoxFit.cover, cacheWidth: 1080),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        Colors.transparent,
                        isDarkMode
                            ? Colors.black.withOpacity(0.9)
                            : Colors.white.withOpacity(0.9),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyText(
                            text: 'Funica',
                            color: kDynamicText(context),
                            size: 40,
                            weight: FontWeight.bold,
                          ),
                          const Gap(10),
                          MyText(
                            text: 'Everything You Need, Nothing You Don\'t'.tr,
                            color: kDynamicText(context),
                            size: 20,
                            weight: FontWeight.bold,
                          ),
                          MyText(
                            text:
                                'Discover a world of products tailored to your needs. Shop smart, live better.'
                                    .tr,
                            color: kDynamicListTileSubtitle(context),
                            size: 14,
                            weight: FontWeight.w400,
                            textAlign: TextAlign.center,
                          ),
                          const Gap(30),
                          MyButtonWithIcon(
                            text: 'Sign-In with email'.tr,
                            iconPath: 
                              Assets.emailfilled,
                              
                            onTap: () {
                              Get.to(
                                const SignInScreen(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                          ),
                          const Gap(20),
                          MyButtonWithIcon(
                            text: 'Explore As Guest'.tr,
                             iconPath: 
                              Assets.personfilled,
                              
                            
                            onTap: () {
                              Get.to(
                                HomeScreen(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                          ),
                          const Gap(20),
                          MyButtonWithIcon(
                            text: 'Sign-up with email'.tr,
                             iconPath: 
                              Assets.emailfilled,
                            
                            onTap: () {
                              Get.to(
                                const SignUpScreen(),
                                transition: Transition.cupertino,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
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
