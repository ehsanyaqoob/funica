
import 'package:funica/constants/export.dart';

void FliterServicesBottomSheet2(BuildContext context) {
  List<String> Filters = [
    "Sort".tr,
    "Rating".tr,
    "Country".tr,
    "City".tr,
    "Category".tr,
    "Agent".tr,
  ];

  String selectedFilter = "Sort".tr;

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
                Gap(10),
                Column(
                  children:
                      Filters.map((filter) {
                        return Bounce(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: kWhite,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: filter,
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kSubText,
                                ),
                                CommonImageView(
                                  imagePath: Assets.imagesArrowRight,
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
                Gap(24),

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

void FilterServicesBottomSheet(BuildContext context) {
  List<String> filters = [
    "Sort".tr,
    "Rating".tr,
    "Country".tr,
    "City".tr,
    "Category".tr,
    "Agent".tr,
  ];

  String selectedFilter = "Sort".tr;

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
                Gap(10),
                Column(
                  children:
                      filters.map((filter) {
                        return Bounce(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });

                            // Close current bottom sheet first
                            Get.back();

                            // Open new bottom sheet after a short delay
                            Future.delayed(Duration(milliseconds: 200), () {
                              // Compare with translated strings instead of hardcoded English
                              if (filter == "Sort".tr) {
                                FliterServicesSortBottomSheet(context);
                              } else if (filter == "Rating".tr) {
                                FliterServicesRatingBottomSheet(context);
                              } else if (filter == "Country".tr) {
                                FliterServicesCountryBottomSheet(context);
                              } else if (filter == "City".tr) {
                                FliterServicesCityBottomSheet(context);
                              } else if (filter == "Category".tr) {
                                FliterServicesCategoryBottomSheet(context);
                              } else if (filter == "Agent".tr) {
                                FliterServicesAgnetBottomSheet(context);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            margin: EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: kWhite,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: filter,
                                  size: 14,
                                  weight: FontWeight.w500,
                                  color: kSubText,
                                ),
                                CommonImageView(
                                  imagePath: Assets.imagesArrowRight,
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
                Gap(24),
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

void FliterServicesSortBottomSheet(BuildContext context) {
  List<String> filters = ["Relevance".tr, "Distance".tr, "Rating".tr];

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
                MyText(
                  text: "Sort".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
                Gap(10),
                Column(
                  children: List.generate(filters.length, (pollIndex) {
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
                                    filters[pollIndex], // Use the correct variable
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
                Gap(24),
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

void FliterServicesRatingBottomSheet(BuildContext context) {
  List<String> filters = ["5".tr, "≥4".tr, "≥3".tr, "≥2".tr, "≥1".tr];

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
                MyText(
                  text: "Rating".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
                Gap(10),
                Column(
                  children: List.generate(filters.length, (pollIndex) {
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
                                        ? kPrimaryColor
                                        : kTransperentColor,
                              ),
                              child: Center(
                                child:
                                    selectedOptionIndex == pollIndex
                                        ? Padding(
                                          padding: const EdgeInsets.all(1),
                                          child: Icon(
                                            Icons.check,
                                            size: 12,
                                            color: kWhite,
                                          ),
                                        )
                                        : Container(),
                              ),
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
                                    color: kSubText,
                                  ),

                                  CommonImageView(
                                    imagePath: Assets.imagesStar,
                                    height: 12,
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

void FliterServicesCountryBottomSheet(BuildContext context) {
  String selectedCountry = "Select Country".tr; // Default selected value

  // Sample items for the dropdown
  final List<String> countryItems = [
    "United States".tr,
    "United Kingdom".tr,
    "Canada".tr,
    "Australia".tr,
    "New Zealand".tr,
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
                MyText(
                  text: "Country".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
                Gap(10),
                CustomDropDown2(
                  hint: "Select Country".tr,
                  items: countryItems,
                  leftImage: Assets.imagesSearchBlue, // Optional

                  selectedValue: selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                  },
                  // isArabic: isArabic,
                ),
                Gap(24),
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

void FliterServicesCityBottomSheet(BuildContext context) {
  String selectedCountry = "Select City".tr; // Default selected value

  // Sample items for the dropdown
  final List<String> countryItems = [
    "United States".tr,
    "United Kingdom".tr,
    "Canada".tr,
    "Australia".tr,
    "New Zealand".tr,
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
                MyText(
                  text: "City".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
                Gap(10),
                CustomDropDown2(
                  leftImage: Assets.imagesSearchBlue, // Optional

                  hint: "Select City".tr,
                  items: countryItems,

                  selectedValue: selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                  },
                  // isArabic: isArabic,
                ),
                Gap(24),
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

void FliterServicesCategoryBottomSheet(BuildContext context) {
  List<String> filters = [
    "Tutoring".tr,
    "Real Estate".tr,
    "Food".tr,
    "Transport".tr,
    "Healthcare".tr,
    "Fitness".tr,
    "Legal".tr,
    "Other".tr,
  ];

  List<int> selectedOptionsIndices = []; // List to hold selected indices

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
                MyText(
                  text: "Category".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
                Gap(10),
                Column(
                  children: List.generate(filters.length, (pollIndex) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selectedOptionsIndices.contains(pollIndex)) {
                            selectedOptionsIndices.remove(
                              pollIndex,
                            ); // Deselect
                          } else {
                            selectedOptionsIndices.add(pollIndex); // Select
                          }
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
                                selectedOptionsIndices.contains(pollIndex)
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
                                      selectedOptionsIndices.contains(pollIndex)
                                          ? kPrimaryColor
                                          : kBorderColor2,
                                ),
                                shape: BoxShape.circle,
                                color:
                                    selectedOptionsIndices.contains(pollIndex)
                                        ? kPrimaryColor
                                        : kTransperentColor,
                              ),
                              child: Center(
                                child:
                                    selectedOptionsIndices.contains(pollIndex)
                                        ? Padding(
                                          padding: const EdgeInsets.all(1),
                                          child: Icon(
                                            Icons.check,
                                            size: 12,
                                            color: kWhite,
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
                                text: filters[pollIndex],
                                size: 14,
                                weight: FontWeight.w500,
                                color: kSubText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Gap(24),
                MyButton(
                  buttonText: "Apply changes".tr,
                  onTap: () {
                    Get.back();
                    // Handle the selected options as needed
                    print(
                      "Selected categories: ${selectedOptionsIndices.map((index) => filters[index]).toList()}",
                    );
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

void FliterServicesAgnetBottomSheet(BuildContext context) {
  String selectedCountry = "Select Agent".tr; // Default selected value

  // Sample items for the dropdown
  final List<String> countryItems = [
    "United States".tr,
    "United Kingdom".tr,
    "Canada".tr,
    "Australia".tr,
    "New Zealand".tr,
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
                MyText(
                  text: "Agent".tr,
                  size: 20,
                  color: kBlack,
                  textAlign: TextAlign.start,
                  paddingBottom: 10,
                  weight: FontWeight.w700,
                ),
                Gap(10),
                CustomDropDown2(
                  leftImage: Assets.imagesSearchBlue, // Optional

                  hint: "Select Agent".tr,
                  items: countryItems,

                  selectedValue: selectedCountry,
                  onChanged: (value) {
                    setState(() {
                      selectedCountry = value;
                    });
                  },
                  // isArabic: isArabic,
                ),
                Gap(24),
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
