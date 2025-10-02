import 'package:funica/constants/export.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/widget/bottomsheets/bottomsheet.dart';

class DialogHelper {
  static void showDeleteDialog(CartItem cartItem, ProductController productController) {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: MyText(
          text: "Remove Item",
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(Get.context!),
        ),
        content: MyText(
          text: "Are you sure you want to remove ${cartItem.product.title} from your cart?",
          size: 14,
          color: kDynamicListTileSubtitle(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: "Cancel",
              size: 14,
              color: kDynamicListTileSubtitle(Get.context!),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              productController.removeFromCart(cartItem);
            },
            child: MyText(
              text: "Remove",
              size: 14,
              color: Colors.red,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static void showClearCartDialog(ProductController productController) {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: MyText(
          text: "Clear Cart",
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(Get.context!),
        ),
        content: MyText(
          text: "Are you sure you want to remove all items from your cart?",
          size: 14,
          color: kDynamicListTileSubtitle(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: "Cancel",
              size: 14,
              color: kDynamicListTileSubtitle(Get.context!),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              productController.clearCart();
            },
            child: MyText(
              text: "Clear All",
              size: 14,
              color: Colors.red,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static void showCheckoutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: MyText(
          text: "Checkout",
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(Get.context!),
        ),
        content: MyText(
          text: "Checkout functionality will be implemented soon!",
          size: 14,
          color: kDynamicListTileSubtitle(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: "OK",
              size: 14,
              color: kDynamicPrimary(Get.context!),
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Additional common dialogs you might need
  static void showSuccessDialog(String message) {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: MyText(
          text: "Success",
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(Get.context!),
        ),
        content: MyText(
          text: message,
          size: 14,
          color: kDynamicListTileSubtitle(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: "OK",
              size: 14,
              color: kDynamicPrimary(Get.context!),
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: MyText(
          text: "Error",
          size: 18,
          weight: FontWeight.w600,
          color: Colors.red,
        ),
        content: MyText(
          text: message,
          size: 14,
          color: kDynamicListTileSubtitle(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: "OK",
              size: 14,
              color: kDynamicPrimary(Get.context!),
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }


  
  static void AllowlocationDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesAllowLocationDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Allow Location Access!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "We require your precise location to enhance your experience and provide best service."
                          .tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Enable location".tr,

                  onTap: () {
                    Get.back();
                    AllowlocationCheckDialog(context);
                  },
                ),
                Gap(10),
                MyButton(
                  outlineColor: kBorderColor,
                  backgroundColor: kWhite,
                  fontColor: kSecondaryColor,
                  buttonText: "Not Now".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void AllowlocationCheckDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesCheckInboxDailog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Check Your Inbox!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "We’ve sent you an email with the next steps. Follow instructions to continue."
                          .tr,
                  size: 16,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Continue".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void ForgotPasswordCheckDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesCheckInboxDailog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Check Your Inbox!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "We’ve sent you an email with the next steps. Follow instructions to continue."
                          .tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Continue".tr,
                  onTap: () {
                    Get.back();
                    ForgotPasswordOtpBottomSheet(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void ForgotPasswordPhoneDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesCheckInboxDailog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Check Your Inbox!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "We’ve sent you an email with the next steps. Follow instructions to continue."
                          .tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Continue".tr,
                  onTap: () {
                    Get.back();
                    ForgotPasswordPhoneOtpBottomSheetPhone(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void ForgotPasswordScuessDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesResetDailog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Password Reset Successful!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "Your password has been changed. You can log in now with the new password."
                          .tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Back to Login".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void PaymentScuessDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesPaymentDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Payment Successful!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "Thanks for your purchase! A confirmation email with tracking details will be sent soon."
                          .tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Continue".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void LogoutDialog(BuildContext context) {
    // final UserProfileController userProfileController = Get.find<UserProfileController>();

    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesLogoutDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Logout?".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text: "Are your sure you want to log out?".tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Yes, log me out".tr,
                  fontWeight: FontWeight.w600,
                  onTap: () async {
                    // // Call the LOGOUT method from controller (not deleteAccount)
                    // await userProfileController.logout();
                  },
                ),
                MyBorderButton(
                  onTap: () {
                    Get.back();
                  },
                  fontWeight: FontWeight.w600,
                  buttonText: "Not now".tr,
                  fontColor: kSecondaryColor,
                  outlineColor: kWhite,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 static void GoogleSignInDialog(BuildContext context) {
  Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kDynamicBackground(context),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Column(
            children: [
              // Google icon container
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kDynamicBackground(context),
                  border: Border.all(color: kDynamicPrimary(context), width: 1),
                ),
                child: Icon(
                  Icons.g_mobiledata,
                  size: 50,
                  color: kDynamicPrimary(context),
                ),
              ),
              const Gap(20),

              // Title
              MyText(
                text: "Sign in with Google".tr,
                size: 20,
                color: kDynamicText(context),
                weight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
              const Gap(10),

              // Description
              MyText(
                text:
                    "Continue with your Google account to access all features".tr,
                size: 14,
                color: kDynamicText(context).withOpacity(0.7),
                paddingBottom: 16,
                weight: FontWeight.w400,
                textAlign: TextAlign.center,
              ),

              // Google sign in button
              MyButton(
                buttonText: "Continue with Google".tr,
                fontWeight: FontWeight.w600,
                backgroundColor: kDynamicCard(context),
                fontColor: kDynamicText(context),
                onTap: () async {
                  // Get.to(
                  //   MainNavigation(),
                  //   transition: Transition.rightToLeftWithFade,
                  //   duration: const Duration(milliseconds: 500),
                  // );
                },
              ),

              const Gap(12),

              // Cancel button
              MyButton(
                buttonText: "Not now".tr,
                fontWeight: FontWeight.w600,
                backgroundColor: kDynamicCard(context),
                fontColor: kDynamicText(context),
                onTap: () async {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  
  static void showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = "Yes, I want to",
    String cancelText = "Not now",
  }) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesLogoutDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: title.tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text: message.tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: confirmText.tr,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    Get.back();
                    onConfirm();
                  },
                ),
                const Gap(10),
                MyBorderButton(
                  onTap: () {
                    Get.back();
                  },
                  fontWeight: FontWeight.w600,
                  buttonText: cancelText.tr,
                  fontColor: kSecondaryColor,
                  outlineColor: kWhite,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void SubmitServiceDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesBosstDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Boost Your Reach!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "Would you like to feature your service to reach more users in your category and city?"
                          .tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Yes, feature It".tr,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    // Get.to(() => const FeatureItScreen());
                  },
                ),
                MyBorderButton(
                  onTap: () {
                    Get.back();
                  },
                  fontWeight: FontWeight.w600,
                  buttonText: "Not now",
                  fontColor: kSecondaryColor,
                  outlineColor: kWhite,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void PaymentScuessServicesDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesPaymentDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Service Featured!".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text: "Expand your reach and connect with more customers!".tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Continue".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void DeleteCartItemDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesDeleteItemDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Empty your cart?".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "Are you sure you want to permanently remove all items from the cart?"
                          .tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Yes, remove".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
                Gap(16),
                MyBorderButton(
                  onTap: () {
                    Get.back();
                  },
                  outlineColor: kTransperentColor,
                  fontColor: kSecondaryColor,
                  buttonText: "Not now".tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void DeletePostDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesDeleteItemDialog,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Are you sure?".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text: "Are you sure you want to perform this action?".tr,

                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Yes, remove".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
                Gap(16),
                MyBorderButton(
                  onTap: () {
                    Get.back();
                  },
                  outlineColor: kTransperentColor,
                  fontColor: kSecondaryColor,
                  buttonText: "Not now".tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void BlockDialog(BuildContext context) {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                SizedBox(
                  child: CommonImageView(
                    imagePath: Assets.imagesBlockDialogIcon,
                    height: 92,
                  ),
                ),
                const Gap(20),
                MyText(
                  text: "Block this user?".tr,
                  size: 20,
                  color: kBlack,
                  weight: FontWeight.w700,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                MyText(
                  text:
                      "Once blocked, you won't see messages or activity from this user."
                          .tr,

                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Block User".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
                Gap(16),
                MyBorderButton(
                  onTap: () {
                    Get.back();
                  },
                  outlineColor: kTransperentColor,
                  fontColor: kSecondaryColor,
                  buttonText: "Cancel".tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
