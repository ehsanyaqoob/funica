// screens/navbar/cart/shipping_screen.dart
import 'package:funica/Screens/navbar/cart/promo-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/models/order-model.dart';
import 'package:funica/widget/custom_appbar.dart';

class ShippingScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;
  final String selectedAddress;

  const ShippingScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
    required this.selectedAddress,
  });

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  String _selectedShipping = "regular";

  final List<ShippingOption> _shippingOptions = [
    ShippingOption(
      id: "economy",
      title: "Economy",
      subtitle: "5-7 business days",
      price: 4.99,
      icon: Assets.truck,
      deliveryTime: "5-7 days",
    ),
    ShippingOption(
      id: "regular",
      title: "Regular",
      subtitle: "3-5 business days",
      price: 7.99,
      icon: Assets.truck,
      deliveryTime: "3-5 days",
    ),
    ShippingOption(
      id: "express",
      title: "Express",
      subtitle: "1-2 business days",
      price: 12.99,
      icon: Assets.rocket,
      deliveryTime: "1-2 days",
    ),
    ShippingOption(
      id: "overnight",
      title: "Overnight",
      subtitle: "Next business day",
      price: 19.99,
      icon: Assets.planefilled,
      deliveryTime: "Next day",
    ),
    ShippingOption(
      id: "cargo",
      title: "Cargo",
      subtitle: "For large items only",
      price: 24.99,
      icon: Assets.planefilled,
      deliveryTime: "7-10 days",
    ),
    ShippingOption(
      id: "international",
      title: "International",
      subtitle: "Worldwide delivery",
      price: 34.99,
      icon: Assets.planefilled,
      deliveryTime: "10-14 days",
    ),
  ];

  void _selectShipping(String shippingId) {
    setState(() {
      _selectedShipping = shippingId;
    });
  }

  void _proceedToPayment() {
    final selectedOption = _shippingOptions.firstWhere(
      (option) => option.id == _selectedShipping,
    );

    // Navigate to promo screen first
    Get.to(
      () => PromoScreen(
        cartItems: widget.cartItems,
        totalAmount: widget.totalAmount,
        selectedAddress: widget.selectedAddress,
        selectedShipping: selectedOption,
      ),
      transition: Transition.cupertino,
    );
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
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: CustomAppBar(
              title: "Shipping Method",
              showLeading: true,
              centerTitle: false,
            ),
            body: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shipping Options List
                  MyText(
                    text: "Choose Shipping Method",
                    size: 20,
                    weight: FontWeight.bold,
                    color: kDynamicText(context),
                  ),
                  const Gap(16),

                  Expanded(
                    child: ListView.builder(
                      itemCount: _shippingOptions.length,
                      itemBuilder: (context, index) {
                        final option = _shippingOptions[index];
                        return _buildShippingOption(option);
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
               padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: kDynamicCard(context),
    border: Border.all(color: kDynamicBorder(context)),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(26.0),
      topRight: Radius.circular(26.0),
    ),
  ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Total Price",
                        size: 14,
                        color: kDynamicListTileSubtitle(context),
                      ),
                      const Gap(2),
                      MyText(
                        text: "\$${(widget.totalAmount + _getSelectedShippingPrice()).toStringAsFixed(2)}",
                        size: 24,
                        weight: FontWeight.bold,
                        color: kDynamicText(context),
                      ),
                      const Gap(2),
                      MyText(
                        text: "Shipping: \$${_getSelectedShippingPrice().toStringAsFixed(2)}",
                        size: 12,
                        color: kDynamicListTileSubtitle(context),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: MyButtonWithIcon(
                      iconPath: Assets.money,
                      text: "Continue",
                      onTap: _proceedToPayment,
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

  double _getSelectedShippingPrice() {
    final selectedOption = _shippingOptions.firstWhere(
      (option) => option.id == _selectedShipping,
    );
    return selectedOption.price;
  }

  Widget _buildShippingOption(ShippingOption option) {
    final isSelected = _selectedShipping == option.id;

    return GestureDetector(
      onTap: () => _selectShipping(option.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kDynamicCard(context),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: isSelected
                ? kDynamicPrimary(context)
                : kDynamicBorder(context),
            width: isSelected ? 2.0 : 1.2,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kDynamicCard(context),
                border: Border.all(color: kDynamicBorder(context)),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: SvgPicture.asset(
                option.icon,
                height: 30.0,
                color:  kDynamicIcon(context),
              ),
            ),
            const Gap(16),

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: option.title,
                    size: 16,
                    weight: FontWeight.w600,
                    color: kDynamicText(context),
                  ),
                  const Gap(4),
                  MyText(
                    text: option.subtitle,
                    size: 14,
                    color: kDynamicListTileSubtitle(context),
                  ),
                  const Gap(4),
                  MyText(
                    text: "Delivery: ${option.deliveryTime}",
                    size: 12,
                    color: kDynamicText(context),
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),

            const Gap(16),

            // Price
            MyText(
              text: "\$${option.price.toStringAsFixed(2)}",
              size: 16,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),

            const Gap(16),

            // Radio Button
           Container(
  width: 20,
  height: 20,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: kDynamicRadioBorder(context, isSelected),
      width: 2,
    ),
  ),
  child: isSelected
      ? Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: kDynamicRadioActive(context),
            shape: BoxShape.circle,
          ),
        )
      : null,
)

          ],
        ),
      ),
    );
  }
}

// Shipping Option Model
class ShippingOption {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String icon;
  final String deliveryTime;

  const ShippingOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.icon,
    required this.deliveryTime,
  });
}
