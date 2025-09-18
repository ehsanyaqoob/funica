// import '';

// class Authscreen extends StatefulWidget {
//   const Authscreen({super.key});

//   @override
//   State<Authscreen> createState() => _AuthscreenState();
// }

// class _AuthscreenState extends State<Authscreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // Background Image
//           Image.asset(
//             Assets.imagesgirlfindingproducts,
//             fit: BoxFit.cover,
//             cacheWidth: 1080,
//           ),

//           // Gradient Overlay
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.transparent, Colors.black],
//               ),
//             ),
//           ),

//           // Foreground Content
//           SafeArea(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     MyText(
//                       text: 'MarketFit',
//                       color: kPrimaryColor,
//                       size: 40,
//                       weight: FontWeight.bold,
//                     ),
//                     Gap(10),
//                     MyText(
//                       text: 'Everything You Need, Nothing You Don\'t'.tr,
//                       color: kWhite,
//                       size: 20,
//                       weight: FontWeight.bold,
//                     ),

//                     MyText(
//                       text:
//                           'Discover a world of products tailored to your needs. Shop smart, live better.'
//                               .tr,
//                       color: kWhite,
//                       size: 14,
//                       weight: FontWeight.w400,
//                       textAlign: TextAlign.center,
//                     ),
//                     Gap(30),

//                     // Usage in your button
//                     MyButtonWithIcon(
//                       text: 'Sign-In with email'.tr,
//                       icon: Icons.email,
//                       onTap: () {
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           backgroundColor: Colors.transparent,
//                           builder: (context) => EmailSignInBottomSheet(),
//                           enableDrag: true,
//                           isDismissible: false,
//                         );
//                       },
//                       color: kPrimaryColor,
//                       textColor: kWhite,
//                     ),

//                     Gap(20),
//                     MyButtonWithIcon(
//                       text: 'Sign-In with Google'.tr,
//                       icon: Icons.email,
                      

//                       onTap: () {
//                         // Handle sign-in with email
//                          DialogHelper.GoogleSignInDialog(context);
//                       },
//                       color: kWhite,
//                       textColor: kPrimaryColor,
//                     ),
//                     Gap(20),
//                     // Usage in your button
//                     MyButtonWithIcon(
//                       text: 'Sign-up with email'.tr,
//                       icon: Icons.email,
//                       onTap: () {
//                         showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           backgroundColor: Colors.transparent,
//                           builder: (context) => EmailSignUpBottomSheet(),
//                           enableDrag: true,

//                           isDismissible:
//                               false, // Prevent closing by tapping outside
//                         );
//                       },
//                       color: kPrimaryColor,
//                       textColor: kWhite,
//                     ),
//                     Gap(50),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
