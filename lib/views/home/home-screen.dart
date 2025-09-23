import 'package:funica/constants/export.dart';
import 'package:funica/controller/profile-data-cont.dart';
import 'package:funica/models/category-model.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/views/category/category-details-screen.dart';
import 'package:funica/views/home/fav-screen.dart';
import 'package:funica/views/home/noification-screen.dart';
import 'package:funica/views/home/promo-details-screen.dart';
import 'package:funica/views/home/special-offers.dart';
import 'package:funica/views/profile/fill-up-profile-details.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/home-widgets/category-grid.dart';
import 'package:funica/widget/home-widgets/home-infocard.dart';
import 'package:funica/widget/home-widgets/promo-offers-card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FillUpProfileController controller = Get.put(FillUpProfileController());
  late final List<CategoryModel> categories;

  @override
  void initState() {
    super.initState();

    final sofa = CategoryModel(
      icon: Assets.sofa,
      title: "Sofa",
      products: [
        ProductModel(title: "Luxury Sofa", image: Assets.sofa, price: "\$250"),
        ProductModel(title: "Modern Sofa", image: Assets.sofa, price: "\$320"),
      ],
    );

    final chair = CategoryModel(
      icon: Assets.chair,
      title: "Chair",
      products: [
        ProductModel(
          title: "Wooden Chair",
          image: Assets.chair,
          price: "\$120",
        ),
        ProductModel(
          title: "Office Chair",
          image: Assets.chair,
          price: "\$180",
        ),
      ],
    );

    final table = CategoryModel(
      icon: Assets.table,
      title: "Table",
      products: [
        ProductModel(
          title: "Dining Table",
          image: Assets.table,
          price: "\$400",
        ),
        ProductModel(
          title: "Coffee Table",
          image: Assets.table,
          price: "\$150",
        ),
      ],
    );

    final kitchen = CategoryModel(
      icon: Assets.kitchen,
      title: "Kitchen",
      products: [
        ProductModel(
          title: "Cookware Set",
          image: Assets.kitchen,
          price: "\$200",
        ),
        ProductModel(title: "Knife Set", image: Assets.kitchen, price: "\$80"),
      ],
    );

    final lamp = CategoryModel(
      icon: Assets.lamp,
      title: "Lamp",
      products: [
        ProductModel(title: "Table Lamp", image: Assets.lamp, price: "\$60"),
        ProductModel(title: "Floor Lamp", image: Assets.lamp, price: "\$120"),
      ],
    );

    final cupboard = CategoryModel(
      icon: Assets.cupboard,
      title: "Cupboard",
      products: [
        ProductModel(
          title: "Wooden Cupboard",
          image: Assets.cupboard,
          price: "\$300",
        ),
        ProductModel(
          title: "Glass Cupboard",
          image: Assets.cupboard,
          price: "\$450",
        ),
      ],
    );

    final vase = CategoryModel(
      icon: Assets.vase,
      title: "Vase",
      products: [
        ProductModel(title: "Ceramic Vase", image: Assets.vase, price: "\$40"),
        ProductModel(title: "Glass Vase", image: Assets.vase, price: "\$55"),
      ],
    );

    categories = [sofa, chair, table, kitchen, lamp, cupboard, vase];

    // Add Others (special)
    categories.add(
      CategoryModel(
        icon: Assets.more,
        title: "Others",
        products: [],
        isOthers: true,
      ),
    );
  }

  final promoItems = [
    PromoCardModel(
      discount: "25%",
      title: "Today's Special!",
      subtitle: "Get discount for every order. Only valid for today.",
      image: Assets.promosofa,
    ),
    PromoCardModel(
      discount: "10%",
      title: "Weekend Sale!",
      subtitle: "Enjoy 10% off all furniture this weekend.",
      image: Assets.promosofa,
    ),
    PromoCardModel(
      discount: "15%",
      title: "Mega Sale!",
      subtitle: "Limited time offer across categories.",
      image: Assets.promosofa,
    ),
  ];

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
            backgroundColor: kDynamicScaffoldBackground(context),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: AppSizes.DEFAULT,
                child: Column(
                  children: [
                    // user info Row
                    UserInfoRow(
                      onAvatarTap: () {
                        Get.to(
                          () => FillUpProfileDetailScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(microseconds: 500),
                        );
                      },
                      onNotificationTap: () {
                        // Handle notification tap
                        Get.to(
                          () => NotificationScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(microseconds: 500),
                        );
                      },
                      onFavoriteTap: () {
                        // Handle favorite tap
                        Get.to(
                          () => FavouroteScreen(),
                          transition: Transition.leftToRight,
                          duration: Duration(microseconds: 500),
                        );
                      },
                    ),
                    Gap(20),
                    MyTextField(
                      keyboardType: TextInputType.name,
                      hint: 'Search',
                      prefix: SvgPicture.asset(
                        Assets.searchunfilled,
                        height: 20,
                        color: kDynamicIcon(context),
                      ),
                      suffix: SvgPicture.asset(
                        Assets.filter,
                        height: 20,
                        color: kDynamicIcon(context),
                      ),
                    ),
                    Gap(5.0),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              text: 'Special Offers',
                              size: 18,
                              weight: FontWeight.bold,
                              color: kDynamicText(context),
                            ),
                            Bounce(
                              onTap: () {
                                Get.to(
                                  () => SpecialOffersView(items: promoItems),
                                );
                              },
                              child: MyText(
                                text: 'See All',
                                size: 14,
                                weight: FontWeight.w600,
                                color: kDynamicText(context),
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        SwipeablePromoCards(
                          items: promoItems,
                          onCardTap: (index, item) {
                            Get.to(() => PromoDetailView(item: item));
                          },
                        ),
                      ],
                    ),

                    Gap(20),
                    CategoryGrid(
                      items: categories,
                      onTap: (i, item) => Get.to(
                        () => CategoryDetailsView(
                          category: item,
                          allCategories: categories,
                        ),
                      ),
                    ),
                    Gap(30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
