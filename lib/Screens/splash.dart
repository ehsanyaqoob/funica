import 'package:flutter/foundation.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/splash-cont.dart';
import 'package:funica/widget/dot-loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final SplashController controller = Get.put(SplashController());
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();

    // Delay the system UI update until after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSystemUi();
    });
  }

  void _updateSystemUi() {
    final Brightness platformBrightness =
        WidgetsBinding.instance.window.platformBrightness;
    final bool isDark = platformBrightness == Brightness.dark;
    final Color bgColor = isDark ? kDarkBackground : kLightBackground;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        // systemNavigationBarColor: bgColor,
        // systemNavigationBarIconBrightness: isDark
        //     ? Brightness.light
        //     : Brightness.dark,
        // systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        // This forces rebuild when theme changes
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
            body: SafeArea(
              bottom: false,
              child: Obx(() {
                return Stack(
                  children: [
                    /// 🎯 Logo animation
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            isDarkMode ? Assets.funicalight : Assets.funicadark,
                            height: 100,
                            width: 80,
                          ),
                          
                        ],
                      ),
                    ),

                    /// 🎯 Progress loader
                    if (controller.showProgress.value)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: MediaQuery.of(context).padding.bottom + 50,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyText(
                                text: "Funica",
                                size: 16,
                                weight: FontWeight.w500,
                                color: kDynamicText(context),
                              ),
                              const Gap(16.0),
                              const FunicaLoader(),
                            ],
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
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
