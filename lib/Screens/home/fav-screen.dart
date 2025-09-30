import 'package:funica/constants/export.dart';
import 'package:funica/controller/fav-cont.dart';
import 'package:funica/Screens/prodcuts/prodcut-details-screen.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/home-widgets/prodcu-card.dart';
class FavouroteScreen extends StatelessWidget {
  const FavouroteScreen({super.key});

  @override
  Widget build(BuildContext context) {
final favouritesController = Get.find<FavouritesController>();

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            appBar: CustomAppBar(
              title: "Favourites",
              showLeading: true,
              centerTitle: true,
            ),
            backgroundColor: kDynamicScaffoldBackground(context),
            body: Obx(() {
              final favourites = favouritesController.favourites;
              if (favourites.isEmpty) {
                return Center(
                  child: MyText(
                    text: "No favourites yet",
                    size: 16,
                    color: kDynamicText(context),
                  ),
                );
              }

              return GridView.builder(
                padding: AppSizes.DEFAULT,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  final product = favourites[index];
                  return ProductCard(
                    product: product,
                    initialIsLiked: true,
                    onLikeChanged: (isLiked) {
                      favouritesController.toggleFavourite(product, isLiked);
                    },
                    onTap: () {
                      Get.to(() => ProductDetailsView(product: product));
                    },
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
