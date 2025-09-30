import 'package:flutter/material.dart';
import 'package:funica/models/category-model.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/Screens/prodcuts/prodcut-details-screen.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/home-widgets/prodcu-card.dart';
import 'package:funica/constants/export.dart';

class CategoryDetailsView extends StatelessWidget {
  final CategoryModel category;
  final List<CategoryModel> allCategories;

  const CategoryDetailsView({
    super.key,
    required this.category,
    required this.allCategories,
  });

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = category.isOthers
        ? allCategories
              .where((c) => !c.isOthers)
              .expand((c) => c.products)
              .toList()
        : category.products;

    print("Category: ${category.title}, Products length: ${products.length}");
    print("CategoryDetailsView - Title: ${category.title}");
    print("CategoryDetailsView - Products length: ${category.products.length}");
    print("CategoryDetailsView - HashCode: ${category.hashCode}");
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
              title: category.title,
              showLeading: true,
              enableSearch: true,
              centerTitle: false,
            ),
            body: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(20),
                  Expanded(
                    child: GridView.builder(
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
                          product: product, // Just pass the product object
                          initialIsLiked: false,
                          onTap: () {
                            Get.to(
                              () => ProductDetailsView(
                                product:
                                    product, // Update this to accept product too
                              ),
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
