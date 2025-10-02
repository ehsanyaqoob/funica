import 'package:funica/Screens/home/categories-tabbar.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/models/category-model.dart';
import 'package:funica/widget/custom_appbar.dart';

class SeeAllCategoryTab extends StatefulWidget {
  final List<CategoryModel> categories;  

  const SeeAllCategoryTab({super.key, required this.categories});

  @override
  State<SeeAllCategoryTab> createState() => _SeeAllCategoryTabState();
}

class _SeeAllCategoryTabState extends State<SeeAllCategoryTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            appBar: CustomAppBar(
              title: "See All",
              showLeading: true,
              centerTitle: true,
            ),
            backgroundColor: kDynamicScaffoldBackground(context),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CategoryTabBarRow(
                    categories: widget.categories,   
                    onCategorySelected: (selectedCategory) {
                      
                    },
                  ),
                  const Gap(20),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
