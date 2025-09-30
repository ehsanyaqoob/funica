import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:funica/constants/export.dart';

class BoardingScreens extends StatefulWidget {
  const BoardingScreens({super.key});

  @override
  State<BoardingScreens> createState() => _BoardingScreensState();
}

class _BoardingScreensState extends State<BoardingScreens> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> boardingData = [
    {
      "image": Assets.kitchen,
      "title": "We provide high\nquality products just\nfor you",
    },
    {
      "image": Assets.art,
      "title": "Discover Furniture\nthat fits your style\nperfectly",
    },
    {
      "image": Assets.monitor,
      "title": "Fast Delivery\nright at your\ndoorstep",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDynamicScaffoldBackground(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: boardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final data = boardingData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 12,
                        child: Image.asset(
                          data["image"]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Center(
                            child: MyText(
                              text: data["title"]!.tr,
                              size: 36,
                              weight: FontWeight.bold,
                              color: kDynamicText(context),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: boardingData.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: kPrimaryColor,
                      dotColor: Colors.grey.shade400,
                      dotHeight: 10,
                      dotWidth: 16,
                      spacing: 6,
                    ),
                  ),
                  Gap(30),
                  MyButton(
                    onTap: () {
                      if (currentIndex < boardingData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Get.offAllNamed("/home");
                      }
                    },
                    buttonText: currentIndex == boardingData.length - 1
                        ? "Get Started".tr
                        : "Next".tr,
                  ),
                  Gap(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
