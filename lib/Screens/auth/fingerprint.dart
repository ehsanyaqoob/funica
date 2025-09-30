// import 'package:bounce/bounce.dart';
// import 'package:flutter/material.dart';
// import 'package:formify/constants/app_colors.dart';
// import 'package:formify/constants/app_sizes.dart';
// import 'package:formify/generated/assets.dart';
// import 'package:formify/views/bottom-navbar/bottomnavbar.dart';
// import 'package:formify/views/intial.dart';
// import 'package:formify/widget/common_image_view_widget.dart';
// import 'package:formify/widget/custom_appbar.dart';
// import 'package:formify/widget/my_text_widget.dart';
// import 'package:get/get.dart';

// class FingerPrintScreen extends StatefulWidget {
//   const FingerPrintScreen({super.key});

//   @override
//   State<FingerPrintScreen> createState() => _FingerPrintScreenState();
// }

// class _FingerPrintScreenState extends State<FingerPrintScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _opacityAnimation;
//   bool _isScanning = false;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat(reverse: true);

//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );

//     _opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _startScan() {
//     setState(() {
//       _isScanning = true;
//     });

//     // Simulate scanning process
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) {
//         setState(() {
//           _isScanning = false;
//         });
//         Get.offAll(() =>  InitialScreen(),
//       transition: Transition.circularReveal,
//       duration: const Duration(milliseconds: 500));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;

//     return Scaffold(
//       appBar: CustomAppBar(showLeading: true),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: isDark
//               ? LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [kBlack, kSecondaryColorDark.withOpacity(0.8)],
//                 )
//               : LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [kbackground, kWhite.withOpacity(0.7)],
//                 ),
//         ),
//         child: Padding(
//           padding: AppSizes.DEFAULT,
//           child: Column(
//             children: [
//               // Header Section
//               Column(
//                 children: [
//                   MyText(
//                     text: "Fingerprint ID".tr,
//                     color: kDynamicText(context),
//                     size: 28,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w800,
//                   ),
//                   const SizedBox(height: 16),
//                   MyText(
//                     text: "Place finger on the sensor to confirm your identity."
//                         .tr,
//                     size: 16,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w400,
//                     color: kDynamicText(context).withOpacity(0.7),
//                   ),
//                 ],
//               ),

//               const Spacer(),

//               // Fingerprint Scanner Graphic
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Outer glow effect
//                   if (_isScanning)
//                     AnimatedBuilder(
//                       animation: _animationController,
//                       builder: (context, child) {
//                         return Container(
//                           width: 200,
//                           height: 200,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: RadialGradient(
//                               colors: [
//                                 kDynamicPrimary(context).withOpacity(0.2),
//                                 kDynamicPrimary(context).withOpacity(0.1),
//                                 Colors.transparent,
//                               ],
//                               stops: const [0.1, 0.3, 1.0],
//                             ),
//                           ),
//                         );
//                       },
//                     ),

//                   // Scanner circle
//                   AnimatedBuilder(
//                     animation: _animationController,
//                     builder: (context, child) {
//                       return Transform.scale(
//                         scale: _scaleAnimation.value,
//                         child: Opacity(
//                           opacity: _opacityAnimation.value,
//                           child: Container(
//                             width: 160,
//                             height: 160,
//                             decoration: BoxDecoration(
//                               color: kDynamicContainer(context),
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: kDynamicPrimary(
//                                     context,
//                                   ).withOpacity(0.3),
//                                   blurRadius: 15,
//                                   spreadRadius: _isScanning ? 3 : 0,
//                                 ),
//                                 BoxShadow(
//                                   color: isDark
//                                       ? kBlack.withOpacity(0.5)
//                                       : kWhite.withOpacity(0.8),
//                                   blurRadius: 10,
//                                   spreadRadius: -5,
//                                   offset: const Offset(0, 5),
//                                 ),
//                               ],
//                             ),
//                             child: Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 // Scanner waves (only visible during scanning)
//                                 if (_isScanning)
//                                   AnimatedBuilder(
//                                     animation: _animationController,
//                                     builder: (context, child) {
//                                       return Container(
//                                         width: 140 * _animationController.value,
//                                         height:
//                                             140 * _animationController.value,
//                                         decoration: BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           border: Border.all(
//                                             color: kDynamicPrimary(context)
//                                                 .withOpacity(
//                                                   1 -
//                                                       _animationController
//                                                           .value,
//                                                 ),
//                                             width: 2,
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),

//                                 // Fingerprint icon
//                                 Icon(
//                                   Icons.fingerprint,
//                                   size: 70,
//                                   color: _isScanning
//                                       ? kDynamicPrimary(context)
//                                       : kDynamicIcon(context).withOpacity(0.7),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),

//               const Spacer(),

//               // Instructions text
//               AnimatedOpacity(
//                 opacity: _isScanning ? 0.7 : 1.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: MyText(
//                   text: _isScanning
//                       ? "Scanning...".tr
//                       : "Touch the sensor to authenticate".tr,
//                   size: 16,
//                   textAlign: TextAlign.center,
//                   weight: FontWeight.w500,
//                   color: kDynamicText(context).withOpacity(0.8),
//                 ),
//               ),

//               const SizedBox(height: 40),

//               // Action button
//               Bounce(
//                 onTap: _isScanning ? null : _startScan,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   decoration: BoxDecoration(
//                     color: _isScanning
//                         ? kGreyColor.withOpacity(0.5)
//                         : kDynamicPrimary(context),
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: _isScanning
//                         ? null
//                         : [
//                             BoxShadow(
//                               color: kDynamicPrimary(context).withOpacity(0.3),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       if (_isScanning)
//                         SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(kWhite),
//                           ),
//                         )
//                       else
//                         Icon(Icons.fingerprint, color: kWhite, size: 20),
//                       const SizedBox(width: 10),
//                       MyText(
//                         text: _isScanning
//                             ? "Authenticating...".tr
//                             : "Start Authentication".tr,
//                         size: 16,
//                         weight: FontWeight.w600,
//                         color: kWhite,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // Alternative option
//               TextButton(
//                 onPressed: () {
//                   // Handle alternative authentication method
//                 },
//                 child: MyText(
//                   text: "Use other method".tr,
//                   size: 14,
//                   weight: FontWeight.w500,
//                   color: kDynamicPrimary(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
