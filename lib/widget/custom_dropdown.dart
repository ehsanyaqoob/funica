
import 'package:funica/constants/export.dart';

class CustomDropDown2 extends StatelessWidget {
  const CustomDropDown2({
    super.key,
    required this.hint,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.bgColor,
    this.marginBottom,
    this.width,
    this.labelText,
    this.leftImage,
  });

  final List<dynamic>? items;
  final String selectedValue;
  final ValueChanged<dynamic>? onChanged;
  final String hint;
  final String? labelText;
  final Color? bgColor;
  final double? marginBottom, width;
  final String? leftImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: marginBottom ?? 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (labelText != null)
            MyText(
              paddingBottom: 10,
              text: labelText!,
              size: 16,
              color: kBlack,
              fontFamily: AppFonts.Figtree,
              textAlign:
                  Get.locale?.languageCode == 'ar'
                      ? TextAlign.end
                      : TextAlign.start,
              weight: FontWeight.w600,
            ),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              items:
                  items!
                      .map(
                        (item) => DropdownMenuItem<dynamic>(
                          value: item,
                          child: MyText(
                            text: item,
                            size: 12,
                            color: kBlack,
                            weight: FontWeight.w600,
                            fontFamily: AppFonts.Figtree,
                            textAlign:
                                Get.locale?.languageCode == 'ar'
                                    ? TextAlign.end
                                    : TextAlign.start,
                          ),
                        ),
                      )
                      .toList(),
              value: selectedValue == hint ? null : selectedValue,
              hint: MyText(
                text: hint,
                size: 12,
                color: kSubText,
                fontFamily: AppFonts.Figtree,
                textAlign:
                    Get.locale?.languageCode == 'ar'
                        ? TextAlign.end
                        : TextAlign.start,
                weight: FontWeight.w500,
              ),
              onChanged: onChanged,
              iconStyleData: const IconStyleData(icon: SizedBox()),
              isDense: true,
              isExpanded: true,
              customButton: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 48,
                decoration: BoxDecoration(
                  color: kWhite,
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CommonImageView(
                          imagePath:
                              leftImage ?? Assets.imagesArrowRdownGrey,
                          height: 16,
                        ),
                        MyText(
                          paddingLeft: 10,
                          paddingRight: 10,
                          text:
                              selectedValue == hint ? hint : selectedValue,
                          size: 12,
                          color: kSubText,
                          weight: FontWeight.w600,
                          fontFamily: AppFonts.Figtree,
                          textAlign:
                              Get.locale?.languageCode == 'ar'
                                  ? TextAlign.start
                                  : TextAlign.end,
                        ),
                      ],
                    ),
                    CommonImageView(
                      imagePath: Assets.imagesArrowRdownGrey,
                      height: 16,
                    ),
                  ],
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(height: 35),
              dropdownStyleData: DropdownStyleData(
                elevation: 6,
                maxHeight: 300,
                offset: const Offset(0, -5),
                decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  borderRadius: BorderRadius.circular(10),
                  color: kWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
