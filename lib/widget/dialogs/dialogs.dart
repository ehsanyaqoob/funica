import 'package:funica/constants/export.dart';
import 'package:funica/Screens/auth/sign-in.dart';
import 'package:funica/widget/bottomsheets/bottomsheet.dart';

class DialogHelper {
 static void showPasswordResetSuccessDialog() {
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
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(Icons.check, size: 40, color: Colors.green),
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
                  text: "Your password has been changed successfully. You can now login with your new password.".tr,
                  size: 14,
                  color: kSubText,
                  paddingBottom: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                MyButton(
                  buttonText: "Continue to Login".tr,
                  onTap: () {
                    Get.back();
                    Get.off(() => SignInScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void showSuccessDialog() {
  Get.dialog(
    Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar / Icon
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 40, color: Colors.black),
            ),
            const SizedBox(height: 20),

            MyText(
              text: "Congratulations!".tr,
              size: 20,
              weight: FontWeight.w700,
              color: kBlack,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            MyText(
              text: "Your account is ready to use.".tr,
              size: 14,
              color: kSubText,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // ✅ Next Button
            MyButton(
              buttonText: "Next".tr,
              onTap: () {
                Get.back(); // close dialog
                // Get.offAll(
                //   () => InitialScreen(),
                //   transition: Transition.circularReveal,
                //   duration: const Duration(milliseconds: 600),
                // );
              },
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
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
