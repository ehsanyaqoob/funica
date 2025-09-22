import 'package:action_slider/action_slider.dart';
import 'package:bounce/bounce.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:funica/widget/bottomsheets/bottomsheet_widgets.dart';
import 'package:funica/widget/custom_checkbox_widget.dart';
import 'package:funica/widget/dialogs/dialogs.dart';
import 'package:funica/widget/my_textfeild.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:funica/constants/export.dart';


void OtpBottomSheet(BuildContext context) {
  String otpCode = '';
  bool isOtpComplete = false;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      text: "OTP Verification".tr,
                      size: 24,
                      paddingTop: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
                MyText(
                  text:
                      "We've sent a 6-digit code to your email address. Enter the code below to continue."
                          .tr,
                  size: 14,
                  textAlign: TextAlign.start,
                  paddingBottom: 20,
                  color: kSubText,
                  weight: FontWeight.w400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kBorderColor),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      onCompleted: (pin) {
                        setState(() {
                          otpCode = pin;
                          isOtpComplete = true;
                        });
                      },
                      onChanged: (pin) {
                        setState(() {
                          otpCode = pin;
                          isOtpComplete = pin.length == 6;
                        });
                      },
                    ),
                  ],
                ),
                Gap(60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Resend code".tr,
                      size: 14,
                      color: kSecondaryColor,
                      weight: FontWeight.w600,
                    ),
                    MyText(
                      text: 'in 00:32',
                      size: 14,
                      color: kPrimaryColor,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                const Gap(20),
                MyButton(
                  buttonText: "Verify OTP".tr,
                  backgroundColor:
                      isOtpComplete ? kPrimaryColor : kPrimaryColor,
                  onTap:
                      isOtpComplete
                          ? () {
                           // Get.off(() => BottomNavBar());
                          }
                          : () {},
                ),

                Gap(10),
                MyButton(
                  buttonText: "Use phone number".tr,
                  fontColor: kSecondaryColor,
                  backgroundColor: kWhite,
                  onTap: () {
                    Get.back();
                    OtpBottomSheetPhone(context);
                  },
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void OtpBottomSheetPhone(BuildContext context) {
  String otpCodePhone = '';
  bool isOtpCompletePhone = false;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      text: "OTP Verification".tr,
                      size: 24,
                      paddingTop: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
                MyText(
                  text:
                      "A 6-digit code has been sent to your mobile number. Please enter the code below to proceed."
                          .tr,
                  size: 14,
                  textAlign: TextAlign.start,
                  paddingBottom: 20,
                  color: kSubText,
                  weight: FontWeight.w400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kBorderColor),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      onChanged: (pin) {
                        otpCodePhone = pin;
                        setState(() {
                          isOtpCompletePhone = pin.length == 6;
                        });
                      },
                      onCompleted: (pin) {
                        otpCodePhone = pin;
                        setState(() {
                          isOtpCompletePhone = true;
                        });
                      },
                    ),
                  ],
                ),
                Gap(60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Resend code".tr,
                      size: 14,
                      color: kSecondaryColor,
                      weight: FontWeight.w600,
                    ),
                    MyText(
                      text: 'in 00:32',
                      size: 14,
                      color: kPrimaryColor,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                const Gap(20),
                MyButton(
                  buttonText: "Verify OTP".tr,
                  backgroundColor:
                      isOtpCompletePhone ? kPrimaryColor : kPrimaryColor,
                  onTap:
                      isOtpCompletePhone
                          ? () {
                            //Get.off(() => BottomNavBar());
                          }
                          : () {},
                ),
                Gap(10),
                MyButton(
                  buttonText: "Use Email Address".tr,
                  fontColor: kSecondaryColor,
                  backgroundColor: kWhite,
                  onTap: () {
                    Get.back();
                    OtpBottomSheet(context);
                  },
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    ),
  );
}


void ForgotPasswordBottomSheet(BuildContext context) {
//  final authController = Get.find<AuthController>();
  final emailController = TextEditingController();

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: AppSizes.DEFAULT,
        decoration: const BoxDecoration(
          color: kbackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyText(
                  text: "Forgot Password".tr,
                  size: 24,
                  paddingTop: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
              ],
            ),
            MyText(
              text:
                  "Enter your registered email address, and we'll send you a link to reset your password."
                      .tr,
              size: 14,
              textAlign: TextAlign.start,
              paddingBottom: 20,
              color: kSubText,
              weight: FontWeight.w400,
            ),

            MyText(
              text: "Email Address".tr,
              size: 16,
              paddingBottom: 6,
              color: kBlack,
              textAlign: TextAlign.start,
              weight: FontWeight.w700,
            ),

            MyTextField(
              controller: emailController,
              hint: "example@gmail.com".tr,
              focusedFillColor: kWhite,
            ),

            Gap(80),

    //        Obx(() => MyButton(
    //   buttonText: "Send reset Link".tr,
    //  // isLoading: authController.isForgotPasswordLoading.value,
    //   onTap: () async {
    //     final email = emailController.text.trim();
    //   //  await authController.forgotPassword(
    //       email,
    //       onSuccess: () {
    //         Future.delayed(Duration(milliseconds: 300), () {
    //           Get.back(); 
    //           DialogHelper.ForgotPasswordCheckDialog(context);
    //         });
    //       },
    //     );
    //   },
    // )),


            Gap(10),

            MyButton(
              buttonText: "Use phone number".tr,
              fontColor: kSecondaryColor,
              fontSize: 14,
              backgroundColor: kbackground,
              onTap: () {
                Get.back();
                ForgotPasswordPhoneBottomSheet(context);
              },
            ),
            Gap(10),
          ],
        ),
      ),
    ),
  );
}

