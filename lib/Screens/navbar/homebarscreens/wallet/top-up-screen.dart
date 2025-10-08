import 'package:flutter/material.dart';
import 'package:funica/Screens/navbar/homebarscreens/wallet/payment-method-screen.dart';
import 'package:funica/Screens/navbar/navbar-screen.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/dot-loader.dart';
import 'package:funica/widget/toasts.dart';
import 'package:get/get.dart';
import 'package:funica/constants/export.dart';

class TopUpController extends GetxController {
  RxDouble selectedAmount = 0.0.obs;
  RxBool isLoading = false.obs;
  TextEditingController manualController = TextEditingController();

  void selectAmount(double amount) {
    selectedAmount.value = amount;
    manualController.text = amount.toStringAsFixed(0);
  }

  void manualAmount(String value) {
    double val = double.tryParse(value) ?? 0.0;
    selectedAmount.value = val;
  }

  Future<void> topUp() async {
    if (selectedAmount.value <= 0) {
      AppToast.info('Please select or enter an amount');
      return;
    }

    isLoading.value = true;
    Get.dialog(const Center(child: FunicaLoader()), barrierDismissible: false);

    await Future.delayed(const Duration(seconds: 2));

    Get.back(); // close loader
    isLoading.value = false;

    Get.to(() => PaymentMethodScreen(amount: selectedAmount.value));
  }
}

class TopUpScreen extends StatefulWidget {
  TopUpScreen({Key? key}) : super(key: key);

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final TopUpController controller = Get.put(TopUpController());

  final List<double> amounts = [
    20,
    40,
    50,
    70,
    100,
    120,
    150,
    200,
    250,
    300,
    350,
    400,
  ];

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
            appBar: CustomAppBar(
              title: 'Top Up E-Wallet',
              showLeading: true,
              onBackTap: () => Get.back(),
            ),
            backgroundColor: kDynamicScaffoldBackground(context),
            body: Column(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Padding(
                      padding: AppSizes.DEFAULT,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: 'Enter the Amount to Top-Up',
                              size: 28,
                              color: kDynamicText(context),
                              weight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          MyTextField(
                            controller: controller.manualController,
                            keyboardType: TextInputType.number,
                            hint: 'Enter amount',
                            prefix: SvgPicture.asset(
                              Assets.walletfilled,
                              height: 20,
                              color: kDynamicIcon(context),
                            ),
                            onChanged: controller.manualAmount,
                          ),
                          const Gap(20),

                          // Amount selection label
                          MyText(
                            text: 'Select Amount',
                            size: 18,
                            color: kDynamicText(context),
                            weight: FontWeight.w600,
                          ),
                          const Gap(12),

                          // Amount grid
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: amounts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 1.5,
                                  ),
                              itemBuilder: (context, index) {
                                return Obx(
                                  () => GestureDetector(
                                    onTap: () =>
                                        controller.selectAmount(amounts[index]),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            controller.selectedAmount.value ==
                                                amounts[index]
                                            ? kPrimaryColor
                                            : kDynamicContainer(context),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              controller.selectedAmount.value ==
                                                  amounts[index]
                                              ? kPrimaryColor
                                              : kDynamicBorder(context) ??
                                                    Colors.grey.withOpacity(
                                                      0.3,
                                                    ),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          if (controller.selectedAmount.value ==
                                              amounts[index])
                                            BoxShadow(
                                              color: kPrimaryColor.withOpacity(
                                                0.3,
                                              ),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                        ],
                                      ),
                                      child: Center(
                                        child: MyText(
                                          text: '\$${amounts[index].toInt()}',
                                          color:
                                              controller.selectedAmount.value ==
                                                  amounts[index]
                                              ? kWhite
                                              : kDynamicText(context),
                                          size: 16,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Navigation Bar with Top Up Button
                _buildBottomNavigationBar(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Obx(
            () => MyButtonWithIcon(
              onTap: controller.selectedAmount.value > 0
                  ? controller.topUp
                  : null,
              text: 'Top Up \$${controller.selectedAmount.value.toInt()}',
              iconPath: Assets.walletfilled,
            ),
          ),
        ),
      ),
    );
  }
}
