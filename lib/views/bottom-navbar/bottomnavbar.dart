// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:formify/constants/app_colors.dart';
// import 'package:formify/generated/assets.dart';
// import 'package:formify/views/home/categories-section.dart';
// import 'package:formify/views/home/home-screen.dart';
// import 'package:formify/views/home/cart-screen.dart';
// import 'package:formify/views/home/profile-screen.dart';
// import 'package:get/get.dart';

// class NavController extends GetxController {
//   var currentIndex = 0.obs;
//   void changeTab(int index) => currentIndex.value = index;
// }

// class NavItem {
//   final String activeIconPath;
//   final String inactiveIconPath;
//   final Widget page;
//   final String label;

//   NavItem({
//     required this.activeIconPath,
//     required this.inactiveIconPath,
//     required this.page,
//     required this.label,
//   });
// }

// class MainNavigation extends StatelessWidget {
//   MainNavigation({super.key});

//   final NavController navController = Get.put(NavController());

//   // Define navigation items dynamically
//   final List<NavItem> _navItems = [
//     NavItem(
//       activeIconPath: Assets.imageshomeactive,
//       inactiveIconPath: Assets.imageshomeactive, // Add this asset
//       page: HomeScreen(key: const ValueKey("home")),
//       label: "Home",
//     ),
//     NavItem(
//       activeIconPath: Assets.imagescategoriesactive,
//       inactiveIconPath: Assets.imagescategoriesactive, // Add this asset
//       page: CategoriesScreen(key: const ValueKey("categories")),
//       label: "Categories",
//     ),
//     NavItem(
//       activeIconPath: Assets.imagescartactive,
//       inactiveIconPath: Assets.imagescartactive, // Add this asset
//       page: CartScreen(key: const ValueKey("cart")),
//       label: "Cart",
//     ),
//     NavItem(
//       activeIconPath: Assets.imagesArtistProfile, // Add this asset
//       inactiveIconPath: Assets.imagesArtistProfile, // Add this asset
//       page: ProfileScreen(key: const ValueKey("profile")),
//       label: "Profile",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       backgroundColor: kDynamicBackground(context),
//       child: Stack(
//         children: [
//           Obx(
//             () => AnimatedSwitcher(
//               duration: const Duration(milliseconds: 200),
//               child: _navItems[navController.currentIndex.value].page,
//             ),
//           ),

//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 70,
//               margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: BoxDecoration(
//                 color: kDynamicCard(context),
//                 borderRadius: BorderRadius.circular(40),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(
//                       Theme.of(context).brightness == Brightness.dark
//                           ? 0.3
//                           : 0.1,
//                     ),
//                     blurRadius: 10,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Obx(
//                 () => Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: _navItems.asMap().entries.map((entry) {
//                     final index = entry.key;
//                     final item = entry.value;
//                     if (index == _navItems.length - 1) {
//                       return _AvatarNavItem(
//                         imagePath: Assets.imagesArtistProfile,
//                         isSelected: navController.currentIndex.value == index,
//                         onTap: () => navController.changeTab(index),
//                         context: context,
//                       );
//                     } else {
//                       return _SvgNavBarItem(
//                         activeIconPath: item.activeIconPath,
//                         inactiveIconPath: item.inactiveIconPath,
//                         isSelected: navController.currentIndex.value == index,
//                         onTap: () => navController.changeTab(index),
//                         context: context,
//                       );
//                     }
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }class _SvgNavBarItem extends StatelessWidget {
//   final String activeIconPath;
//   final String inactiveIconPath;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final BuildContext context;

//   const _SvgNavBarItem({
//     required this.activeIconPath,
//     required this.inactiveIconPath,
//     required this.isSelected,
//     required this.onTap,
//     required this.context,
//   });

//   @override
//   Widget build(BuildContext ctx) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedScale(
//         scale: isSelected ? 1.15 : 1.0,
//         duration: const Duration(milliseconds: 250),
//         curve: Curves.easeOutBack,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: isSelected ? kDynamicPrimary(context) : Colors.transparent,
//               width: 2.5,
//             ),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: kDynamicPrimary(context).withOpacity(0.4),
//                       blurRadius: 12,
//                       spreadRadius: 1.5,
//                     ),
//                   ]
//                 : [],
//             gradient: isSelected
//                 ? LinearGradient(
//                     colors: [
//                       kDynamicPrimary(context).withOpacity(0.9),
//                       kDynamicPrimary(context).withOpacity(0.6),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                 : null,
//           ),
//           child: Image.asset(
//             isSelected ? activeIconPath : inactiveIconPath,
//             width: 22,
//             height: 22,
//             color: isSelected
//                 ? Colors.white 
//                 : kDynamicIcon(context),
//             colorBlendMode: BlendMode.srcIn,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _AvatarNavItem extends StatelessWidget {
//   final String imagePath;
//   final bool isSelected;
//   final VoidCallback onTap;
//   final BuildContext context;

//   const _AvatarNavItem({
//     required this.imagePath,
//     required this.isSelected,
//     required this.onTap,
//     required this.context,
//   });

//   @override
//   Widget build(BuildContext ctx) {
//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedScale(
//         scale: isSelected ? 1.2 : 1.0,
//         duration: const Duration(milliseconds: 200),
//         child: Container(
//           padding: const EdgeInsets.all(6),
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: isSelected ? kDynamicPrimary(context) : Colors.transparent,
//               width: 2,
//             ),
//           ),
//           child: CircleAvatar(
//             radius: 14,
//             backgroundColor: Theme.of(context).brightness == Brightness.dark
//                 ? kSecondaryColor2Dark
//                 : kSecondaryColor3,
//             backgroundImage: AssetImage(imagePath),
//           ),
//         ),
//       ),
//     );
//   }
// }
