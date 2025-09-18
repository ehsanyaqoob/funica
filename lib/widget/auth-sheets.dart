// import 'package:funica/constants/export.dart';

// import 'package:gap/gap.dart';
// class GenericBottomSheet extends StatelessWidget {
//   final String title;
//   final List<Widget> children;
//   final VoidCallback onClose;
//   final bool isScrollControlled;

//   const GenericBottomSheet({
//     super.key,
//     required this.title,
//     required this.children,
//     required this.onClose,
//     this.isScrollControlled = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.9,
//       ),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: kWhite,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(30),
//           topRight: Radius.circular(30),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Drag handle
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               height: 4,
//               width: 60,
//               decoration: BoxDecoration(
//                 color: Colors.grey[400],
//                 borderRadius: BorderRadius.circular(24),
//               ),
//             ),
//           ),
//           const Gap(20),

//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               MyText(
//                 text: title,
//                 size: 24,
//                 weight: FontWeight.bold,
//                 color: kPrimaryColor,
//               ),
//               Bounce(
//                 onTap: onClose,
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: kSubText.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.close, size: 24, color: kPrimaryColor),
//                 ),
//               ),
//             ],
//           ),
//           const Gap(20),

//           // ✅ Scrollable + keyboard safe content
//           Expanded(
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: children,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class EmailSignInBottomSheet extends StatelessWidget {
//   EmailSignInBottomSheet({
//     super.key,
//     this.onFaceIDPressed,
//     this.onFingerprintPressed,
//   });

//   final VoidCallback? onFaceIDPressed;
//   final VoidCallback? onFingerprintPressed;
//   //final AuthController authController = Get.put(AuthController());

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: GenericBottomSheet(
//         title: "Sign In with Email".tr,
//         onClose: () => Navigator.pop(context),
//         children: [
//           MyButtonWithIcon(
//             text: 'Sign-In with Google'.tr,
//             icon: Icons.email,
//             onTap: () {
//               DialogHelper.GoogleSignInDialog(context);
//             },
//             color: kPrimaryColor,
//             textColor: kDynamicText(context),
//           ),
//           const Gap(20),
          
//           // Divider with "or"
//           Row(
//             children: [
//               Expanded(
//                 child: Divider(color: kSubText.withOpacity(0.3), thickness: 1),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: MyText(
//                   text: "or use".tr,
//                   size: 16,
//                   color: kPrimaryColor,
//                   weight: FontWeight.w500,
//                 ),
//               ),
//               Expanded(
//                 child: Divider(color: kSubText.withOpacity(0.3), thickness: 1),
//               ),
//             ],
//           ),
//           const Gap(20),
          
//           // Email Field
//           MyText(
//             text: "Email Address".tr,
//             size: 14,
//             paddingBottom: 8,
//             color: kBlack,
//             weight: FontWeight.w600,
//           ),
//           MyTextField(
//             controller: authController.emailController,
//             hint: "example@gmail.com".tr,
//             keyboardType: TextInputType.emailAddress,
//             filledColor: Colors.grey[100],
//             focusedFillColor: Colors.grey[100],
//           ),
//           const Gap(16),

//           // Password Field
//           MyText(
//             text: "Password".tr,
//             size: 14,
//             paddingBottom: 8,
//             color: kBlack,
//             weight: FontWeight.w600,
//           ),
//           Obx(
//             () => MyTextField(
//               controller: authController.passwordController,
//               hint: "Enter your password".tr,
//               isObSecure: authController.obscurePassword.value,
//               filledColor: Colors.grey[100],
//               focusedFillColor: Colors.grey[100],
//               suffix: IconButton(
//                 icon: Icon(
//                   authController.obscurePassword.value
//                       ? Icons.visibility_off_outlined
//                       : Icons.visibility_outlined,
//                   color: kSubText.withOpacity(0.7),
//                 ),
//                 onPressed: () {
//                   authController.togglePasswordVisibility();
//                 },
//               ),
//             ),
//           ),
//           const Gap(16),

//           // Remember Me & Forgot Password
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Obx(
//                     () => Checkbox(
//                       value: authController.rememberMe.value,
//                       onChanged: authController.toggleRememberMe,
//                       activeColor: kPrimaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                         side: BorderSide(color: kSubText.withOpacity(0.3)),
//                       ),
//                     ),
//                   ),
//                   MyText(
//                     text: "Remember me".tr,
//                     size: 14,
//                     color: kBlack,
//                     weight: FontWeight.w500,
//                   ),
//                 ],
//               ),
//               Bounce(
//                 onTap: () {
//                   // Handle forgot password
//                 },
//                 child: MyText(
//                   text: "Forgot Password?".tr,
//                   size: 14,
//                   color: kPrimaryColor,
//                   weight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const Gap(24),

//           // Sign In Button
//           Obx(
//             () => SizedBox(
//               width: double.infinity,
//               child: MyButton(
//                 onTap: authController.isLoading.value
//                     ? null
//                     : () async {
//                         final success = await authController.login(
//                           authController.emailController.text.trim(),
//                           authController.passwordController.text.trim(),
//                         );
//                       },
//                 buttonText: authController.isLoading.value
//                     ? "Signing In...".tr
//                     : "Sign In".tr,
//                 backgroundColor: kPrimaryColor,
//                 fontColor: kWhite,
//                 isLoading: authController.isLoading.value,
//                 height: 50,
//                 radius: 12,
//               ),
//             ),
//           ),
//           const Gap(24),

//           // Divider with "or"
//           Row(
//             children: [
//               Expanded(
//                 child: Divider(color: kSubText.withOpacity(0.3), thickness: 1),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: MyText(
//                   text: "or use".tr,
//                   size: 16,
//                   color: kPrimaryColor,
//                   weight: FontWeight.w500,
//                 ),
//               ),
//               Expanded(
//                 child: Divider(color: kSubText.withOpacity(0.3), thickness: 1),
//               ),
//             ],
//           ),
//           const Gap(24),

//           // Biometric Options
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildBiometricOption(
//                 context,
//                 icon: Icons.face,
//                 text: "Face ID".tr,
//                 onTap: onFaceIDPressed ??
//                     () {
//                       Get.to(
//                         () => FaceIDScreen(),
//                         transition: Transition.rightToLeftWithFade,
//                         duration: const Duration(milliseconds: 500),
//                       );
//                     },
//               ),
//               _buildBiometricOption(
//                 context,
//                 icon: Icons.fingerprint,
//                 text: "Fingerprint".tr,
//                 onTap: onFingerprintPressed ??
//                     () {
//                       Get.to(
//                         () => FingerPrintScreen(),
//                         transition: Transition.rightToLeftWithFade,
//                         duration: const Duration(milliseconds: 500),
//                       );
//                     },
//               ),
//             ],
//           ),
//           const Gap(16),
//         ],
//       ),
//     );
//   }

//   Widget _buildBiometricOption(BuildContext context, {
//     required IconData icon,
//     required String text,
//     required VoidCallback onTap,
//   }) {
//     return Bounce(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: kPrimaryColor.withOpacity(0.08),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: kPrimaryColor.withOpacity(0.2),
//                 width: 1,
//               ),
//             ),
//             child: Icon(icon, size: 30, color: kPrimaryColor),
//           ),
//           const Gap(8),
//           MyText(
//             text: text,
//             size: 12,
//             color: kDynamicText(context),
//             weight: FontWeight.w500,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EmailSignUpBottomSheet extends StatefulWidget {
//   EmailSignUpBottomSheet({super.key});

//   @override
//   State<EmailSignUpBottomSheet> createState() => _EmailSignUpBottomSheetState();
// }

// class _EmailSignUpBottomSheetState extends State<EmailSignUpBottomSheet> {
//   final AuthController authController = Get.put(AuthController());
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToBottom() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (_scrollController.hasClients) {
//         _scrollController.animateTo(
//           _scrollController.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeOut,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: GenericBottomSheet(
//         title: "Create Account".tr,
//         onClose: () => Navigator.pop(context),
//         isScrollControlled: true,
//         children: [
//           // Wrapping in SingleChildScrollView with controller for better control
//           SingleChildScrollView(
//             controller: _scrollController,
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 MyButtonWithIcon(
//                   text: 'Sign-In with Google'.tr,
//                   icon: Icons.email,
//                   onTap: () {
//                     DialogHelper.GoogleSignInDialog(context);
//                   },
//                   color: kPrimaryColor,
//                   textColor: kDynamicText(context),
//                 ),
//                 const Gap(20),

//                 // Divider with "or"
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Divider(
//                         color: kSubText.withOpacity(0.3),
//                         thickness: 1,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: MyText(
//                         text: "or use".tr,
//                         size: 16,
//                         color: kPrimaryColor,
//                         weight: FontWeight.w500,
//                       ),
//                     ),
//                     Expanded(
//                       child: Divider(
//                         color: kSubText.withOpacity(0.3),
//                         thickness: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Gap(20),

//                 // Name Field
//                 MyText(
//                   text: "Full Name".tr,
//                   size: 14,
//                   paddingBottom: 8,
//                   color: kBlack,
//                   weight: FontWeight.w600,
//                 ),
//                 MyTextField(
//                   controller: authController.nameController,
//                   hint: "Enter your full name".tr,
//                   keyboardType: TextInputType.name,
//                   filledColor: Colors.grey[100],
//                   focusedFillColor: Colors.grey[100],
//                   onTap: _scrollToBottom,
//                 ),
//                 const Gap(16),

//                 // Email Field
//                 MyText(
//                   text: "Email Address".tr,
//                   size: 14,
//                   paddingBottom: 8,
//                   color: kBlack,
//                   weight: FontWeight.w600,
//                 ),
//                 MyTextField(
//                   controller: authController.emailController,
//                   hint: "example@gmail.com".tr,
//                   keyboardType: TextInputType.emailAddress,
//                   filledColor: Colors.grey[100],
//                   focusedFillColor: Colors.grey[100],
//                   onTap: _scrollToBottom,
//                 ),
//                 const Gap(16),

//                 // Password Field
//                 MyText(
//                   text: "Password".tr,
//                   size: 14,
//                   paddingBottom: 8,
//                   color: kBlack,
//                   weight: FontWeight.w600,
//                 ),
//                 Obx(
//                   () => MyTextField(
//                     controller: authController.passwordController,
//                     hint: "Create a strong password".tr,
//                     isObSecure: authController.obscurePassword.value,
//                     filledColor: Colors.grey[100],
//                     focusedFillColor: Colors.grey[100],
//                     onTap: _scrollToBottom,
//                     suffix: IconButton(
//                       icon: Icon(
//                         authController.obscurePassword.value
//                             ? Icons.visibility_off_outlined
//                       : Icons.visibility_outlined,
//                         color: kSubText.withOpacity(0.7),
//                       ),
//                       onPressed: () {
//                         authController.togglePasswordVisibility();
//                       },
//                     ),
//                   ),
//                 ),
//                 const Gap(16),

//                 // Terms and Conditions
//                 Row(
//                   children: [
//                     Obx(
//                       () => Checkbox(
//                         value: authController.agreeToTerms.value,
//                         onChanged: authController.toggleAgreeToTerms,
//                         activeColor: kPrimaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                           side: BorderSide(color: kSubText.withOpacity(0.3)),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Wrap(
//                         children: [
//                           MyText(
//                             text: "I agree to the ".tr,
//                             size: 14,
//                             color: kBlack,
//                             weight: FontWeight.w500,
//                           ),
//                           Bounce(
//                             onTap: () {
//                               // Navigate to terms and conditions
//                             },
//                             child: MyText(
//                               text: "Terms & Conditions".tr,
//                               size: 14,
//                               color: kPrimaryColor,
//                               weight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Gap(24),

//                 // Sign Up Button
//                 Obx(
//                   () => SizedBox(
//                     width: double.infinity,
//                     child: MyButton(
//                       onTap: authController.isLoading.value
//                           ? null
//                           : () async {
//                               final success = await authController.signup(
//                                 authController.nameController.text.trim(),
//                                 authController.emailController.text.trim(),
//                                 authController.passwordController.text.trim(),
//                               );
//                             },
//                       buttonText: authController.isLoading.value
//                           ? "Creating Account...".tr
//                           : "Create Account".tr,
//                       backgroundColor: kPrimaryColor,
//                       fontColor: kWhite,
//                       isLoading: authController.isLoading.value,
//                       height: 50,
//                       radius: 12,
//                     ),
//                   ),
//                 ),
//                 const Gap(16),

//                 // Already have an account
//                 Center(
//                   child: Bounce(
//                     onTap: () {
//                       Navigator.pop(context);
//                       // Show login sheet instead
//                     },
//                     child: RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: "Already have an account? ".tr,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: kBlack,
//                               fontWeight: FontWeight.w500,
//                               fontFamily: 'Figtree',
//                             ),
//                           ),
//                           TextSpan(
//                             text: "Sign In".tr,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: kPrimaryColor,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: 'Figtree',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Gap(16),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }