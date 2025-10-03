// screens/navbar/cart/payment_screen.dart
import 'package:funica/Screens/navbar/cart/choose-shiping.dart';
import 'package:funica/Screens/navbar/navbar-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/models/order-model.dart';
import 'package:funica/models/promo-model.dart';
import 'package:funica/widget/bottomsheets/helper-sheets.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/toasts.dart';

class PaymentScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;
  final String selectedAddress;
  final ShippingOption selectedShipping;
  final PromoCode? appliedPromo;
  final double discountAmount;

  const PaymentScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
    required this.selectedAddress,
    required this.selectedShipping,
    this.appliedPromo,
    this.discountAmount = 0.0,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = "wallet";

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: "wallet",
      name: "My Wallet",
      description: "Use your Funica wallet balance",
      icon: Assets.walletfilled,
      balance: 2000000.50,
      type: PaymentType.wallet,
    ),
    PaymentMethod(
      id: "paypal",
      name: "PayPal",
      description: "Pay with your PayPal account",
      icon: Assets.paypal,
      type: PaymentType.digital,
    ),
    PaymentMethod(
      id: "google_pay",
      name: "Google Pay",
      description: "Fast and secure payment",
      icon: Assets.google,
      type: PaymentType.digital,
    ),
    PaymentMethod(
      id: "apple_pay",
      name: "Apple Pay",
      description: "Pay with Apple Pay",
      icon: Assets.apple,
      type: PaymentType.digital,
    ),
    PaymentMethod(
      id: "stripe",
      name: "Credit/Debit Card",
      description: "Pay with Visa, Mastercard, etc.",
      icon: Assets.amazon,
      type: PaymentType.card,
    ),
    PaymentMethod(
      id: "amazon_pay",
      name: "Amazon Pay",
      description: "Pay with your Amazon account",
      icon: Assets.amazon,
      type: PaymentType.digital,
    ),
  ];

  void _processPayment() {
    final selectedMethod = _paymentMethods.firstWhere(
      (method) => method.id == _selectedPaymentMethod,
    );

    // Check wallet balance if using wallet
    if (selectedMethod.type == PaymentType.wallet &&
        selectedMethod.balance! < _finalTotal) {
      AppToast.error("Insufficient wallet balance");
      return;
    }

    // Show payment processing bottom sheet
    BottomSheetHelper.showPaymentProcessingSheet(
      cartItems: widget.cartItems,
      totalAmount: widget.totalAmount,
      selectedAddress: widget.selectedAddress,
      selectedShipping: widget.selectedShipping,
      appliedPromo: widget.appliedPromo,
      discountAmount: widget.discountAmount,
      selectedPaymentMethod: _selectedPaymentMethod,
      onPaymentSuccess: _navigateToOrderScreen,
    );
  }

  void _navigateToOrderScreen() {
    Get.offAll(
      Get.to(
        FunicaNavBar(),
        transition: Transition.cupertino,
        duration: Duration(microseconds: 500),
      ),
    );
    Future.delayed(const Duration(milliseconds: 300), () {
      final navController = Get.find<NavController>();
      navController.changeIndex(3);

      AppToast.success("Order placed successfully!");
    });
  }

  String _getEstimatedDelivery() {
    final now = DateTime.now();
    final deliveryDays = widget.selectedShipping.deliveryTime.contains('1-2')
        ? 2
        : widget.selectedShipping.deliveryTime.contains('3-5')
        ? 5
        : widget.selectedShipping.deliveryTime.contains('5-7')
        ? 7
        : widget.selectedShipping.deliveryTime.contains('Next')
        ? 1
        : 10;

    final deliveryDate = now.add(Duration(days: deliveryDays));
    return "${deliveryDate.day}/${deliveryDate.month}/${deliveryDate.year}";
  }

  double get _finalTotal {
    return widget.totalAmount +
        widget.selectedShipping.price -
        widget.discountAmount;
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
              title: "Payment Method",
              showLeading: true,
              centerTitle: false,
            ),
            body: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary
                  _buildOrderSummary(),
                  const Gap(20),

                  // Payment Methods
                  MyText(
                    text: "Select Payment Method",
                    size: 18,
                    weight: FontWeight.w600,
                    color: kDynamicText(context),
                  ),
                  const Gap(16),

                  Expanded(
                    child: ListView.builder(
                      itemCount: _paymentMethods.length,
                      itemBuilder: (context, index) {
                        final method = _paymentMethods[index];
                        return _buildPaymentMethod(method);
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
                        text: "Total Payment",
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
                      const Gap(2),
                      MyText(
                        text: "${widget.cartItems.length} items",
                        size: 12,
                        color: kDynamicListTileSubtitle(context),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: MyButtonWithIcon(
                      iconPath: Assets.walletfilled,
                      text: "Pay Now",
                      onTap: _processPayment,
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

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kDynamicCard(context),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: kDynamicBorder(context), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: "Order Summary",
            size: 16,
            weight: FontWeight.w600,
            color: kDynamicText(context),
          ),
          const Gap(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: "Items (${widget.cartItems.length})",
                size: 14,
                color: kDynamicListTileSubtitle(context),
              ),
              MyText(
                text: "\$${widget.totalAmount.toStringAsFixed(2)}",
                size: 14,
                color: kDynamicText(context),
              ),
            ],
          ),
          const Gap(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: "Shipping",
                size: 14,
                color: kDynamicListTileSubtitle(context),
              ),
              MyText(
                text: "\$${widget.selectedShipping.price.toStringAsFixed(2)}",
                size: 14,
                color: kDynamicText(context),
              ),
            ],
          ),
          if (widget.appliedPromo != null) ...[
            const Gap(6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                  text: "Discount (${widget.appliedPromo!.code})",
                  size: 14,
                  color: kDynamicSystemGreen(context),
                ),
                MyText(
                  text: "-\$${widget.discountAmount.toStringAsFixed(2)}",
                  size: 14,
                  color: kDynamicSystemGreen(context),
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ],

          Gap(6),
          Divider(thickness: 2.5, color: kDynamicDivider(context)),
          Gap(6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: "Total",
                size: 16,
                weight: FontWeight.w600,
                color: kDynamicText(context),
              ),
              MyText(
                text: "\$${_finalTotal.toStringAsFixed(2)}",
                size: 18,
                weight: FontWeight.bold,
                color: kDynamicText(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(PaymentMethod method) {
    final isSelected = _selectedPaymentMethod == method.id;
    final hasInsufficientBalance =
        method.type == PaymentType.wallet && method.balance! < _finalTotal;

    return GestureDetector(
      onTap: () {
        if (!hasInsufficientBalance) {
          setState(() {
            _selectedPaymentMethod = method.id;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kDynamicCard(context),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: isSelected && !hasInsufficientBalance
                ? kDynamicPrimary(context)
                : kDynamicBorder(context),
            width: isSelected && !hasInsufficientBalance ? 2.0 : 1.2,
          ),
        ),
        child: Row(
          children: [
            // Payment Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kDynamicCard(context),
                border: Border.all(color: kDynamicBorder(context)),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: SvgPicture.asset(
                method.icon,
                height: 30.0,
                color: kDynamicIcon(context),
              ),
            ),
            const Gap(16),

            // Payment Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText(
                        text: method.name,
                        size: 16,
                        weight: FontWeight.w600,
                        color: hasInsufficientBalance
                            ? kDynamicListTileSubtitle(context)
                            : kDynamicText(context),
                      ),
                      if (method.type == PaymentType.wallet) ...[
                        const Gap(8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: kDynamicPrimary(context).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: MyText(
                            text: "\$${method.balance!.toStringAsFixed(2)}",
                            size: 10,
                            color: kDynamicText(context),
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Gap(4),
                  MyText(
                    text: method.description,
                    size: 14,
                    color: hasInsufficientBalance
                        ? kDynamicListTileSubtitle(context)?.withOpacity(0.5)
                        : kDynamicListTileSubtitle(context),
                  ),
                  if (hasInsufficientBalance) ...[
                    const Gap(4),
                    MyText(
                      text: "Insufficient balance",
                      size: 12,
                      color: Colors.red,
                      weight: FontWeight.w500,
                    ),
                  ],
                ],
              ),
            ),

            const Gap(16),

            // Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected && !hasInsufficientBalance
                      ? kDynamicPrimary(context)
                      : kDynamicRadioBorder(context, isSelected),
                  width: 2,
                ),
              ),
              child: isSelected && !hasInsufficientBalance
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
}

// Payment Method Model
class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final String icon;
  final double? balance;
  final PaymentType type;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.balance,
    required this.type,
  });
}

enum PaymentType { wallet, digital, card }

// Order Success Screen (Basic structure)
class OrderSuccessScreen extends StatelessWidget {
  final String orderNumber;
  final double totalAmount;
  final int items;
  final String estimatedDelivery;

  const OrderSuccessScreen({
    super.key,
    required this.orderNumber,
    required this.totalAmount,
    required this.items,
    required this.estimatedDelivery,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDynamicScaffoldBackground(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.personfilled,
              height: 100,
              color: Colors.green,
            ),
            const Gap(20),
            MyText(
              text: "Order Placed Successfully!",
              size: 24,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),
            const Gap(8),
            MyText(
              text: "Order #$orderNumber",
              size: 16,
              color: kDynamicListTileSubtitle(context),
            ),
            const Gap(20),
            MyButton(buttonText: "Continue Shopping"),
          ],
        ),
      ),
    );
  }
}
