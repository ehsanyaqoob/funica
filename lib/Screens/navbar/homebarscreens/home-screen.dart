import 'package:funica/Screens/navbar/homebarscreens/see-all-category-tabs.dart';
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
  late final TabController _tabController;
  List<CategoryModel> _allCategories = [];
  List<CategoryModel> _categoriesWithoutAll = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    try {
      // Use Future.microtask to avoid blocking the main thread
      await Future.microtask(() {
        _allCategories = _createAllCategories();
        _categoriesWithoutAll = _allCategories;
        _tabController = TabController(
          length: _allCategories.length,
          vsync: this,
        );
      });

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("❌ Error initializing data: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<CategoryModel> _createAllCategories() {
    // Create optimized product lists
    final List<List<ProductModel>> allProductLists = [
      // Sofa products
      [
        ProductModel(
          id: 'sofa_1',
          title: "Mid Century Sofa 1",
          image: Assets.midcenturysofa,
          price: "\$250",
        ),
        ProductModel(
          id: 'sofa_2',
          title: "Mid Century Sofa 2",
          image: Assets.midcenturysofa2,
          price: "\$320",
        ),
        ProductModel(
          id: 'sofa_3',
          title: "Lowson Sofa 1",
          image: Assets.lowsonsofa,
          price: "\$250",
        ),
        ProductModel(
          id: 'sofa_4',
          title: "Lowson Sofa 2",
          image: Assets.lowsonsofa2,
          price: "\$320",
        ),
        ProductModel(
          id: 'sofa_5',
          title: "Tuxedo Sofa 1",
          image: Assets.tuxedosofa,
          price: "\$250",
        ),
        ProductModel(
          id: 'sofa_6',
          title: "Tuxedo Sofa 2",
          image: Assets.tuxedosofa,
          price: "\$320",
        ),
      ],
      // Chair products
      [
        ProductModel(
          id: 'chair_1',
          title: "Wooden Chair",
          image: Assets.chair1,
          price: "\$120",
        ),
        ProductModel(
          id: 'chair_2',
          title: "Office Chair",
          image: Assets.chair2,
          price: "\$180",
        ),
        ProductModel(
          id: 'chair_3',
          title: "Relaxing Chair",
          image: Assets.chair3,
          price: "\$200",
        ),
        ProductModel(
          id: 'chair_4',
          title: "Office Chair",
          image: Assets.chair4,
          price: "\$280",
        ),
        ProductModel(
          id: 'chair_5',
          title: "Wooden Chair",
          image: Assets.chair5,
          price: "\$40",
        ),
        ProductModel(
          id: 'chair_6',
          title: "Office Chair",
          image: Assets.chair6,
          price: "\$580",
        ),
      ],
      // Table products
      [
        ProductModel(
          id: 'table_1',
          title: "Dining Table",
          image: Assets.table1,
          price: "\$400",
        ),
        ProductModel(
          id: 'table_2',
          title: "Coffee Table",
          image: Assets.table2,
          price: "\$150",
        ),
        ProductModel(
          id: 'table_3',
          title: "Dining Table",
          image: Assets.table3,
          price: "\$400",
        ),
        ProductModel(
          id: 'table_4',
          title: "Coffee Table",
          image: Assets.table3,
          price: "\$150",
        ),
        ProductModel(
          id: 'table_5',
          title: "Dining Table",
          image: Assets.table4,
          price: "\$400",
        ),
        ProductModel(
          id: 'table_6',
          title: "Coffee Table",
          image: Assets.table4,
          price: "\$150",
        ),
      ],
      // Kitchen products
      [
        ProductModel(
          id: 'kitchen_1',
          title: "Cookware Set",
          image: Assets.kitchen1,
          price: "\$200",
        ),
        ProductModel(
          id: 'kitchen_2',
          title: "Knife Set",
          image: Assets.kitchen1,
          price: "\$80",
        ),
        ProductModel(
          id: 'kitchen_3',
          title: "Cookware Set",
          image: Assets.kitchen1,
          price: "\$200",
        ),
        ProductModel(
          id: 'kitchen_4',
          title: "Knife Set",
          image: Assets.kitchen1,
          price: "\$80",
        ),
        ProductModel(
          id: 'kitchen_5',
          title: "Cookware Set",
          image: Assets.kitchen1,
          price: "\$200",
        ),
        ProductModel(
          id: 'kitchen_6',
          title: "Knife Set",
          image: Assets.kitchen1,
          price: "\$80",
        ),
      ],
      // Lamp products
      [
        ProductModel(
          id: 'lamp_1',
          title: "Table Lamp",
          image: Assets.lamp1,
          price: "\$60",
        ),
        ProductModel(
          id: 'lamp_2',
          title: "Floor Lamp",
          image: Assets.lamp2,
          price: "\$120",
        ),
        ProductModel(
          id: 'lamp_3',
          title: "Table Lamp",
          image: Assets.lamp3,
          price: "\$60",
        ),
        ProductModel(
          id: 'lamp_4',
          title: "Floor Lamp",
          image: Assets.lamp2,
          price: "\$120",
        ),
        ProductModel(
          id: 'lamp_5',
          title: "Table Lamp",
          image: Assets.lamp4,
          price: "\$60",
        ),
        ProductModel(
          id: 'lamp_6',
          title: "Floor Lamp",
          image: Assets.lamp2,
          price: "\$120",
        ),
      ],
      // Cupboard products
      [
        ProductModel(
          id: 'cupboard_1',
          title: "Wooden Cupboard",
          image: Assets.cupboard1,
          price: "\$300",
        ),
        ProductModel(
          id: 'cupboard_2',
          title: "Glass Cupboard",
          image: Assets.cupboard2,
          price: "\$450",
        ),
        ProductModel(
          id: 'cupboard_3',
          title: "Wooden Cupboard",
          image: Assets.cupboard3,
          price: "\$300",
        ),
        ProductModel(
          id: 'cupboard_4',
          title: "Glass Cupboard",
          image: Assets.cupboard1,
          price: "\$450",
        ),
        ProductModel(
          id: 'cupboard_5',
          title: "Wooden Cupboard",
          image: Assets.cupboard3,
          price: "\$300",
        ),
        ProductModel(
          id: 'cupboard_6',
          title: "Glass Cupboard",
          image: Assets.cupboard2,
          price: "\$450",
        ),
      ],
      // Vase products
      [
        ProductModel(
          id: 'vase_1',
          title: "Ceramic Vase",
          image: Assets.vase1,
          price: "\$40",
        ),
        ProductModel(
          id: 'vase_2',
          title: "Glass Vase",
          image: Assets.vase2,
          price: "\$55",
        ),
        ProductModel(
          id: 'vase_3',
          title: "Ceramic Vase",
          image: Assets.vase3,
          price: "\$40",
        ),
        ProductModel(
          id: 'vase_4',
          title: "Glass Vase",
          image: Assets.vase2,
          price: "\$55",
        ),
        ProductModel(
          id: 'vase_5',
          title: "Ceramic Vase",
          image: Assets.vase1,
          price: "\$40",
        ),
        ProductModel(
          id: 'vase_6',
          title: "Glass Vase",
          image: Assets.vase3,
          price: "\$55",
        ),
      ],
    ];
    final categoryTitles = [
      "All",
      "Sofa",
      "Chair",
      "Table",
      "Kitchen",
      "Lamp",
      "Cupboard",
      "Vase",
    ];
    final categoryIcons = [
      Assets.more,
      Assets.sofa,
      Assets.chair,
      Assets.table,
      Assets.kitchen,
      Assets.lamp,
      Assets.cupboard,
      Assets.vase,
    ];

    // Create all products list
    final allProducts = allProductLists.expand((list) => list).toList();

    // Create categories - put "All" at the end
    final categories = <CategoryModel>[
      // First add all specific categories
      for (int i = 1; i < categoryTitles.length; i++)
        CategoryModel(
          icon: categoryIcons[i],
          title: categoryTitles[i],
          products: allProductLists[i - 1],
        ),
      // Then add "All" category at the end
      CategoryModel(
        icon: categoryIcons[0],
        title: categoryTitles[0],
        products: allProducts,
      ),
    ];
    print("✅ Categories created: ${categories.length}");
    print("📊 All category has: ${allProducts.length} products");

    return categories;
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
          child: _isLoading
              ? const Center(child: CircularProgressIndicator()) // show loader
              : Scaffold(
                  backgroundColor: kDynamicScaffoldBackground(context),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      padding: AppSizes.DEFAULT,
                      child: Column(
                        children: [
                          UserInfoRow(
                            onAvatarTap: () => Get.to(
                              () => const FillUpProfileDetailScreen(),
                              transition: Transition.leftToRight,
                            ),
                            onNotificationTap: () => Get.to(
                              () => const NotificationScreen(),
                              transition: Transition.leftToRight,
                            ),
                            onFavoriteTap: () => Get.to(
                              () => const FavouroteScreen(),
                              transition: Transition.leftToRight,
                            ),
                          ),
                          const Gap(20),
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
                          const Gap(5.0),
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
                          const Gap(20),
                          SwipeablePromoCards(
                            items: promoItems,
                            onCardTap: (index, item) =>
                                Get.to(() => PromoDetailView(item: item)),
                          ),
                          const Gap(20),
                          CategoryGrid(
                            items: _categoriesWithoutAll,
                            onTap: (index, category) {
                              Get.to(
                                () => CategoryDetailsView(
                                  category: category,
                                  allCategories: _categoriesWithoutAll,
                                ),
                              );
                            },
                          ),

                          const Gap(20),
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
                                  () => SeeAllCategoryTab(
                                    categories: _allCategories,
                                  ),
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
                          const Gap(10),
                          CategoryTabBarRow(
                            categories: _allCategories,
                            onCategorySelected: (selectedCategory) {
                              // Handle category selection
                            },
                          ),
                          const Gap(20),
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
