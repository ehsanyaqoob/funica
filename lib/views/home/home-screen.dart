import 'package:funica/constants/export.dart';
import 'package:funica/controller/profile-data-cont.dart';
import 'package:funica/views/home/fav-screen.dart';
import 'package:funica/views/home/noification-screen.dart';
import 'package:funica/views/profile/fill-up-profile-details.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/home-widgets/home-infocard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FillUpProfileController controller = Get.put(FillUpProfileController());

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
            body: SafeArea(
              child: SingleChildScrollView(
                padding: AppSizes.DEFAULT,
                child: Column(
                  children: [
                    UserInfoRow(
                      onAvatarTap: () {
                        Get.to(
                          () => FillUpProfileDetailScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(microseconds: 500),
                        );
                      },
                      onNotificationTap: () {
                        // Handle notification tap
                        Get.to(
                          () => NotificationScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(microseconds: 500),
                        );
                      },
                      onFavoriteTap: () {
                        // Handle favorite tap
                        Get.to(
                          () => FavouroteScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(microseconds: 500),
                        );
                      },
                    ),

                    const Gap(30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
