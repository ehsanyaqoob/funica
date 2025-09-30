import 'package:funica/constants/export.dart';
import 'package:funica/controller/profile-data-cont.dart';
import 'package:funica/models/category-model.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/Screens/category/category-details-screen.dart';
import 'package:funica/Screens/home/categories-tabbar.dart';
import 'package:funica/Screens/home/fav-screen.dart';
import 'package:funica/Screens/home/noification-screen.dart';
import 'package:funica/Screens/home/promo-details-screen.dart';
import 'package:funica/Screens/home/special-offers.dart';
import 'package:funica/Screens/profile/fill-up-profile-details.dart';
import 'package:funica/widget/home-widgets/category-grid.dart';
import 'package:funica/widget/home-widgets/home-infocard.dart';
import 'package:funica/widget/home-widgets/promo-offers-card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final FillUpProfileController controller = Get.put(FillUpProfileController());
  late final TabController _tabController;
  late final List<CategoryModel> _allCategories;

  @override
  void initState() {
    super.initState();

    _allCategories = _createAllCategories();
    _tabController = TabController(length: _allCategories.length, vsync: this);
  }

  List<CategoryModel> _createAllCategories() {
    final sofaProducts = [
      ProductModel(
        title: "Mid Century Sofa 1",
        image: Assets.midcenturysofa,
        price: "\$250",
      ),
      ProductModel(
        title: "Mid Century Sofa 2",
        image: Assets.midcenturysofa2,
        price: "\$320",
      ),
      ProductModel(
        title: "Lowson Sofa 1",
        image: Assets.lowsonsofa,
        price: "\$250",
      ),
      ProductModel(
        title: "Lowson Sofa 2",
        image: Assets.lowsonsofa2,
        price: "\$320",
      ),
      ProductModel(
        title: "Tuxedo Sofa 1",
        image: Assets.tuxedosofa,
        price: "\$250",
      ),
      ProductModel(
        title: "Tuxedo Sofa 2",
        image: Assets.tuxedosofa,
        price: "\$320",
      ),
    ];

    final chairProducts = [
      ProductModel(title: "Wooden Chair", image: Assets.chair1, price: "\$120"),
      ProductModel(title: "Office Chair", image: Assets.chair2, price: "\$180"),
      ProductModel(
        title: "Relaxing Chair",
        image: Assets.chair3,
        price: "\$200",
      ),
      ProductModel(title: "Office Chair", image: Assets.chair4, price: "\$280"),
      ProductModel(title: "Wooden Chair", image: Assets.chair5, price: "\$40"),
      ProductModel(title: "Office Chair", image: Assets.chair6, price: "\$580"),
    ];

    final tableProducts = [
      ProductModel(title: "Dining Table", image: Assets.table1, price: "\$400"),
      ProductModel(title: "Coffee Table", image: Assets.table2, price: "\$150"),
      ProductModel(title: "Dining Table", image: Assets.table3, price: "\$400"),
      ProductModel(title: "Coffee Table", image: Assets.table3, price: "\$150"),
      ProductModel(title: "Dining Table", image: Assets.table4, price: "\$400"),
      ProductModel(title: "Coffee Table", image: Assets.table4, price: "\$150"),
    ];

    final kitchenProducts = [
      ProductModel(
        title: "Cookware Set",
        image: Assets.kitchen1,
        price: "\$200",
      ),
      ProductModel(title: "Knife Set", image: Assets.kitchen1, price: "\$80"),
      ProductModel(
        title: "Cookware Set",
        image: Assets.kitchen1,
        price: "\$200",
      ),
      ProductModel(title: "Knife Set", image: Assets.kitchen1, price: "\$80"),
      ProductModel(
        title: "Cookware Set",
        image: Assets.kitchen1,
        price: "\$200",
      ),
      ProductModel(title: "Knife Set", image: Assets.kitchen1, price: "\$80"),
    ];

    final lampProducts = [
      ProductModel(title: "Table Lamp", image: Assets.lamp1, price: "\$60"),
      ProductModel(title: "Floor Lamp", image: Assets.lamp2, price: "\$120"),
      ProductModel(title: "Table Lamp", image: Assets.lamp3, price: "\$60"),
      ProductModel(title: "Floor Lamp", image: Assets.lamp2, price: "\$120"),
      ProductModel(title: "Table Lamp", image: Assets.lamp4, price: "\$60"),
      ProductModel(title: "Floor Lamp", image: Assets.lamp2, price: "\$120"),
    ];

    final cupboardProducts = [
      ProductModel(
        title: "Wooden Cupboard",
        image: Assets.cupboard1,
        price: "\$300",
      ),
      ProductModel(
        title: "Glass Cupboard",
        image: Assets.cupboard2,
        price: "\$450",
      ),
      ProductModel(
        title: "Wooden Cupboard",
        image: Assets.cupboard3,
        price: "\$300",
      ),
      ProductModel(
        title: "Glass Cupboard",
        image: Assets.cupboard1,
        price: "\$450",
      ),
      ProductModel(
        title: "Wooden Cupboard",
        image: Assets.cupboard3,
        price: "\$300",
      ),
      ProductModel(
        title: "Glass Cupboard",
        image: Assets.cupboard2,
        price: "\$450",
      ),
    ];

    final vaseProducts = [
      ProductModel(title: "Ceramic Vase", image: Assets.vase1, price: "\$40"),
      ProductModel(title: "Glass Vase", image: Assets.vase2, price: "\$55"),
      ProductModel(title: "Ceramic Vase", image: Assets.vase3, price: "\$40"),
      ProductModel(title: "Glass Vase", image: Assets.vase2, price: "\$55"),
      ProductModel(title: "Ceramic Vase", image: Assets.vase1, price: "\$40"),
      ProductModel(title: "Glass Vase", image: Assets.vase3, price: "\$55"),
    ];

    final sofa = CategoryModel(
      icon: Assets.sofa,
      title: "Sofa",
      products: sofaProducts,
    );
    final chair = CategoryModel(
      icon: Assets.chair,
      title: "Chair",
      products: chairProducts,     

    );
    final table = CategoryModel(
      icon: Assets.table,
      title: "Table",
      products: tableProducts,     

    );
    final kitchen = CategoryModel(
      icon: Assets.kitchen,
      title: "Kitchen",
      products: kitchenProducts,     

    );
    final lamp = CategoryModel(
      icon: Assets.lamp,
      title: "Lamp",
      products: lampProducts,      

    );
    final cupboard = CategoryModel(
      icon: Assets.cupboard,
      title: "Cupboard",
      products: cupboardProducts,     

    );
    final vase = CategoryModel(
      icon: Assets.vase,
      title: "Vase",
      products: vaseProducts,     

    );
    final others = CategoryModel(
      icon: Assets.more,
      title: "Others",
      products: [],
      isOthers: true,      

    );

    final allProducts = [
      ...sofaProducts,
      ...chairProducts,
      ...tableProducts,
      ...kitchenProducts,
      ...lampProducts,
      ...cupboardProducts,
      ...vaseProducts,
    ];

    final allTab = CategoryModel(
      icon: Assets.more,
      title: "All",
      products: allProducts,      

    );

    print("🛋️ Sofa created with ${sofa.products.length} products");
    print("📊 All tab created with ${allTab.products.length} products");

    return [allTab, sofa, chair, table, kitchen, lamp, cupboard, vase, others];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      image: Assets.promolamps,
    ),
    PromoCardModel(
      discount: "15%",
      title: "Mega Sale!",
      subtitle: "Limited time offer across categories.",
      image: Assets.promochair,
    ),
    PromoCardModel(
      discount: "15%",
      title: "Mega Sale!",
      subtitle: "Limited time offer across categories.",
      image: Assets.promochair2,
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
                scrollDirection: Axis.vertical,
                padding: AppSizes.DEFAULT,
                child: Column(
                  children: [
                    UserInfoRow(
                      onAvatarTap: () => Get.to(
                        () => FillUpProfileDetailScreen(),
                        transition: Transition.leftToRight,
                      ),
                      onNotificationTap: () => Get.to(
                        () => NotificationScreen(),
                        transition: Transition.leftToRight,
                      ),
                      onFavoriteTap: () => Get.to(
                        () => FavouroteScreen(),
                        transition: Transition.leftToRight,
                      ),
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
                          onTap: () => Get.to(
                            () => SpecialOffersView(items: promoItems),
                          ),
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
                      onCardTap: (index, item) =>
                          Get.to(() => PromoDetailView(item: item)),
                    ),
                    Gap(20),
                    CategoryGrid(
                      items: _allCategories.skip(1).toList(),
                      onTap: (index, category) {
                        print(
                          "🎯 Tapped: ${category.title}, products: ${category.products.length}, hashCode: ${category.hashCode}",
                        );
                        Get.to(
                          () => CategoryDetailsView(
                            category: category,
                            allCategories: _allCategories.skip(1).toList(),
                          ),
                        );
                      },
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Most Popular',
                          size: 18,
                          weight: FontWeight.bold,
                          color: kDynamicText(context),
                        ),
                        Bounce(
                          onTap: () => Get.to(
                            () => SpecialOffersView(items: promoItems),
                          ),
                          child: MyText(
                            text: 'See All',
                            size: 14,
                            weight: FontWeight.w600,
                            color: kDynamicText(context),
                          ),
                        ),
                      ],
                    ),
                    Gap(10),
                    CategoryTabBarRow(
                      categories: _allCategories,
                      onCategorySelected: (selectedCategory) {
                        print(
                          'Selected category: ${selectedCategory.title}, products: ${selectedCategory.products.length}',
                        );
                      },
                    ),
                    Gap(20),
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
