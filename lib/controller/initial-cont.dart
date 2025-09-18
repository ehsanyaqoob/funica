// import 'package:get/get.dart';

// class InitialController extends GetxController {
//   final pageController = PageController();
//   final currentPage = 0.obs;

//   final List<Map<String, String>> onboardingData = [
//     {
//       'title': 'Endless Choices\nJust For You',
//       'subtitle': 'From daily basis to premium finds, explore the world of products curated to meet your every need.',
//     },
//     {
//       'title': 'Seamless Shopping\nExperience',
//       'subtitle': 'Browse, select, and purchase with ease. Our intuitive interface makes shopping a breeze.',
//     },
//     {
//       'title': 'Fast & Secure\nCheckout',
//       'subtitle': 'Complete your purchases quickly with our secure payment options and fast delivery.',
//     },
//   ];

//   void nextPage() {
//     if (currentPage.value < onboardingData.length - 1) {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     } else {
//       // Navigate to login/signup screen
//       Get.toNamed('/auth'); // Replace with your actual route
//     }
//   }

//   void skipOnboarding() {
//     Get.toNamed('/auth'); // Replace with your actual route
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     super.onClose();
//   }
// }