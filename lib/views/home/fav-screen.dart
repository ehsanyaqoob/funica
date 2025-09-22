import 'package:funica/constants/export.dart';
import 'package:funica/controller/profile-data-cont.dart';
import 'package:funica/views/profile/fill-up-profile-details.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/home-widgets/home-infocard.dart';

class FavouroteScreen extends StatefulWidget {
  const FavouroteScreen({super.key});

  @override
  State<FavouroteScreen> createState() => _FavouroteScreenState();
}

class _FavouroteScreenState extends State<FavouroteScreen> {
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
