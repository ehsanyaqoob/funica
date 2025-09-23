import 'package:flutter/material.dart';
import 'package:funica/models/category-model.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/views/prodcuts/prodcut-details-screen.dart';
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
    // If Others → collect all products from all other categories
    final List<ProductModel> products = category.isOthers
        ? allCategories
            .where((c) => !c.isOthers)
            .expand((c) => c.products)
            .toList()
        : category.products;
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
          child:Scaffold(
      appBar: CustomAppBar(
        title: category.title,
        showLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: "Explore ${category.title}",
              size: 20,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),
            Gap(16),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    title: product.title,
                    image: product.image,
                    price: product.price,
                    onTap: () {
                      Get.to(() => ProductDetailsView(
                        title: product.title,
                        image: product.image,
                        price: product.price,
                      ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
        ));
  }); }
}
