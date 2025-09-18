
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:funica/constants/export.dart';

class CustomDotIndicator extends StatelessWidget {
  final PageController controller = PageController();

  CustomDotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            controller: controller,
            children: List.generate(
              3,
              (index) => Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesHomeContianerBg),

                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text:
                          "Discover exclusive community\ncontent, enjoy Arabic radio, shop\nunique items, and more."
                              .tr,
                      textAlign: TextAlign.start,
                      size: 14,
                      paddingBottom: 16,
                      weight: FontWeight.w500,
                      color: kWhite,
                    ),
                    MyButton(
                      onTap: () {},
                      width: 120,
                      height: 32,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      buttonText: "Watch Video".tr,
                      hasicon: true,
                      fontColor: kPrimaryColor,
                      backgroundColor: kWhite,
                      choiceIcon: Assets.imagesPlayButtonBlue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20),
              width: 24,
              height: 6,
            ),
            dotDecoration: DotDecoration(
              color: kBorderColor,
              borderRadius: BorderRadius.circular(20),
              width: 6,
              height: 6,
            ),
            spacing: 3,
          ),
        ),
      ],
    );
  }
}

class CustomDotIndicatorProduct extends StatelessWidget {
  final PageController controller = PageController();

  CustomDotIndicatorProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            controller: controller,
            children: List.generate(
              3,
              (index) => Container(
                margin: EdgeInsets.only(right: 5),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesPerfume),

                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text:
                          "Don't miss out on the chance to\nelevate your fragrance collection\nwithout breaking the bank!,"
                              .tr,

                      textAlign: TextAlign.start,
                      size: 14,
                      paddingBottom: 16,
                      weight: FontWeight.w500,
                      color: kWhite,
                    ),
                    MyButton(
                      onTap: () {},
                      width: 100,
                      height: 32,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      buttonText: "Grab Yours".tr,
                      fontColor: kPrimaryColor,
                      backgroundColor: kWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SmoothPageIndicator(
          controller: controller,
          count: 3,
          effect: CustomizableEffect(
            activeDotDecoration: DotDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20),
              width: 24,
              height: 6,
            ),
            dotDecoration: DotDecoration(
              color: kBorderColor,
              borderRadius: BorderRadius.circular(20),
              width: 6,
              height: 6,
            ),
            spacing: 3,
          ),
        ),
      ],
    );
  }
}