void ForgotPasswordOtpBottomSheet(BuildContext context) {
  String otpCode = '';
  bool isOtpComplete = false;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      text: "OTP Verification".tr,
                      size: 24,
                      paddingTop: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
                MyText(
                  text:
                      "We've sent a 6-digit code to your email address. Enter the code below to continue."
                          .tr,
                  size: 14,
                  textAlign: TextAlign.start,
                  paddingBottom: 20,
                  color: kSubText,
                  weight: FontWeight.w400,
                ),
                // Replace only this part in your code:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kBorderColor),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      onCompleted: (pin) {
                        setState(() {
                          otpCode = pin;
                          isOtpComplete = true;
                        });
                      },
                      onChanged: (pin) {
                        setState(() {
                          otpCode = pin;
                          isOtpComplete = pin.length == 6;
                        });
                      },
                    ),
                  ],
                ),
                Gap(60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Resend code".tr,
                      size: 14,
                      color: kSecondaryColor,
                      weight: FontWeight.w600,
                    ),
                    MyText(
                      text: 'in 00:32',
                      size: 14,
                      color: kPrimaryColor,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                const Gap(20),
                MyButton(
                  buttonText: "Verify OTP".tr,
                  backgroundColor:
                      isOtpComplete ? kPrimaryColor : kPrimaryColor,
                  onTap:
                      isOtpComplete
                          ? () {
                            Get.back();
                            ResetPasswordPhoneBottomSheet(context);
                          }
                          : () {},
                ),

                Gap(10),
                MyButton(
                  buttonText: "Use phone number".tr,
                  fontColor: kSecondaryColor,
                  backgroundColor: kWhite,
                  onTap: () {
                    Get.back();
                    ForgotPasswordPhoneOtpBottomSheetPhone(context);
                  },
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void ForgotPasswordPhoneBottomSheet(BuildContext context) {
  final FocusNode phoneFocusNode = FocusNode();
  bool isPhoneFocused = false;
  Country selectedCountry = Country(
    isoCode: 'GB',
    iso3Code: 'GBR',
    phoneCode: '44',
    name: 'United Kingdom',
  );
  String selectedCountryCode = '+44';

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          void showCountryPicker() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CountryPickerDialog(
                  titlePadding: EdgeInsets.all(8.0),
                  searchCursorColor: kPrimaryColor,
                  searchInputDecoration: InputDecoration(
                    labelText: 'Search'.tr,
                    hintText: 'Start typing to search'.tr,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
                  isSearchable: true,
                  title: Text('Select your phone code'.tr),
                  onValuePicked: (Country country) {
                    setState(() {
                      selectedCountry = country;
                      selectedCountryCode = '+${country.phoneCode}';
                    });
                  },
                  itemBuilder: (Country country) {
                    return Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: kTransperentColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CountryPickerUtils.getDefaultFlagImage(country),
                          SizedBox(width: 8.0),
                          Text("+${country.phoneCode}"),
                          SizedBox(width: 8.0),
                          Flexible(
                            child: Text(
                              country.name,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          }

          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Forgot Password".tr,
                      size: 24,
                      paddingTop: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
                MyText(
                  text:
                      "Provide your phone number, and we will send you a one-time password to help you reset your password."
                          .tr,
                  size: 14,
                  textAlign: TextAlign.start,
                  paddingBottom: 20,
                  color: kSubText,
                  weight: FontWeight.w400,
                ),
                // Replace only this part in your code:
                MyText(
                  text: "Phone Number".tr,
                  size: 16,
                  paddingBottom: 6,
                  color: kBlack,
                  weight: FontWeight.w700,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isPhoneFocused ? kPrimaryColor : kTransperentColor,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (Get.locale?.languageCode != 'ar') ...[
                        Bounce(
                          onTap: showCountryPicker,
                          child: Row(
                            spacing: 10,
                            children: [
                              CountryPickerUtils.getDefaultFlagImage(
                                selectedCountry,
                              ),
                              MyText(
                                text: selectedCountryCode,
                                size: 14,
                                color: kPrimaryColor,
                                weight: FontWeight.w600,
                              ),
                              CommonImageView(
                                imagePath: Assets.imagesArrowDownBlue,
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: MyTextField(
                            marginBottom: 0,
                            hint: "123 456 789".tr,
                            focusedFillColor: kWhite,
                            focusNode: phoneFocusNode,
                            focusBorderColor: kTransperentColor,
                            bordercolor: kTransperentColor,
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: MyTextField(
                            marginBottom: 0,
                            hint: "123 456 789".tr,
                            focusedFillColor: kWhite,
                            focusNode: phoneFocusNode,
                            focusBorderColor: kTransperentColor,
                            bordercolor: kTransperentColor,
                          ),
                        ),
                        Bounce(
                          onTap: showCountryPicker,
                          child: Row(
                            spacing: 10,
                            children: [
                              CountryPickerUtils.getDefaultFlagImage(
                                selectedCountry,
                              ),
                              MyText(
                                text: selectedCountryCode,
                                size: 14,
                                color: kPrimaryColor,
                                weight: FontWeight.w600,
                              ),
                              CommonImageView(
                                imagePath: Assets.imagesArrowDownBlue,
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Gap(80),

                MyButton(
                  buttonText: "Continue".tr,
                  onTap: () {
                    Get.back();
                    DialogHelper.ForgotPasswordPhoneDialog(context);
                  },
                ),
                Gap(10),
                MyButton(
                  buttonText: "Use email address".tr,
                  fontColor: kSecondaryColor,
                  fontSize: 14,
                  backgroundColor: kbackground,
                  onTap: () {
                    Get.back();
                    ForgotPasswordBottomSheet(context);
                  },
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void ForgotPasswordPhoneOtpBottomSheetPhone(BuildContext context) {
  String otpCode = '';
  bool isOtpComplete = false;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      text: "OTP Verification".tr,
                      size: 24,
                      paddingTop: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),
                MyText(
                  text:
                      "A 6-digit code has been sent to your mobile number. Please enter the code below to proceed."
                          .tr,
                  size: 14,
                  textAlign: TextAlign.start,
                  paddingBottom: 20,
                  color: kSubText,
                  weight: FontWeight.w400,
                ),
                // Replace only this part in your code:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kBorderColor),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 46,
                        height: 56,
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kSecondaryColor),
                        ),
                      ),
                      onCompleted: (pin) {
                        setState(() {
                          otpCode = pin;
                          isOtpComplete = true;
                        });
                      },
                      onChanged: (pin) {
                        setState(() {
                          otpCode = pin;
                          isOtpComplete = pin.length == 6;
                        });
                      },
                    ),
                  ],
                ),
                Gap(60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: "Resend code".tr,
                      size: 14,
                      color: kSecondaryColor,
                      weight: FontWeight.w600,
                    ),
                    MyText(
                      text: 'in 00:32',
                      size: 14,
                      color: kPrimaryColor,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                const Gap(20),

                MyButton(
                  buttonText: "Verify OTP".tr,
                  backgroundColor:
                      isOtpComplete ? kPrimaryColor : kPrimaryColor,
                  onTap:
                      isOtpComplete
                          ? () {
                            Get.back();
                            ResetPasswordPhoneBottomSheet(context);
                          }
                          : () {},
                ),
                Gap(10),
                MyButton(
                  buttonText: "Use email address".tr,
                  fontColor: kSecondaryColor,
                  backgroundColor: kWhite,
                  onTap: () {
                    Get.back();
                    ForgotPasswordOtpBottomSheet(context);
                  },
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void ResetPasswordPhoneBottomSheet(BuildContext context) {
  final FocusNode focusNodePassword = FocusNode();

  final FocusNode confirmFocusNodePassword = FocusNode();

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: AppSizes.DEFAULT,
        decoration: const BoxDecoration(
          color: kbackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyText(
                  text: "Reset Password".tr,
                  size: 24,
                  paddingTop: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
              ],
            ),
            MyText(
              text:
                  "Enter a new password for your account. Make sure it's strong and secure."
                      .tr,
              size: 14,
              textAlign: TextAlign.start,
              paddingBottom: 20,
              color: kSubText,
              weight: FontWeight.w400,
            ),
            // Replace only this part in your code:
            MyText(
              text: "Create new password".tr,
              size: 16,
              paddingBottom: 6,
              color: kBlack,
              weight: FontWeight.w700,
            ),
            MyTextField(
              hint: "Must have at least 6 characters".tr,
              focusNode: focusNodePassword,
              suffix:
                  Get.locale?.languageCode == 'ar'
                      ? null
                      : CommonImageView(
                        imagePath: Assets.imagesHide,
                        height: 20,
                      ),
              focusedFillColor: kWhite,
              prefix:
                  Get.locale?.languageCode == 'ar'
                      ? CommonImageView(
                        imagePath: Assets.imagesHide,
                        height: 20,
                      )
                      : null,
            ),

            MyText(
              text: "Confirm new password".tr,
              size: 16,
              paddingBottom: 6,
              color: kBlack,
              weight: FontWeight.w700,
            ),
            MyTextField(
              hint: "Must have at least 6 characters".tr,
              focusNode: confirmFocusNodePassword,
              suffix:
                  Get.locale?.languageCode == 'ar'
                      ? null
                      : CommonImageView(
                        imagePath: Assets.imagesHide,
                        height: 20,
                      ),
              focusedFillColor: kWhite,
              prefix:
                  Get.locale?.languageCode == 'ar'
                      ? CommonImageView(
                        imagePath: Assets.imagesHide,
                        height: 20,
                      )
                      : null,
            ),
            Gap(54),

            MyButton(
              buttonText: "Apply changes".tr,
              onTap: () {
                Get.back();
                DialogHelper.ForgotPasswordScuessDialog(context);
              },
            ),
            Gap(10),
          ],
        ),
      ),
    ),
  );
}

void FliterHomeBottomSheet(BuildContext context) {
  final FocusNode focusNodeSearch = FocusNode();
  List<String> categories = [
    "All".tr,
    "Radio".tr,
    "Services".tr,
    "Product".tr,
    "Artist".tr,
  ];
  List<String> Sortby = [
    "Relevance".tr,
    "Newest First".tr,
    "Top Rated".tr,
    "Most Popular".tr,
  ];

  String selectedSortBy = "Relevance".tr;
  String selectedCategory = "All".tr;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kBorderColor,
                      ),
                    ),
                  ],
                ),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "Filters".tr,
                      size: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                    MyText(
                      text: "Clear all".tr,
                      size: 12,
                      color: kredColor,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                MyText(
                  text: "Location".tr,
                  size: 14,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  color: kBlack,
                  weight: FontWeight.w700,
                ),
                MyTextField(
                  marginBottom: 0,
                  hint: "Search Location".tr,
                  focusNode: focusNodeSearch,
                  suffix:
                      Get.locale?.languageCode == 'ar'
                          ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CommonImageView(
                              imagePath: Assets.imagesSearchBlue,
                              height: 20,
                            ),
                          )
                          : CommonImageView(
                            imagePath: Assets.imagesMapPinBlueEmpty,
                            height: 20,
                          ),
                  focusedFillColor: kWhite,
                  prefix:
                      Get.locale?.languageCode == 'ar'
                          ? CommonImageView(
                            imagePath: Assets.imagesMapPinBlueEmpty,
                            height: 20,
                          )
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CommonImageView(
                              imagePath: Assets.imagesSearchBlue,
                              height: 20,
                            ),
                          ),
                ),
                MyText(
                  text: "Category".tr,
                  size: 16,
                  paddingTop: 16,
                  paddingBottom: 10,
                  color: kBlack,
                  weight: FontWeight.w600,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        categories.map((category) {
                          return Bounce(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: kBorderColor),
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    selectedCategory == category
                                        ? kPrimaryColor
                                        : kWhite,
                              ),
                              child: MyText(
                                text: category,
                                size: 14,
                                weight:
                                    selectedCategory == category
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                color:
                                    selectedCategory == category
                                        ? kWhite
                                        : kSubText,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                Gap(24),
                MyText(
                  text: "Sort By".tr,
                  size: 16,
                  paddingBottom: 10,
                  color: kBlack,
                  weight: FontWeight.w600,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        Sortby.map((sort) {
                          return Bounce(
                            onTap: () {
                              setState(() {
                                selectedSortBy = sort;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: kBorderColor),
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    selectedSortBy == sort
                                        ? kPrimaryColor
                                        : kWhite,
                              ),
                              child: MyText(
                                text: sort,
                                size: 14,
                                weight:
                                    selectedSortBy == sort
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                color:
                                    selectedSortBy == sort ? kWhite : kSubText,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
                Gap(50),
                MyButton(
                  buttonText: "Apply changes".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    ),
  );
}



void FliterRadioBottomSheet(BuildContext context) {
  List<String> Sortby = [
    "Relevance".tr,
    "Newest First".tr,
    "Top Rated".tr,
    "Most Popular".tr,
  ];

  int selectedOptionIndex = 0;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: kBorderColor,
                      ),
                    ),
                  ],
                ),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "Filters".tr,
                      size: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                    MyText(
                      text: "Clear all".tr,
                      size: 12,
                      color: kredColor,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),

                MyText(
                  text: "Sort By".tr,
                  size: 16,
                  paddingBottom: 10,
                  color: kBlack,
                  weight: FontWeight.w600,
                ),

                Column(
                  children: List.generate(Sortby.length, (pollIndex) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOptionIndex =
                              pollIndex; // Update selected option
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: kWhite,
                          border: Border.all(
                            width: 1.5,
                            color:
                                selectedOptionIndex == pollIndex
                                    ? kPrimaryColor // Change border color for selected option
                                    : kBorderColor2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      selectedOptionIndex == pollIndex
                                          ? kPrimaryColor
                                          : kBorderColor2,
                                ),
                                shape: BoxShape.circle,
                                color:
                                    selectedOptionIndex == pollIndex
                                        ? kWhite
                                        : kTransperentColor,
                              ),
                              child: Center(
                                child:
                                    selectedOptionIndex == pollIndex
                                        ? Padding(
                                          padding: const EdgeInsets.all(1),
                                          child: Icon(
                                            Icons.circle,
                                            size: 12,
                                            color: kPrimaryColor,
                                          ),
                                        )
                                        : Container(),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ), // Space between the icon and text
                            Expanded(
                              child: MyText(
                                text:
                                    Sortby[pollIndex], // Use the correct variable
                                size: 14,
                                weight: FontWeight.w600,
                                color: kSubText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                Gap(50),
                MyButton(
                  buttonText: "Apply changes".tr,
                  onTap: () {
                    Get.back();
                  },
                ),
                Gap(10),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void NowPlayingBottomSheet(BuildContext context) {
  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: AppSizes.DEFAULT,
        decoration: const BoxDecoration(
          color: kbackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kBorderColor,
                  ),
                ),
              ],
            ),
            Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyText(
                  text: "Radio Station Details".tr,
                  size: 24,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w600,
                ),
              ],
            ),
            MyText(
              text: "Description".tr,
              size: 14,
              textAlign: TextAlign.start,
              paddingBottom: 10,
              color: kBlack,
              weight: FontWeight.w700,
            ),
            MyText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Faucibus euismod tincidunt aliquet sed lacus nullam gravida sit pharetra. Duis vestibulum lorem curabitur pulvinar justo sem. Vitae augue nibh interdum morbi nulla at eget. Odio dui lectus eu amet a sapien."
                      .tr,
              size: 12,
              textAlign: TextAlign.start,
              paddingBottom: 10,
              color: kSubText,
              weight: FontWeight.w400,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Broadcasting From".tr,
                      size: 14,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Bounce(
                          child: CommonImageView(
                            imagePath: Assets.imagesFlagIraq,
                            height: 16,
                          ),
                        ),
                        MyText(
                          text: "Tehran, Iraq".tr,
                          color: kSubText,
                          size: 12,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Language".tr,
                      size: 14,
                      color: kBlack,
                      textAlign: TextAlign.start,
                      paddingBottom: 10,
                      weight: FontWeight.w700,
                    ),
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Bounce(
                          child: CommonImageView(
                            imagePath: Assets.imagesLanguageCircle,
                            height: 16,
                          ),
                        ),
                        MyText(
                          text: "Arabic, English".tr,
                          color: kSubText,
                          size: 12,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
                Gap(10),
              ],
            ),
            Gap(10),
          ],
        ),
      ),
    ),
  );
}

void SocialBottomSheet(BuildContext context) {
  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          // Define the lists
          List<String> names = [
            "karennne".tr,
            "emmatartson".tr,
            "kevinash".tr,
            "michellelo1".tr,
          ];
          List<String> messages = [
            "Let's keep the momentum going".tr,
            "Stay strong and keep pushing hard".tr,
            "Don't stop now! We're making a difference.".tr,
            "Looking forward to the positive outcome."
                .tr, // Added a fourth message
          ];
          List<String> images = [
            Assets.imagesChatAvatar,
            Assets.imagesChatAvatar2,
            Assets.imagesChatAvatar2,
            Assets.imagesChatAvatar3,
          ];
          List<int> likeCounts = [
            10,
            20,
            50,
            0,
          ]; // Adjusted to match the number of messages

          // Initialize heart states
          List<bool> isHeartFilled = List.generate(
            names.length,
            (index) => false,
          );

          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Bounce(
                      onTap: () {
                        Get.back();
                      },
                      child: CommonImageView(
                        imagePath: Assets.imagesArrowRdownGrey,
                        height: 24,
                      ),
                    ),
                  ],
                ),

                MyText(
                  text: "Comments",
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,

                  weight: FontWeight.w700,
                ),
                Gap(16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                      names
                          .length, // Ensure this matches the length of other lists
                  itemBuilder: (context, index) {
                    return ChatWidgetHeart(
                      name: names[index],
                      message: messages[index],
                      imagePath: images[index],
                      likeCount: likeCounts[index],
                      isHeartFilled: isHeartFilled[index],
                      onHeartToggle: () {
                        setState(() {
                          isHeartFilled[index] = !isHeartFilled[index];
                          likeCounts[index] += isHeartFilled[index] ? 1 : -1;
                        });
                      },
                    );
                  },
                ),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("💕", style: TextStyle(fontSize: 14)),
                    Text("😊", style: TextStyle(fontSize: 14)),
                    Text("👏", style: TextStyle(fontSize: 14)),
                    Text("😇", style: TextStyle(fontSize: 14)),
                    Text("😍", style: TextStyle(fontSize: 14)),
                    Text("🤔", style: TextStyle(fontSize: 14)),
                    Text("🤗", style: TextStyle(fontSize: 14)),
                    Text("🤩", style: TextStyle(fontSize: 14)),
                  ],
                ),
                Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MyTextField(
                        marginBottom: 0,
                        hint: "Add a comment here...",
                        focusedFillColor: kWhite,
                      ),
                    ),
                    Gap(10),
                    GestureDetector(
                      onTap: () {
                        // Handle send action
                      },
                      child: CommonImageView(
                        imagePath: Assets.imagesSendButtonBlue,
                        height: 44,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void PaymentBottomSheet(BuildContext context) {
  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kBorderColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  MyText(
                    text: "Enter Card Detail".tr,
                    size: 20,
                    paddingBottom: 10,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    weight: FontWeight.w700,
                  ),
                  MyText(
                    text: "Name on card".tr,
                    size: 14,
                    paddingBottom: 10,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    weight: FontWeight.w700,
                  ),
                  MyTextField(
                    marginBottom: 16,
                    hint: "Michael Doe".tr,
                    focusedFillColor: kWhite,
                  ),
                  MyText(
                    text: "Card Number".tr,
                    size: 14,
                    paddingBottom: 10,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    weight: FontWeight.w700,
                  ),
                  MyTextField(
                    marginBottom: 16,
                    hint: "1232 5343 2342",
                    focusedFillColor: kWhite,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "Expiry Date".tr,
                              size: 14,
                              paddingBottom: 10,
                              color: kBlack,
                              textAlign: TextAlign.start,
                              weight: FontWeight.w700,
                            ),
                            MyTextField(
                              marginBottom: 0,
                              hint: "02/29",
                              suffix:
                                  Get.locale?.languageCode == 'ar'
                                      ? null
                                      : CommonImageView(
                                        imagePath: Assets.imagesCalendar,
                                        height: 20,
                                      ),
                              focusedFillColor: kWhite,
                              prefix:
                                  Get.locale?.languageCode == 'ar'
                                      ? CommonImageView(
                                        imagePath: Assets.imagesCalendar,
                                        height: 20,
                                      )
                                      : null,
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "CVV Number".tr,
                              size: 14,
                              color: kBlack,
                              paddingBottom: 10,
                              textAlign: TextAlign.start,
                              weight: FontWeight.w700,
                            ),
                            MyTextField(
                              marginBottom: 0,
                              hint: "123",
                              focusedFillColor: kWhite,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomCheckbox(
                      text: "Remember this payment info".tr,
                      onChanged: (bool value) {},
                    ),
                  ),
                  Gap(10),
                  Center(
                    child: SizedBox(
                      height: 64,
                      child: ActionSlider.standard(
                        height: 64,
                        backgroundBorderRadius: BorderRadius.circular(12),
                        backgroundColor: kPrimaryColor,
                        toggleColor: kWhite,

                        icon: Icon(Icons.arrow_forward, color: kPrimaryColor),
                        child: MyText(
                          text: "Slide to Pay | \$122.50".tr,
                          color: kWhite,
                          size: 16,
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold,
                        ),
                        action: (controller) async {
                          controller.loading(); // simulate loading
                          await Future.delayed(Duration(seconds: 2));
                          controller.success(); // show success state
                          await Future.delayed(Duration(seconds: 1));
                          Get.back();
                          DialogHelper.PaymentScuessDialog(context);
                        },
                      ),
                    ),
                  ),

                  Gap(10),
                  Row(
                    children: [
                      MyText(
                        text: "Your payment is secure and encrypted via".tr,
                        size: 14,
                        color: kSubText,
                        paddingBottom: 10,
                        paddingLeft: 5,
                        paddingRight: 5,
                        textAlign: TextAlign.start,
                        weight: FontWeight.w500,
                      ),
                      MyText(
                        text: "Stripe".tr,
                        size: 14,
                        color: kPrimaryColor,
                        paddingBottom: 10,
                        paddingRight: 5,
                        decoration: TextDecoration.underline,
                        textAlign: TextAlign.start,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

void PaymentBottomSheet2(BuildContext context) {
  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kBorderColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  MyText(
                    text: "Enter Card Detail".tr,
                    size: 20,
                    paddingBottom: 10,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    weight: FontWeight.w700,
                  ),
                  MyText(
                    text: "Name on card".tr,
                    size: 14,
                    paddingBottom: 10,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    weight: FontWeight.w700,
                  ),
                  MyTextField(
                    marginBottom: 16,
                    hint: "Michael Doe".tr,
                    focusedFillColor: kWhite,
                  ),
                  MyText(
                    text: "Card Number".tr,
                    size: 14,
                    paddingBottom: 10,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    weight: FontWeight.w700,
                  ),
                  MyTextField(
                    marginBottom: 16,
                    hint: "1232 5343 2342",
                    focusedFillColor: kWhite,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "Expiry Date".tr,
                              size: 14,
                              paddingBottom: 10,
                              color: kBlack,
                              textAlign: TextAlign.start,
                              weight: FontWeight.w700,
                            ),
                            MyTextField(
                              marginBottom: 0,
                              hint: "02/29",
                              suffix:
                                  Get.locale?.languageCode == 'ar'
                                      ? null
                                      : CommonImageView(
                                        imagePath: Assets.imagesCalendar,
                                        height: 20,
                                      ),
                              focusedFillColor: kWhite,
                              prefix:
                                  Get.locale?.languageCode == 'ar'
                                      ? CommonImageView(
                                        imagePath: Assets.imagesCalendar,
                                        height: 20,
                                      )
                                      : null,
                            ),
                          ],
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: "CVV Number".tr,
                              size: 14,
                              color: kBlack,
                              paddingBottom: 10,
                              textAlign: TextAlign.start,
                              weight: FontWeight.w700,
                            ),
                            MyTextField(
                              marginBottom: 0,
                              hint: "123",
                              focusedFillColor: kWhite,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomCheckbox(
                      text: "Remember this payment info".tr,
                      onChanged: (bool value) {},
                    ),
                  ),
                  Gap(10),
                  Center(
                    child: SizedBox(
                      height: 64,
                      child: ActionSlider.standard(
                        height: 64,
                        backgroundBorderRadius: BorderRadius.circular(12),
                        backgroundColor: kPrimaryColor,
                        toggleColor: kWhite,

                        icon: Icon(Icons.arrow_forward, color: kPrimaryColor),
                        child: MyText(
                          text: "Slide to Pay | \$122.50".tr,
                          color: kWhite,
                          size: 16,
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold,
                        ),
                        action: (controller) async {
                          controller.loading(); // simulate loading
                          await Future.delayed(Duration(seconds: 2));
                          controller.success(); // show success state
                          await Future.delayed(Duration(seconds: 1));
                          Get.back();
                          DialogHelper.PaymentScuessServicesDialog(context);
                        },
                      ),
                    ),
                  ),

                  Gap(10),
                  Row(
                    children: [
                      MyText(
                        text: "Your payment is secure and encrypted via".tr,
                        size: 14,
                        color: kSubText,
                        paddingBottom: 10,
                        paddingLeft: 5,
                        paddingRight: 5,
                        textAlign: TextAlign.start,
                        weight: FontWeight.w500,
                      ),
                      MyText(
                        text: "Stripe".tr,
                        size: 14,
                        color: kPrimaryColor,
                        paddingBottom: 10,
                        decoration: TextDecoration.underline,
                        textAlign: TextAlign.start,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

void ReportBottomSheet(BuildContext context) {
  List<String> ReportItem = [
    "Spam".tr,
    "Hate Speech".tr,
    "Violence".tr,
    "Other".tr,
  ];

  String selectedReport = "Specify reason".tr; // Default selected value

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: kBorderColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                  MyText(
                    text: "Report Post".tr,
                    size: 20,
                    paddingBottom: 10,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    weight: FontWeight.w700,
                  ),
                  MyText(
                    text: "Reason for Reporting".tr,
                    size: 14,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    paddingBottom: 10,
                    weight: FontWeight.w700,
                  ),
                  Gap(10),
                  CustomDropDown2(
                    hint: "Specify reason".tr,
                    items: ReportItem,
                    leftImage: "", // Optional

                    selectedValue: selectedReport,
                    onChanged: (value) {
                      setState(() {
                        selectedReport = value;
                      });
                    },
                    // isArabic: isArabic,
                  ),
                  MyText(
                    text: "Additional Details".tr,
                    size: 14,
                    color: kBlack,
                    textAlign: TextAlign.start,
                    paddingBottom: 10,
                    weight: FontWeight.w600,
                  ),
                  MyTextField(
                    maxLines: 5,
                    hint:
                        "Write a few words to explain what happened (optional, but helpful)."
                            .tr,
                    focusedFillColor: kWhite,
                  ),
                  MyText(
                    text: "Attach Screenshot".tr,
                    size: 14,
                    weight: FontWeight.w600,
                    color: kBlack,
                  ),
                  Gap(10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(20),
                        CommonImageView(
                          imagePath: Assets.imagesCloud,
                          height: 40,
                        ),
                        Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              text: "Browse".tr,
                              size: 12,
                              paddingLeft: 6,
                              paddingRight: 6,
                              color: kPrimaryColor,
                              weight: FontWeight.w600,
                            ),
                            MyText(
                              text: "photos or vidoes".tr,
                              size: 12,
                              color: kSubText,
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                        MyText(
                          text: "Max file size: 5MB".tr,
                          size: 12,
                          color: kSubText,
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Gap(20),
                  MyButton(
                    buttonText: "Submit".tr,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Gap(10),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}

void AddPostBottomSheet(BuildContext context) {
  List<String> filters = ["General Post".tr, "Poll".tr, "Event".tr];
  List<String> images = [
    Assets.imagesMyPostFilled,
    Assets.imagesPollIcon,
    Assets.imagesEventIcon,
  ];
  List<Widget Function()> screens = [
    // () => AddPostScreen(),
    // () => AddPollScreen(),
    // () => AddEventsScreen(),
  ];

  int selectedOptionIndex = 0;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(16),
                MyText(
                  text: "Post Type".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 24,
                  weight: FontWeight.w700,
                ),

                Column(
                  children: List.generate(filters.length, (pollIndex) {
                    return Bounce(
                      onTap: () {
                        setState(() {
                          selectedOptionIndex = pollIndex;
                          Get.back();
                          Get.to(screens[pollIndex]());
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              selectedOptionIndex == pollIndex
                                  ? kPrimaryColor // Change border color for selected option
                                  : kWhite,
                          border: Border.all(
                            width: 1.5,
                            color:
                                selectedOptionIndex == pollIndex
                                    ? kPrimaryColor // Change border color for selected option
                                    : kBorderColor2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CommonImageView(
                              imagePath: images[pollIndex],
                              height: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ), // Space between the icon and text
                            Expanded(
                              child: Row(
                                children: [
                                  MyText(
                                    text:
                                        filters[pollIndex], // Use the correct variable
                                    size: 12,
                                    paddingRight: 6,
                                    weight: FontWeight.w500,
                                    color:
                                        selectedOptionIndex == pollIndex
                                            ? kPrimaryColor // Change border color for selected option
                                            : kSubText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Gap(24),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void TaggedProfilesBottomSheet(BuildContext context) {
  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          // Users data
          List<Map<String, String>> users = [
            {
              'name': 'Karlene Edwards'.tr,
              'username': "@karelenee".tr,
              'image': Assets.imagesChatAvatar2,
            },
            {
              'name': 'Marcus Lee',
              'username': '@marcusl',
              'image': Assets.imagesChatAvatar2,
            },
            {
              'name': 'Samantha Patel',
              'username': '@sampatel',
              'image': Assets.imagesChatAvatar3,
            },
          ];

          // Products data
          List<Map<String, String>> products = [
            {
              'name': 'Oud Majesty',
              'price': '\$78.59',
              'image':
                  Assets
                      .imagesProduct1, // Replace with your product image asset
            },
          ];

          // Services data
          List<Map<String, String>> services = [
            {
              'name': 'House Painting',
              'provider': 'Mason Taylor',
              'image':
                  Assets.imagesPainter, // Replace with your service image asset
            },
            {
              'name': 'House Painting',
              'provider': 'Mike Brown',
              'image':
                  Assets.imagesPainter, // Replace with your service image asset
            },
          ];

          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                MyText(
                  text: "Tagged Profiles".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  weight: FontWeight.w700,
                ),
                Gap(16),

                // Users Section
                MyText(
                  text: "Users (${users.length})".tr,
                  size: 16,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  weight: FontWeight.w600,
                ),
                Gap(16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(6),
                      child: Row(
                        children: [
                          // Profile Image
                          CommonImageView(
                            imagePath: users[index]['image']!,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          Gap(12),
                          // Name and Username
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: users[index]['name']!,
                                  size: 16,
                                  color: kBlack,
                                  weight: FontWeight.w600,
                                ),
                                Gap(2),
                                MyText(
                                  text: users[index]['username']!,
                                  size: 14,
                                  color: kSubText,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          // View Profile Button
                          MyButton(
                            width: 100,
                            height: 30,
                            backgroundColor: kPrimaryColor,
                            buttonText: "View profile".tr,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontColor: kPrimaryColor,
                            onTap: () {
                              //Get.to(() => ViewProfileScreen());
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                Gap(16),

                // Products Section
                MyText(
                  text: "Products (${products.length})".tr,
                  size: 16,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  weight: FontWeight.w600,
                ),
                Gap(16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(6),

                      child: Row(
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CommonImageView(
                              imagePath: products[index]['image']!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Gap(12),
                          // Product Name and Price
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: products[index]['name']!,
                                  size: 16,
                                  color: kBlack,
                                  weight: FontWeight.w600,
                                ),
                                Gap(2),
                                MyText(
                                  text: products[index]['price']!,
                                  size: 14,
                                  color: kSubText,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          // View Product Button
                          MyButton(
                            width: 100,
                            height: 30,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            backgroundColor: kPrimaryColor,
                            buttonText: "View product".tr,
                            fontColor: kPrimaryColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),

                Gap(16),

                // Services Section
                MyText(
                  text: "Services (${services.length})".tr,
                  size: 16,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  weight: FontWeight.w600,
                ),
                Gap(16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(6),

                      child: Row(
                        children: [
                          // Service Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CommonImageView(
                              imagePath: services[index]['image']!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Gap(12),
                          // Service Name and Provider
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: services[index]['name']!,
                                  size: 16,
                                  color: kBlack,
                                  weight: FontWeight.w600,
                                ),
                                Gap(2),
                                MyText(
                                  text: services[index]['provider']!,
                                  size: 14,
                                  color: kSubText,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          MyButton(
                            width: 100,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 30,
                            backgroundColor: kPrimaryColor,
                            buttonText: "View service".tr,
                            fontColor: kPrimaryColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),

                Gap(20), // Bottom padding
              ],
            ),
          );
        },
      ),
    ),
  );
}

void GalleryBottomSheet(BuildContext context) {
  List<String> filters = ["Upload from files".tr, "Take photo/video".tr];
  List<String> images = [Assets.imagesFolderOpen, Assets.imagesCamera];

  int selectedOptionIndex = 0;

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(16),
                MyText(
                  text: "Gallery".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
                Gap(10),
                Column(
                  children: List.generate(filters.length, (pollIndex) {
                    return Bounce(
                      onTap: () {
                        setState(() {
                          selectedOptionIndex = pollIndex;
                          Get.back();
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              selectedOptionIndex == pollIndex
                                  ? kPrimaryColor// Change border color for selected option
                                  : kWhite,
                          border: Border.all(
                            width: 1.5,
                            color:
                                selectedOptionIndex == pollIndex
                                    ? kPrimaryColor // Change border color for selected option
                                    : kBorderColor2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CommonImageView(
                              imagePath: images[pollIndex],
                              height: 16,
                            ),
                            SizedBox(
                              width: 8,
                            ), // Space between the icon and text
                            Expanded(
                              child: Row(
                                children: [
                                  MyText(
                                    text:
                                        filters[pollIndex], // Use the correct variable
                                    size: 12,
                                    paddingRight: 6,
                                    weight: FontWeight.w500,
                                    color:
                                        selectedOptionIndex == pollIndex
                                            ? kPrimaryColor // Change border color for selected option
                                            : kSubText,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Gap(24),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void ReviewBottomSheet(BuildContext context) {
  final FocusNode focusNodeEmail = FocusNode();

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "Cancel".tr,
                      size: 12,
                      onTap: () {
                        Get.back();
                      },
                      color: kBlack,
                      weight: FontWeight.w500,
                    ),
                    MyText(
                      text: "Share Review".tr,
                      size: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,

                      weight: FontWeight.w700,
                    ),
                    SizedBox(width: 30),
                  ],
                ),
                Gap(22),
                MyText(
                  text: "Star Rating".tr,
                  size: 16,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w600,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kBorderColor),
                  ),
                  child: Row(
                    spacing: 11,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CommonImageView(
                        imagePath: Assets.imagesStarBlue,
                        height: 32,
                      ),
                      CommonImageView(
                        imagePath: Assets.imagesStarBlue,
                        height: 32,
                      ),
                      CommonImageView(
                        imagePath: Assets.imagesStarBlue,
                        height: 32,
                      ),
                      CommonImageView(
                        imagePath: Assets.imagesBorderStarBlue,
                        height: 32,
                      ),
                      CommonImageView(
                        imagePath: Assets.imagesBorderStarBlue,
                        height: 32,
                      ),
                    ],
                  ),
                ),
                Gap(12),
                MyText(
                  text: "Review".tr,
                  size: 16,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w600,
                ),
                MyTextField(
                  marginBottom: 16,
                  maxLines: 5,
                  hint: "Write your review".tr,
                  focusNode: focusNodeEmail,
                  focusedFillColor: kWhite,
                ),
                MyButton(
                  buttonText: "Submit Review".tr,

                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void ReviewServiceBottomSheet(BuildContext context) {
  final FocusNode focusNodeEmail = FocusNode();

  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: AppSizes.DEFAULT,
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Provide Feedback".tr,
                      size: 20,
                      color: kBlack,
                      textAlign: TextAlign.start,

                      weight: FontWeight.w700,
                    ),
                  ],
                ),
                Gap(22),
                MyText(
                  text: "Rating".tr,
                  size: 16,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w600,
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: kBorderColor),
                  ),
                  child: Row(
                    spacing: 26,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonImageView(imagePath: Assets.imagesStar, height: 32),
                      CommonImageView(imagePath: Assets.imagesStar, height: 32),
                      CommonImageView(imagePath: Assets.imagesStar, height: 32),
                    ],
                  ),
                ),
                Gap(12),
                MyText(
                  text: "Tell us what you think".tr,
                  size: 16,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w600,
                ),
                MyTextField(
                  marginBottom: 16,
                  maxLines: 5,
                  hint:
                      "Write a few words to explain what happened (optional, but helpful)."
                          .tr,
                  focusNode: focusNodeEmail,
                  focusedFillColor: kWhite,
                ),
                MyButton(
                  buttonText: "Submit".tr,

                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void NewChatBottomSheet(BuildContext context) {
  final List<Map<String, String>> recentlyPlayedItems = [
    {"title": "Jillian Jacobs".tr, "time": "Active".tr},
    {"title": "Jillian Jacobs".tr, "time": "Active".tr},
    {"title": "Jillian Jacobs".tr, "time": "Active".tr},
  ];

  final List<String> imageList = const [
    Assets.imagesChatAvatar2,
    Assets.imagesChatAvatar2,
    Assets.imagesChatAvatar2,
  ];
  Get.bottomSheet(
    isScrollControlled: true,
    Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: const BoxDecoration(
              color: kbackground,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: AppSizes.DEFAULT,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text: "New Message".tr,
                            size: 20,
                            color: kBlack,
                            textAlign: TextAlign.start,

                            weight: FontWeight.w700,
                          ),
                          MyText(
                            text: "Cancel".tr,
                            size: 12,
                            onTap: () {
                              Get.back();
                            },
                            color: kPrimaryColor,
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Gap(22),
                      MyText(
                        text: "To".tr,
                        size: 16,
                        color: kBlack,
                        textAlign: TextAlign.start,
                        paddingBottom: 10,
                        weight: FontWeight.w600,
                      ),
                      MyTextField(
                        hint: "Search here...".tr,
                        bordercolor: kBorderColor,
                        prefix: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CommonImageView(
                            imagePath: Assets.imagesSearchBlue,
                            height: 20,
                          ),
                        ),
                        focusedFillColor: kWhite,
                      ),
                      Gap(12),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: recentlyPlayedItems.length,
                        itemBuilder: (context, index) {
                          final item = recentlyPlayedItems[index];
                          return Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kWhite,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CommonImageView(
                                      imagePath:
                                          imageList[index % imageList.length],
                                      height: 48,
                                      radius: 10,
                                    ),
                                    Gap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          text: item["title"]!,
                                          size: 14,
                                          color: kBlack,
                                          weight: FontWeight.w600,
                                        ),
                                        MyText(
                                          text: item["time"]!,
                                          size: 12,
                                          weight: FontWeight.w400,
                                          color: kSubText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      Gap(50),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: kWhite),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: MyTextField(
                                bordercolor: kBorderColor,
                                marginBottom: 0,
                                hint: "Write a message...".tr,
                                focusedFillColor: kWhite,
                                suffix:
                                    Get.locale?.languageCode == 'en'
                                        ? Row(
                                          spacing: 4,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Bounce(
                                              child: CommonImageView(
                                                imagePath:
                                                    Assets.imagesMicrophone,
                                                height: 20,
                                              ),
                                            ),
                                            Bounce(
                                              child: CommonImageView(
                                                imagePath:
                                                    Assets.imagesAttachCircle,
                                                height: 20,
                                              ),
                                            ),
                                          ],
                                        )
                                        : null,
                                prefix:
                                    Get.locale?.languageCode == 'ar'
                                        ? Row(
                                          spacing: 4,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Bounce(
                                              child: CommonImageView(
                                                imagePath:
                                                    Assets.imagesMicrophone,
                                                height: 20,
                                              ),
                                            ),
                                            Bounce(
                                              child: CommonImageView(
                                                imagePath:
                                                    Assets.imagesAttachCircle,
                                                height: 20,
                                              ),
                                            ),
                                          ],
                                        )
                                        : null,
                              ),
                            ),
                            Gap(10),
                            Bounce(
                              child: CommonImageView(
                                imagePath: Assets.imagesSendButtonBlue,
                                height: 44,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
