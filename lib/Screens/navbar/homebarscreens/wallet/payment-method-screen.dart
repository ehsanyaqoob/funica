// payment_method_screen.dart
import 'package:flutter/material.dart';
import 'package:funica/Screens/navbar/navbar-screen.dart';
import 'package:funica/controller/e-wallet-cont.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/dot-loader.dart';
import 'package:funica/widget/toasts.dart';
import 'package:get/get.dart';
import 'package:funica/constants/export.dart';

class PaymentMethodController extends GetxController {
  RxString selectedMethod = ''.obs;
  RxBool isLoading = false.obs;

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

 // Update the processPayment method in PaymentMethodController
Future<void> processPayment(double amount) async {
  if (selectedMethod.isEmpty) {
    AppToast.info('Please select a payment method');
    return;
  }

  isLoading.value = true;
  
  // Show loading
  Get.dialog(Center(child: FunicaLoader()), barrierDismissible: false);
  
  // Simulate payment processing
  await Future.delayed(const Duration(seconds: 2));
  
  Get.back(); // Close loader
  isLoading.value = false;
  
  // Update wallet balance
  final walletController = Get.put(WalletController());
  walletController.addTopUpTransaction(amount);
  
  // Show success sheet
  _showPaymentSuccessSheet(amount);
}

