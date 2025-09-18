// import 'package:formify/constants/export.dart';
// import 'package:formify/widget/home-widgets/home-infocard.dart';
// import 'package:formify/widget/home-widgets/shops-widgets.dart';
// import 'package:formify/widget/my_textfeild.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kDynamicScaffoldBackground(context),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: AppSizes.DEFAULT,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Gap(20),
//               // Info card for user information
//               HomeInfoCard(
//                 username: "Welcome Back",
//                 fullName: "sw.Sophia 📌",
//                 profileImage: Assets.imagesprofilepicture,
//                 onCartTap: () {},
//               ),
//               Gap(20),
//               MyTextField(
//                 radius: 16.0,
//                 marginBottom: 20,
//                 prefix: Image.asset(
//                   Assets.imagessearchicon,
//                   height: 16.0,
//                   width: 16.0,
//                 ),
//                 hint: "what's on your list?",
//                 keyboardType: TextInputType.text,
//                 filledColor: kDynamicBackground(context),
//                 focusedFillColor: kDynamicPrimary(context),
//                 suffix: Image.asset(
//                   Assets.imagesfiltericon,
//                   height: 16.0,
//                   width: 16.0,
//                 ),
//               ),

//               MyText(
//                 text: 'Shops to get started',
//                 color: kDynamicText(context),
//                 size: 20,
//                 weight: FontWeight.bold,
//                 letterSpacing: 0.2,
//               ),
//               SizedBox(
//                 height: 250,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     ShopCard(
//                       title: "Nike Footwear",
//                       image1: Assets.imagesAcRepair,
//                       image2: Assets.imagesAcRepair,
//                       image3: Assets.imagesAcRepair,
//                       image4: Assets.imagesAcRepair,
//                       logo: Assets.imagesAcRepair,
//                       rating: 4.9,
//                       reviews: 201452,
//                       onFollow: () {
//                         print("Follow clicked");
//                       },
//                     ),
//                     ShopCard(
//                       title: "Adidas Originals",
//                       image1: Assets.imagesAcRepair,
//                       image2: Assets.imagesAcRepair,
//                       image3: Assets.imagesAcRepair,
//                       image4: Assets.imagesAcRepair,
//                       logo: Assets.imagesAcRepair,
//                       rating: 4.8,
//                       reviews: 154210,
//                       onFollow: () {},
//                     ),
//                   ],
//                 ),
//               ),

//               Gap(10),
//               MyText(
//                 text: 'Special Offers!',
//                 color: kDynamicText(context),
//                 size: 20,
//                 weight: FontWeight.bold,
//                 letterSpacing: 0.2,
//               ),
//               Gap(10),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
