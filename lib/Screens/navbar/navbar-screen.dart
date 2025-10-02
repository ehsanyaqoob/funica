import 'package:funica/Screens/navbar/cart/cart-screen.dart';
import 'package:funica/Screens/navbar/homebarscreens/home-screen.dart';
import 'package:funica/Screens/navbar/homebarscreens/order-screen.dart';
import 'package:funica/Screens/navbar/homebarscreens/profile-screen.dart';
import 'package:funica/Screens/navbar/homebarscreens/wallet-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/widget/toasts.dart';

class FunicaNavBar extends StatefulWidget {
  const FunicaNavBar({super.key});

  @override
  State<FunicaNavBar> createState() => _FunicaNavBarState();
}

class _FunicaNavBarState extends State<FunicaNavBar> {
  DateTime? _lastPressed;

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      AppToast.info("Press back again to exit");
      return false; 
    }
    SystemNavigator.pop(); 
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicNavigationBarBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              backgroundColor: kDynamicScaffoldBackground(context),

              // --- Main content ---
              body: Obx(() {
                final navController = Get.find<NavController>();
                return IndexedStack(
                  index: navController.currentIndex.value,
                  children: const [
                    HomeScreen(),
                    CartScreen(),
                    OrderScreen(),
                    WalletScreen(),
                    ProfileScreen(),
                  ],
                );
              }),

              // --- Bottom Nav ---
              bottomNavigationBar: Obx(() {
                final navController = Get.find<NavController>();
                return SafeArea(
                  bottom: true,
                  child: BottomNavigationBar(
                    currentIndex: navController.currentIndex.value,
                    onTap: navController.changeIndex,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: kDynamicNavigationBarBackground(context),
                    selectedItemColor: kDynamicNavigationBarSelectedItem(context),
                    unselectedItemColor: kDynamicNavigationBarItem(context),
                    items: [
                      _navBarItem(
                        index: 0,
                        navController: navController,
                        activeIcon: Assets.homefilled,
                        inactiveIcon: Assets.homeunfilled,
                        label: "Home",
                      ),
                      _navBarItem(
                        index: 1,
                        navController: navController,
                        activeIcon: Assets.cartfilled,
                        inactiveIcon: Assets.cartunfilled,
                        label: "Cart",
                      ),
                      _navBarItem(
                        index: 2,
                        navController: navController,
                        activeIcon: Assets.orderfilled,
                        inactiveIcon: Assets.orderunfilled,
                        label: "Orders",
                      ),
                      _navBarItem(
                        index: 3,
                        navController: navController,
                        activeIcon: Assets.walletfilled,
                        inactiveIcon: Assets.walletunfilled,
                        label: "Wallet",
                      ),
                      _navBarItem(
                        index: 4,
                        navController: navController,
                        activeIcon: Assets.profilefilled,
                        inactiveIcon: Assets.profileunfilled,
                        label: "Profile",
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _navBarItem({
    required int index,
    required NavController navController,
    required String activeIcon,
    required String inactiveIcon,
    required String label,
  }) {
    final bool isSelected = navController.currentIndex.value == index;
    final String iconPath = isSelected ? activeIcon : inactiveIcon;
    final bool isSvg = iconPath.endsWith(".svg");

    return BottomNavigationBarItem(
      icon: isSvg
          ? SvgPicture.asset(
              iconPath,
              height: 30.0,
              colorFilter: ColorFilter.mode(
                isSelected
                    ? kDynamicNavigationBarSelectedItem(context)
                    : kDynamicNavigationBarItem(context),
                BlendMode.srcIn,
              ),
            )
          : Image.asset(
              iconPath,
              height: 30.0,
              color: isSelected
                  ? kDynamicNavigationBarSelectedItem(context)
                  : kDynamicNavigationBarItem(context),
            ),
      label: label,
    );
  }
}

class NavController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
