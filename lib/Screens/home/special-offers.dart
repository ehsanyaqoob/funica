import 'package:funica/Screens/home/promo-details-screen.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/widget/home-widgets/promo-offers-card.dart';

class SpecialOffersView extends StatelessWidget {
  final List<PromoCardModel> items;

  const SpecialOffersView({super.key, required this.items});

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
        title: "Special Offers",
        showLeading: true,
      ),
      body: Padding(
        padding: AppSizes.DEFAULT,
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => Gap(16),
          itemBuilder: (context, index) {
            final item = items[index];
            return Bounce(
              onTap: () => Get.to(() => PromoDetailView(item: item)),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kDynamicContainer(context),
                  borderRadius: BorderRadius.circular(26.0),
                  border: Border.all(color: kDynamicBorder(context)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: item.discount,
                            size: 22,
                            weight: FontWeight.bold,
                            color: kDynamicText(context),
                          ),
                          Gap(6),
                          MyText(
                            text: item.title,
                            size: 16,
                            weight: FontWeight.w600,
                            color: kDynamicText(context),
                          ),
                          Gap(6),
                          MyText(
                            text: item.subtitle,
                            size: 12,
                            color: kDynamicText(context).withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      item.image,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
        ));
  });
}}
