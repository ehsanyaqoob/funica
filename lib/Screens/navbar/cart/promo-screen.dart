// screens/navbar/cart/promo_screen.dart
import 'package:funica/Screens/navbar/cart/choose-shiping.dart';
import 'package:funica/Screens/navbar/cart/payment-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/models/promo-model.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/toasts.dart';

class PromoScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;
  final String selectedAddress;
  final ShippingOption selectedShipping;

  const PromoScreen({
    Key? key,
    required this.cartItems,
    required this.totalAmount,
    required this.selectedAddress,
    required this.selectedShipping,
  }) : super(key: key);

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}
class _PromoScreenState extends State<PromoScreen> {
  PromoCode? _selectedPromo;
  double _discountAmount = 0.0;
  
  final List<PromoCode> _availablePromos = [
    PromoCode(
      code: "WELCOME10",
      description: "10% off on first order",
      discountType: DiscountType.percentage,
      discountValue: 10,
      minOrderAmount: 0,
    ),
    PromoCode(
      code: "FREESHIP",
      description: "Free shipping on orders above \$50",
      discountType: DiscountType.freeShipping,
      discountValue: 0,
      minOrderAmount: 50,
    ),
    PromoCode(
      code: "SAVE15",
      description: "Flat \$15 off on orders above \$100",
      discountType: DiscountType.fixed,
      discountValue: 15,
      minOrderAmount: 100,
    ),
    PromoCode(
      code: "SUMMER25",
      description: "25% off on summer collection",
      discountType: DiscountType.percentage,
      discountValue: 25,
      minOrderAmount: 0,
    ),
    PromoCode(
      code: "NEWUSER20",
      description: "20% off for new users",
      discountType: DiscountType.percentage,
      discountValue: 20,
      minOrderAmount: 30,
    ),
    PromoCode(
      code: "BULK10",
      description: "10% off on 3+ items",
      discountType: DiscountType.percentage,
      discountValue: 10,
      minOrderAmount: 0,
    ),
  ];

  void _selectPromo(PromoCode promo) {
    if (widget.totalAmount < promo.minOrderAmount) {
      AppToast.error("Minimum order amount \$${promo.minOrderAmount} required");
      return;
    }

    setState(() {
      _selectedPromo = promo;
      _calculateDiscount();
    });
    AppToast.success("Promo code applied successfully!");
  }

  void _calculateDiscount() {
    if (_selectedPromo == null) {
      _discountAmount = 0.0;
      return;
    }

    switch (_selectedPromo!.discountType) {
      case DiscountType.percentage:
        _discountAmount = (widget.totalAmount * _selectedPromo!.discountValue) / 100;
        break;
      case DiscountType.fixed:
        _discountAmount = _selectedPromo!.discountValue.toDouble();
        break;
      case DiscountType.freeShipping:
        _discountAmount = widget.selectedShipping.price;
        break;
    }
  }

  void _removePromo() {
    setState(() {
      _selectedPromo = null;
      _discountAmount = 0.0;
    });
  }

  void _proceedToPayment() {
    final totalWithDiscount = widget.totalAmount + widget.selectedShipping.price - _discountAmount;
    
    Get.to(
      () => PaymentScreen(
        cartItems: widget.cartItems,
        totalAmount: totalWithDiscount,
        selectedAddress: widget.selectedAddress,
        selectedShipping: widget.selectedShipping,
        appliedPromo: _selectedPromo,
        discountAmount: _discountAmount,
      ),
      transition: Transition.cupertino,
    );
  }

  double get _finalTotal {
    return widget.totalAmount + widget.selectedShipping.price - _discountAmount;
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
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: CustomAppBar(
              title: "Apply Promo Code",
              showLeading: true,
              centerTitle: false,
            ),
            body: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Available Promo Codes
                  MyText(
                    text: "Available Offers",
                    size: 20,
                    weight: FontWeight.bold,
                    color: kDynamicText(context),
                  ),
                  const Gap(16),
                  
                  Expanded(
                    child: ListView.builder(
                      itemCount: _availablePromos.length,
                      itemBuilder: (context, index) {
                        final promo = _availablePromos[index];
                        return _buildPromoOption(promo);
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: kDynamicScaffoldBackground(context),
                boxShadow: [
                  BoxShadow(
                    color: kDynamicShadow(context),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
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
                        text: "\$${_finalTotal.toStringAsFixed(2)}",
                        size: 24,
                        weight: FontWeight.bold,
                        color: kDynamicText(context),
                      ),
                      if (_selectedPromo != null) ...[
                        const Gap(2),
                        MyText(
                          text: "Saved \$${_discountAmount.toStringAsFixed(2)}",
                          size: 12,
                          color: Colors.green,
                          weight: FontWeight.w600,
                        ),
                      ],
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

  Widget _buildPromoOption(PromoCode promo) {
    final isSelected = _selectedPromo?.code == promo.code;
    final isEligible = widget.totalAmount >= promo.minOrderAmount;

    return GestureDetector(
      onTap: () => _selectPromo(promo),
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
            // Promo Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kDynamicScaffoldBackground(context),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: kDynamicBorder(context)),
              ),
              child: SvgPicture.asset(
                Assets.discount,
                height: 24,
                color:  kDynamicIcon(context),
              ),
            ),
            const Gap(16),
            
            // Promo Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText(
                        text: promo.code,
                        size: 16,
                        weight: FontWeight.w600,
                        color: isEligible ? kDynamicText(context) : kDynamicListTileSubtitle(context),
                      ),
                      const Gap(8),
                      if (!isEligible)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: MyText(
                            text: "Min. \$${promo.minOrderAmount}",
                            size: 10,
                            color: Colors.orange,
                            weight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                  const Gap(4),
                  MyText(
                    text: promo.description,
                    size: 14,
                    color: isEligible ? kDynamicListTileSubtitle(context) : kDynamicListTileSubtitle(context)?.withOpacity(0.5),
                  ),
                  const Gap(4),
                  if (isEligible)
                    MyText(
                      text: _getDiscountText(promo),
                      size: 12,
                      color: kDynamicText(context),
                      weight: FontWeight.w600,
                    ),
                ],
              ),
            ),
            
            const Gap(16),
            
            // Selection Indicator
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
              child: isSelected && isEligible
                  ? Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: kDynamicRadioActive(context),
            shape: BoxShape.circle,
          ),
        )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  String _getDiscountText(PromoCode promo) {
    switch (promo.discountType) {
      case DiscountType.percentage:
        return "${promo.discountValue}% off";
      case DiscountType.fixed:
        return "\$${promo.discountValue} off";
      case DiscountType.freeShipping:
        return "Free shipping";
    }
  }
}
 