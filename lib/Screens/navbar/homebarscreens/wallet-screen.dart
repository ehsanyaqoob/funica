import 'package:funica/constants/export.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
           
            backgroundColor: kDynamicScaffoldBackground(context),
            body:                   Center(child: Text("👤 Wallet Page")),


          ));
      },
    );
  }
}
