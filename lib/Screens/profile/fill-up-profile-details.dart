import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:funica/constants/export.dart' hide Country;
import 'package:funica/controller/profile-data-cont.dart';
import 'package:funica/Screens/auth/sign-up.dart';
import 'package:funica/Screens/profile/create-pin.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/toasts.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class FillUpProfileDetailScreen extends StatefulWidget {
  const FillUpProfileDetailScreen({super.key});

  @override
  State<FillUpProfileDetailScreen> createState() =>
      _FillUpProfileDetailScreenState();
}

class _FillUpProfileDetailScreenState extends State<FillUpProfileDetailScreen> {
  final FillUpProfileController _controller = Get.put(
    FillUpProfileController(),
  );

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();

  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    // Set default country
    _selectedCountry = Country(
      phoneCode: "1",
      countryCode: "US",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "United States",
      example: "United States",
      displayName: "United States",
      displayNameNoCountryCode: "US",
      e164Key: "",
    );
    _countryCodeController.text = '+${_selectedCountry!.phoneCode}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _controller.selectedDate = picked;
        // Format: 21/Sep/2025
        _dateController.text = DateFormat("dd/MMM/yyyy").format(picked);
      });
    }
  }

  void _showImagePickerSheet() {
    Get.bottomSheet(
      Container(
        padding: AppSizes.DEFAULT,
        decoration: BoxDecoration(
          color: kDynamicScaffoldBackground(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: kDynamicIcon(context)),
              title: MyText(
                text: "Capture from Camera",
                color: kDynamicText(context),
              ),
              onTap: () {
                _controller.pickFromCamera();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo, color: kDynamicIcon(context)),
              title: MyText(
                text: "Choose from Gallery",
                color: kDynamicText(context),
              ),
              onTap: () {
                _controller.pickFromGallery();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: MyText(text: "Remove", color: kDynamicText(context)),
              onTap: () {
                _controller.removeImage();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showGenderBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: AppSizes.DEFAULT,
        decoration: BoxDecoration(
          color: kDynamicScaffoldBackground(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: kDynamicText(context),
                  ),
                ),
              ],
            ),
            Gap(16),
            MyText(
              text: "Select Gender".tr,
              size: 18,
              color: kDynamicText(context),

              weight: FontWeight.bold,
            ),
            Gap(20),
            ...['Male', 'Female', 'Other'].map((gender) {
              return Bounce(
                onTap: () {
                  setState(() {
                    _genderController.text = gender;
                  });
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: kDynamicContainer(context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        text: gender.tr,
                        size: 14,
                        weight: FontWeight.w500,
                        color: kSubText,
                      ),
                      if (_genderController.text == gender)
                        Icon(Icons.check, color: kPrimaryColor),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          _countryCodeController.text = '+${country.phoneCode}';
        });
      },
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: kDynamicModalBackground(context),
        textStyle: TextStyle(color: kDynamicText(context)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: themeController.isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: themeController.isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: CustomAppBar(
              title: 'Fill Up Profile'.tr,
              showLeading: true,
              onBackTap: () => Get.back(),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const Gap(20),

                    // Profile Picture
                    GetBuilder<FillUpProfileController>(
                      builder: (controller) {
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 76,
                              backgroundColor: kDynamicBackground(context),
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: kDynamicContainer(context),
                                backgroundImage: controller.profileImage != null
                                    ? FileImage(controller.profileImage!)
                                    : null,
                                child: controller.profileImage == null
                                    ? Icon(
                                        Icons.person,
                                        size: 100,
                                        color: Colors.grey.shade600,
                                      )
                                    : null,
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _showImagePickerSheet,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: kDynamicContainer(context),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: kDynamicBorder(context),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.pencilfilled,
                                      height: 20,
                                      color: kDynamicIcon(context),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const Gap(20),

                    // Full Name
                    MyTextField(
                      controller: _fullNameController,
                      hint: "Full Name".tr,
                      prefix: SvgPicture.asset(
                        Assets.personfilled,
                        height: 20,
                        color: kDynamicIcon(context),
                      ),
                    ),
                    const Gap(12),

                    // Nickname
                    MyTextField(
                      controller: _nicknameController,
                      hint: "Nickname".tr,
                      prefix: SvgPicture.asset(
                        Assets.personfilled,
                        height: 20,
                        color: kDynamicIcon(context),
                      ),
                    ),
                    const Gap(12),

                    // Date of Birth
                    MyTextField(
                      controller: _dateController,
                      hint: "Date of Birth".tr,
                      suffix: SvgPicture.asset(
                        Assets.calendarfilled,
                        color: kDynamicIcon(context),
                      ),

                      onTap: () => _selectDate(context),
                    ),
                    const Gap(12),

                    // Gender
                    MyTextField(
                      controller: _genderController,
                      hint: "Gender".tr,
                      suffix: SvgPicture.asset(
                        height: 20,
                        Assets.pencilfilled,
                        color: kDynamicIcon(context),
                      ),
                      onTap: _showGenderBottomSheet,
                    ),
                    const Gap(12),

                    // Email
                    MyTextField(
                      controller: _emailController,
                      hint: "Email".tr,
                      keyboardType: TextInputType.emailAddress,
                      prefix: SvgPicture.asset(
                        Assets.emailfilled,
                        color: kDynamicIcon(context),
                      ),
                    ),
                    const Gap(12),

                    // Phone Number with Country Picker
                    Row(
                      children: [
                        // Country Code Picker
                        SizedBox(
                          width: 100,
                          child: MyTextField(
                            controller: _countryCodeController,
                            hint: "+1",
                            isReadOnly: true,
                            onTap: _showCountryPicker,
                            prefix: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MyText(
                                  text: _selectedCountry?.flagEmoji ?? "🌍",
                                  size: 20,
                                ),
                                Gap(6),
                                MyText(
                                  text: "+${_selectedCountry?.phoneCode ?? ''}",
                                  size: 16,
                                  color: kDynamicText(context),
                                  weight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(8),

                        // Phone Number Field
                        Expanded(
                          child: MyTextField(
                            controller: _phoneController,
                            hint: "Phone Number".tr,
                            keyboardType: TextInputType.phone,
                            prefix: SvgPicture.asset(
                              Assets.phonefilled,
                              color: kDynamicIcon(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const Gap(12),

                    // // Bio
                    // MyTextField(
                    //   controller: _bioController,
                    //   hint: "Bio".tr,
                    //   maxLines: 4,
                    //   prefix: SvgPicture.asset(
                    //     Assets.biofilled,
                    //     color: kDynamicIcon(context),
                    //   ),
                    // ),
                    const Gap(20),

                    // Submit Button
                    GetBuilder<FillUpProfileController>(
                      builder: (controller) {
                        return MyButton(
                          buttonText: "Submit".tr,
                          onTap: () async {
                            if (_validateForm()) {
                              await _controller.submitProfile(
                                fullName: _fullNameController.text,
                                nickname: _nicknameController.text,
                                email: _emailController.text,
                                phone:
                                    '${_countryCodeController.text}${_phoneController.text}',
                                bio: _bioController.text,
                                gender: _genderController.text,
                                dateOfBirth: _controller.selectedDate,
                              );

                              if (controller.isSuccess) {
                                Get.off(() => const CreatePinScreen());
                              } else if (controller.errorMessage.isNotEmpty) {
                                AppToast.error(controller.errorMessage);
                              }
                            }
                          },
                          isLoading: controller.isLoading,
                        );
                      },
                    ),

                    const Gap(20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _validateForm() {
    if (_fullNameController.text.isEmpty) {
      AppToast.error('Please enter your full name'.tr);
      return false;
    }
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      AppToast.error('Please enter a valid email'.tr);
      return false;
    }
    if (_phoneController.text.isEmpty) {
      AppToast.error('Please enter your phone number'.tr);
      return false;
    }
    return true;
  }
}
