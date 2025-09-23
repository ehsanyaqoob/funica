import 'package:flutter/material.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/widget/custom_appbar.dart';

class ProductDetailsView extends StatelessWidget {
  final String title;
  final String image;
  final String price;

  const ProductDetailsView({
    super.key,
    required this.title,
    required this.image,
    required this.price,
  });

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
        title: title,
        showLeading: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SvgPicture.asset(
                image,
                height: 240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Gap(16),
            MyText(
              text: title,
              size: 22,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),
            Gap(8),
            MyText(
              text: price,
              size: 18,
              weight: FontWeight.w600,
              color: kDynamicText(context),
            ),
            Gap(16),
            MyText(
              text: "This is a detailed description of $title. "
                  "High quality, durable and designed to enhance your living space.",
              size: 14,
              color: kDynamicText(context),
            ),
            Gap(24),
            MyButton(
              buttonText: "Add to Cart",
              onTap: () {},
              hasgrad: true,
              hasshadow: true,
            )
          ],
        ),
      ),
        ));});
  }
}
