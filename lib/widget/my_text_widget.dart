
import 'package:funica/constants/export.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final Color decorationColor;

  final int? maxLines;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;

  const MyText({
    super.key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines = 100,
    this.decoration = TextDecoration.none,
    this.color,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.decorationColor = Colors.transparent,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.fontStyle,
  });

  @override
  Widget build(BuildContext context) {
    final String currentLangCode = Get.locale?.languageCode ?? 'en';
    final bool isArabic = currentLangCode == 'ar' || currentLangCode == 'sa';

    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 500))],
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop!,
          left: paddingLeft!,
          right: paddingRight!,
          bottom: paddingBottom!,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            "$text".tr,
            style: TextStyle(
              fontSize: size,
              color: color ?? kWhite,
              fontWeight: weight,
              decoration: decoration,
              decorationColor: decorationColor,
              fontFamily: fontFamily ?? AppFonts.Figtree,
              height: lineHeight ?? 1.5,
              fontStyle: fontStyle,
              letterSpacing: 0,
            ),
            textAlign:
                textAlign ?? (isArabic ? TextAlign.right : TextAlign.left),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            maxLines: maxLines,
            overflow: textOverflow,
          ),
        ),
      ),
    );
  }
}
