import 'package:flutter/material.dart';
import 'package:funica/models/category-model.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/Screens/prodcuts/prodcut-details-screen.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/home-widgets/prodcu-card.dart';
import 'package:funica/constants/export.dart';

class CategoryDetailsView extends StatefulWidget {
  final CategoryModel category;
  final List<CategoryModel> allCategories;

  const CategoryDetailsView({
    super.key,
    required this.category,
    required this.allCategories,
  });

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  List<ProductModel> _allProducts = [];
  List<ProductModel> _filteredProducts = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _initializeProducts();
  }

  void _initializeProducts() {
    try {
      if (widget.category.isOthers) {
        // For "Others" category, combine products from all other categories except "All"
        _allProducts = widget.allCategories
            .where(
              (c) => c.title != "All" && !c.isOthers && c.products.isNotEmpty,
            )
            .expand((c) => c.products)
            .toList();

        // Remove duplicates by ID
        final seenIds = <String>{};
        _allProducts = _allProducts
            .where((product) => seenIds.add(product.id))
            .toList();
      } else {
        // For regular categories, use their own products
        _allProducts = widget.category.products;
      }

      _filteredProducts = _allProducts;

      print(
        "✅ Category: ${widget.category.title}, Products: ${_allProducts.length}",
      );
    } catch (e) {
      print("❌ Error getting products: $e");
      _allProducts = [];
      _filteredProducts = [];
    }
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.price.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

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
            appBar: CustomAppBar(
              title: widget.category.title,
              showLeading: true,
              enableSearch: true,
              centerTitle: false,
              onSearchChanged: _onSearch,
            ),
            body: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  // Show search results info
                  if (_searchQuery.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: kDynamicCard(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kDynamicBorder(context)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text:
                                "${_filteredProducts.length} results for \"$_searchQuery\"",
                            size: 14,
                            color: kDynamicListTileSubtitle(context),
                          ),
                          Bounce(
                            onTap: () => _onSearch(''),
                            child: MyText(
                              text: "Clear",
                              size: 14,
                              weight: FontWeight.w600,
                              color: kDynamicPrimary(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                  ] else if (!widget.category.isOthers) ...[
                    // Show category info only when not searching
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: kDynamicCard(context),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kDynamicBorder(context)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: "${_allProducts.length} products available",
                            size: 14,
                            color: kDynamicListTileSubtitle(context),
                          ),
                          MyText(
                            text: widget.category.title,
                            size: 14,
                            weight: FontWeight.w600,
                            color: kDynamicListTileSubtitle(context),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                  ],
                  Expanded(
                    child: _filteredProducts.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  widget.category.icon,
                                  height: 80,
                                  color: kDynamicIcon(context),
                                ),
                                const Gap(16),
                                MyText(
                                  text: _searchQuery.isEmpty
                                      ? (widget.category.isOthers
                                            ? "No additional products available"
                                            : "No products available in this category")
                                      : "No results found for \"$_searchQuery\"",
                                  size: 16,
                                  color: kDynamicText(context),
                                  textAlign: TextAlign.center,
                                ),
                                const Gap(8),
                                MyText(
                                  text: _searchQuery.isEmpty
                                      ? (widget.category.isOthers
                                            ? "All products are already in main categories"
                                            : "Check back later for new arrivals")
                                      : "Try searching with different keywords",
                                  size: 14,
                                  color: kDynamicListTileSubtitle(context),
                                  textAlign: TextAlign.center,
                                ),
                                if (_searchQuery.isNotEmpty) ...[
                                  const Gap(16),
                                  Bounce(
                                    onTap: () => _onSearch(''),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: kDynamicPrimary(context),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: MyText(
                                        text: "Clear Search",
                                        size: 14,
                                        color: kDynamicText(context),
                                        weight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          )
                        : GridView.builder(
                            itemCount: _filteredProducts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.75,
                                ),
                            itemBuilder: (context, index) {
                              final product = _filteredProducts[index];
                              return ProductCard(
                                product: product,
                                initialIsLiked: false,
                                onTap: () {
                                  Get.to(
                                    () => ProductDetailsView(product: product),
                                  );
                                },
                                onLikeChanged: (isLiked) {
                                  print(
                                    'Product ${product.title} is now ${isLiked ? 'liked' : 'unliked'}',
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