  void _showPaymentSuccessSheet(double amount) {
    final String transactionId = "TXN-${DateTime.now().millisecondsSinceEpoch}";
    final String orderNumber = "ORD-${DateTime.now().millisecondsSinceEpoch}";
    final DateTime transactionDate = DateTime.now();

    Get.bottomSheet(
      Container(
        height: Get.height * 0.85,
        decoration: BoxDecoration(
          color: kDynamicCard(Get.context!),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Column(
          children: [
            // Draggable handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: kDynamicListTileSubtitle(Get.context!)!.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "Payment Successful!",
                    size: 22,
                    weight: FontWeight.w700,
                    color: kDynamicText(Get.context!),
                  ),
                  GestureDetector(
                    onTap: () => _navigateToNavBar(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kDynamicScaffoldBackground(Get.context!),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: SvgPicture.asset(
                        Assets.close,
                        height: 20,
                        color: kDynamicIcon(Get.context!),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Success Icon and Message
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: kDynamicSystemGreen(Get.context!)!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: kDynamicSystemGreen(Get.context!)!.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: kDynamicSystemGreen(Get.context!),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                Assets.check,
                                height: 40,
                                color: kWhite,
                              ),
                            ),
                          ),
                          const Gap(16),
                          MyText(
                            text: "Top-Up Successful!",
                            size: 20,
                            weight: FontWeight.w700,
                            color: kDynamicSystemGreen(Get.context!),
                          ),
                          const Gap(8),
                          MyText(
                            text: "Your wallet has been topped up successfully",
                            size: 14,
                            color: kDynamicSystemGreen(Get.context!),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    const Gap(24),

                    // Transaction Details Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kDynamicScaffoldBackground(Get.context!),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: kDynamicBorder(Get.context!),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: "Transaction Details",
                            size: 18,
                            weight: FontWeight.w700,
                            color: kDynamicText(Get.context!),
                          ),
                          const Gap(16),

                          _buildDetailRow("Transaction ID", transactionId),
                          const Gap(12),
                          _buildDetailRow("Order Number", orderNumber),
                          const Gap(12),
                          _buildDetailRow(
                            "Date & Time",
                            "${transactionDate.day}/${transactionDate.month}/${transactionDate.year} ${transactionDate.hour}:${transactionDate.minute.toString().padLeft(2, '0')}",
                          ),
                          const Gap(12),
                          _buildDetailRow(
                            "Payment Method",
                            _getPaymentMethodName(selectedMethod.value),
                          ),
                          
                          const Gap(16),
                          Divider(
                            color: kDynamicBorder(Get.context!)!,
                            height: 1,
                          ),
                          const Gap(16),

                          // Amount Section
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText(
                                text: "Amount Added",
                                size: 16,
                                weight: FontWeight.w600,
                                color: kDynamicText(Get.context!),
                              ),
                              MyText(
                                text: "\$${amount.toInt()}",
                                size: 24,
                                weight: FontWeight.bold,
                                color: kDynamicSystemGreen(Get.context!),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Gap(20),

                    // Wallet Balance Update
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kDynamicPrimary(Get.context!)!.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: kDynamicPrimary(Get.context!)!.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: kDynamicPrimary(Get.context!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              Assets.walletfilled,
                              height: 24,
                              color: kWhite,
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "Wallet Updated",
                                  size: 16,
                                  weight: FontWeight.w700,
                                  color: kDynamicPrimary(Get.context!),
                                ),
                                const Gap(4),
                                MyText(
                                  text: "Your new balance is available immediately",
                                  size: 12,
                                  color: kDynamicPrimary(Get.context!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Gap(20),

                    // Next Steps
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kDynamicScaffoldBackground(Get.context!),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: kDynamicBorder(Get.context!),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: "What's Next?",
                            size: 18,
                            weight: FontWeight.w700,
                            color: kDynamicText(Get.context!),
                          ),
                          const Gap(16),

                          _buildNextStep(
                            "1. Instant Availability",
                            "Your funds are available for immediate use",
                            Assets.check,
                          ),
                          const Gap(12),
                          _buildNextStep(
                            "2. Track Transactions",
                            "View your transaction history in Wallet tab",
                            Assets.walletfilled,
                          ),
                          const Gap(12),
                          _buildNextStep(
                            "3. Start Shopping",
                            "Use your wallet balance for seamless payments",
                            Assets.cartfilled,
                          ),
                        ],
                      ),
                    ),

                    const Gap(24),

                    // Continue Shopping Button
                    MyButtonWithIcon(
                      onTap: _navigateToNavBar,
                      text: "Continue to Wallet",
                      iconPath: Assets.walletfilled,
                    
                    ),

                    const Gap(32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: title,
          size: 14,
          color: kDynamicSubtitleText(Get.context!),
          weight: FontWeight.w500,
        ),
        MyText(
          text: value,
          size: 14,
          color: kDynamicText(Get.context!),
          weight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildNextStep(String title, String description, String iconPath) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kDynamicContainer(Get.context!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            iconPath,
            height: 16,
            color: kDynamicIcon(Get.context!),
          ),
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: title,
                size: 14,
                weight: FontWeight.w600,
                color: kDynamicText(Get.context!),
              ),
              const Gap(4),
              MyText(
                text: description,
                size: 12,
                color: kDynamicSubtitleText(Get.context!),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getPaymentMethodName(String methodId) {
    switch (methodId) {
      case 'paypal':
        return 'PayPal';
      case 'google_pay':
        return 'Google Pay';
      case 'apple_pay':
        return 'Apple Pay';
      case 'debit_card':
        return 'Debit Card';
      case 'credit_card':
        return 'Credit Card';
      case 'bank_transfer':
        return 'Bank Transfer';
      default:
        return 'Unknown Method';
    }
  }

  void _navigateToNavBar() {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back();
    }
    // Navigate to FunicaNavBar with tab 4 (Wallet)
    Get.offAll(() => FunicaNavBar());
    // You might need to set the tab index to 4 here
    // Get.find<NavController>().changeIndex(4);
  }


}

class PaymentMethodScreen extends StatefulWidget {
  final double amount;

  const PaymentMethodScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final PaymentMethodController controller = Get.put(PaymentMethodController());

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'paypal',
      name: 'PayPal',
      icon: Assets.paypal,
      description: 'Pay with your PayPal account',
    ),
    PaymentMethod(
      id: 'google_pay',
      name: 'Google Pay',
      icon: Assets.google,
      description: 'Fast and secure Google Pay',
    ),
    PaymentMethod(
      id: 'apple_pay',
      name: 'Apple Pay',
      icon: Assets.apple,
      description: 'Pay with Apple Pay',
    ),
    PaymentMethod(
      id: 'debit_card',
      name: 'Debit Card',
      icon: Assets.walletfilled,
      description: 'Pay with your debit card',
    ),
    PaymentMethod(
      id: 'credit_card',
      name: 'Credit Card',
      icon: Assets.visacard,
      description: 'Pay with your credit card',
    ),
    PaymentMethod(
      id: 'bank_transfer',
      name: 'Bank Transfer',
      icon: Assets.walletfilled,
      description: 'Direct bank transfer',
    ),
  ];

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
            appBar: CustomAppBar(
              title: 'Select Payment Method',
              showLeading: true,
              onBackTap: () => Get.back(),
            ),
            backgroundColor: kDynamicScaffoldBackground(context),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: AppSizes.DEFAULT,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Amount Summary
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kDynamicContainer(context),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          MyText(
                            text: 'Top-Up Amount',
                            size: 16,
                            color: kDynamicSubtitleText(context),
                            weight: FontWeight.w500,
                          ),
                          const Gap(8),
                          MyText(
                            text: '\$${widget.amount.toInt()}',
                            size: 32,
                            color: kDynamicText(context),
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    
                    const Gap(24),
                    
                    // Payment Methods Label
                    MyText(
                      text: 'Select Payment Method',
                      size: 18,
                      color: kDynamicText(context),
                      weight: FontWeight.w600,
                    ),
                    
                    const Gap(16),
                    
                    // Payment Methods List
                    Column(
                      children: paymentMethods.map((method) {
                        return Obx(
                          () => _buildPaymentMethodCard(method),
                        );
                      }).toList(),
                    ),
                    
                    const Gap(100), // Extra space for bottom button
                  ],
                ),
              ),
            ),
            
            // Bottom Payment Button
            bottomNavigationBar: _buildBottomPaymentButton(context),
          ),
        );
      },
    );
  }

  Widget _buildPaymentMethodCard(PaymentMethod method) {
    return Bounce(
      onTap: () => controller.selectMethod(method.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kDynamicContainer(context),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: controller.selectedMethod.value == method.id
                ? kPrimaryColor
                : kDynamicBorder(context) ?? Colors.grey.withOpacity(0.3),
            width: controller.selectedMethod.value == method.id ? 2 : 1,
          ),
          boxShadow: [
            if (controller.selectedMethod.value == method.id)
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: kDynamicBackground(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  method.icon,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    kDynamicIcon(context),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            
            const Gap(16),
            
            // Method Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: method.name,
                    size: 16,
                    color: kDynamicText(context),
                    weight: FontWeight.w600,
                  ),
                  const Gap(4),
                  MyText(
                    text: method.description,
                    size: 12,
                    color: kDynamicSubtitleText(context),
                    weight: FontWeight.normal,
                  ),
                ],
              ),
            ),
            
            // Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.selectedMethod.value == method.id
                      ? kPrimaryColor
                      : kDynamicBorder(context) ?? Colors.grey,
                  width: 2,
                ),
              ),
              child: controller.selectedMethod.value == method.id
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPaymentButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kDynamicCard(context),
        border: Border.all(color: kDynamicBorder(context)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Obx(
          () => MyButtonWithIcon(
            onTap: controller.selectedMethod.isNotEmpty && !controller.isLoading.value
                ? () => controller.processPayment(widget.amount)
                : null,
            text: 'Pay \$${widget.amount.toInt()}',
            iconPath: Assets.walletfilled,
            isLoading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final String icon;
  final String description;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}