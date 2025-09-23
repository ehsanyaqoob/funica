import 'package:funica/constants/export.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/home-widgets/promo-offers-card.dart';

class PromoDetailView extends StatelessWidget {
  final PromoCardModel item;

  const PromoDetailView({super.key, required this.item});

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
      appBar: CustomAppBar(
        title: item.title,
        showLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(item.image, height: 220, fit: BoxFit.contain),
            Gap(20),
            MyText(
              text: item.discount,
              size: 28,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),
            Gap(12),
            MyText(
              text: item.title,
              size: 20,
              weight: FontWeight.w600,
              color: kDynamicText(context),
            ),
            Gap(12),
            MyText(
              text: item.subtitle,
              size: 14,
              color: kDynamicText(context).withOpacity(0.7),
            ),
          ],
        ),
      ),
        ));
  });}
}
