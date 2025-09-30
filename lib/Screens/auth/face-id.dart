// import 'package:bounce/bounce.dart';
// import 'package:flutter/material.dart';
// import 'package:formify/constants/app_colors.dart';
// import 'package:formify/generated/assets.dart';
// import 'package:formify/widget/common_image_view_widget.dart';
// import 'package:formify/widget/my_text_widget.dart';
// import 'package:get/get.dart';

// class FaceIDScreen extends StatefulWidget {
//   const FaceIDScreen({super.key});

//   @override
//   State<FaceIDScreen> createState() => _FaceIDScreenState();
// }

// class _FaceIDScreenState extends State<FaceIDScreen> 
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
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
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
//         Get.back(result: true); // Return success result
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           if (!_isScanning) {
//             Get.back();
//           }
//         },
//         child: Stack(
//           children: [
//             // Background image
//             Positioned.fill(
//               child: Image.asset(
//                 Assets.imagesFacebg, 
//                 fit: BoxFit.cover,
//                 color: Colors.black.withOpacity(0.7),
//                 colorBlendMode: BlendMode.darken,
//               ),
//             ),

//             // Overlay image
//             Positioned.fill(
//               child: CommonImageView(
//                 imagePath: Assets.imagesSubtractFaceId,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             // Back button
//             Positioned(
//               top: 50,
//               left: 20,
//               child: Bounce(
//                 onTap: () {
//                   if (!_isScanning) {
//                     Get.back();
//                   }
//                 },
//                 child: Icon(
//                   Icons.arrow_back_rounded, 
//                   color: kWhite,
//                   size: 28,
//                 ),
//               ),
//             ),

//             // Main content
//             Positioned.fill(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Face ID oval with animation
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // Scanning effect
//                       if (_isScanning)
//                         AnimatedBuilder(
//                           animation: _animationController,
//                           builder: (context, child) {
//                             return Container(
//                               width: 200,
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: RadialGradient(
//                                   colors: [
//                                     kPrimaryColor.withOpacity(0.3),
//                                     kPrimaryColor.withOpacity(0.1),
//                                     Colors.transparent,
//                                   ],
//                                   stops: const [0.1, 0.3, 1.0],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
                      
//                       // Face oval
//                       AnimatedBuilder(
//                         animation: _animationController,
//                         builder: (context, child) {
//                           return Transform.scale(
//                             scale: _scaleAnimation.value,
//                             child: Opacity(
//                               opacity: _opacityAnimation.value,
//                               child: Container(
//                                 width: 200,
//                                 height: 250,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(100),
//                                   border: Border.all(
//                                     color: _isScanning 
//                                       ? kPrimaryColor 
//                                       : kWhite.withOpacity(0.8),
//                                     width: 3,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.face,
//                                   size: 80,
//                                   color: _isScanning 
//                                     ? kPrimaryColor 
//                                     : kWhite.withOpacity(0.7),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 40),

//                   // Title and instructions
//                   MyText(
//                     text: "Face ID".tr,
//                     size: 28,
//                     color: kWhite,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w700,
//                   ),

//                   const SizedBox(height: 16),

//                   MyText(
//                     text: _isScanning 
//                       ? "Scanning your face...".tr 
//                       : "Position your face in the oval".tr,
//                     size: 16,
//                     color: kWhite.withOpacity(0.9),
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w400,
//                   ),

//                   const SizedBox(height: 40),

//                   // Start scan button
//                   if (!_isScanning)
//                     Bounce(
//                       onTap: _startScan,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                         decoration: BoxDecoration(
//                           color: kPrimaryColor,
//                           borderRadius: BorderRadius.circular(25),
//                           boxShadow: [
//                             BoxShadow(
//                               color: kPrimaryColor.withOpacity(0.4),
//                               blurRadius: 10,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Icon(
//                               Icons.face_retouching_natural,
//                               color: kWhite,
//                               size: 20,
//                             ),
//                             const SizedBox(width: 8),
//                             MyText(
//                               text: "Start Face ID".tr,
//                               size: 16,
//                               weight: FontWeight.w600,
//                               color: kWhite,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                   // Scanning indicator
//                   if (_isScanning)
//                     Column(
//                       children: [
//                         SizedBox(
//                           width: 30,
//                           height: 30,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(kWhite),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         MyText(
//                           text: "Please hold still...".tr,
//                           size: 14,
//                           color: kWhite.withOpacity(0.8),
//                           textAlign: TextAlign.center,
//                           weight: FontWeight.w400,
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }