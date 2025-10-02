import 'package:flutter/material.dart';
import 'package:funica/models/category-model.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/Screens/prodcuts/prodcut-details-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/widget/home-widgets/prodcu-card.dart';
import 'package:get/get.dart';

class CategoryTabBarRow extends StatefulWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel)? onCategorySelected;

  const CategoryTabBarRow({
    super.key,
    required this.categories,
    this.onCategorySelected,
  });

  @override
  State<CategoryTabBarRow> createState() => _CategoryTabBarRowState();
}

class _CategoryTabBarRowState extends State<CategoryTabBarRow>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.categories.isNotEmpty) {
      _tabController = TabController(
        length: widget.categories.length,
        vsync: this,
      );
      _selectedCategory = widget.categories.first;
      _tabController!.addListener(_handleTabSelection);
    }
  }

  void _handleTabSelection() {
    if (_tabController != null && _tabController!.indexIsChanging) {
      setState(() {
        _selectedCategory = widget.categories[_tabController!.index];
      });
      widget.onCategorySelected?.call(_selectedCategory!);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (_) {
        return Column(
          children: [
            if (widget.categories.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.categories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        final index = widget.categories.indexOf(category);
                        _tabController?.animateTo(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          color: isSelected
                              ? kDynamicColor(context, kBlack, kWhite)
                              : kTransperentColor,
                          border: Border.all(
                            color: isSelected
                                ? kDynamicColor(context, kBlack, kWhite)
                                : kDynamicColor(
                                    context,
                                    kGreyColor4,
                                    kGreyColor4,
                                  ),
                            width: 1.5,
                          ),
                        ),
                        child: MyText(
                          text: category.title,
                          size: 14,
                          weight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? kDynamicColor(context, kWhite, kBlack)
                              : kDynamicColor(
                                  context, kGreyColor4, kGreyColor4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            const Gap(20),
            SizedBox(
              height: 500,
              child: widget.categories.isEmpty || _tabController == null
                  ? Center(
                      child: MyText(
                        text: "No categories available",
                        size: 16,
                        color: kDynamicCaptionText(context),
                      ),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: widget.categories.map((category) {
                        final List<ProductModel> products = category.isOthers
                            ? widget.categories
                                .where((c) => !c.isOthers)
                                .expand((c) => c.products)
                                .toList()
                            : category.products;
                        return products.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.inventory_2_outlined,
                                      size: 64,
                                      color: kDynamicCaptionText(context),
                                    ),
                                    const Gap(16),
                                    MyText(
                                      text: "No products available",
                                      size: 16,
                                      color: kDynamicCaptionText(context),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                itemCount: products.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.75,
                                ),
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return ProductCard(
                                    product: product,
                                    initialIsLiked: false,
                                    onTap: () {
                                      Get.to(() =>
                                          ProductDetailsView(product: product));
                                    },
                                    onLikeChanged: (isLiked) {
                                      print(
                                          'Product ${product.title} is now ${isLiked ? 'liked' : 'unliked'}');
                                    },
                                  );
                                },
                              );
                      }).toList(),
                    ),
            ),
          ],
        );
      },
    );
  }
}
