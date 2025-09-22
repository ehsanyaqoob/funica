import 'package:funica/constants/export.dart';
import 'package:funica/widget/dot-loader.dart';

class MyButtonWithIcon extends StatelessWidget {
  const MyButtonWithIcon({
    super.key,
    this.onTap,
    this.onTapWithParam,
    required this.text,
    required this.icon,
    this.height = 58,
    this.width,
    this.color,
    this.textColor,
    this.fontSize,
    this.outlineColor = Colors.transparent,
    this.radius = 20,
    this.mhoriz = 0,
    this.mBottom = 0,
    this.mTop = 0,
    this.fontWeight,
    this.isLoading = false,
    this.loaderColor,
    this.param,
    this.iconSize = 24,
    this.iconColor,
    this.spaceBetween = 8,
    this.hasShadow = false,
    this.isActive = true,
  });

  final String text;
  final IconData icon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onTapWithParam;
  final String? param;

  final double? height;
  final double? width;
  final double radius;
  final double? fontSize;
  final double iconSize;
  final double spaceBetween;
  final Color outlineColor;
  final Color? color;
  final Color? textColor;
  final Color? iconColor;
  final bool hasShadow;
  final bool isActive;
  final double mTop, mBottom, mhoriz;
  final FontWeight? fontWeight;
  final bool isLoading;
  final Color? loaderColor;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: const Duration(milliseconds: 1000)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isActive ? 100 : 0),
        onTap: isLoading
            ? () {}
            : () {
                if (onTap != null) {
                  onTap!();
                } else if (onTapWithParam != null && param != null) {
                  onTapWithParam!(param!);
                }
              },
        child: Container(
          margin: EdgeInsets.only(
            top: mTop,
            bottom: mBottom,
            left: mhoriz,
            right: mhoriz,
          ),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: isActive
                ? color ?? kPrimaryColor
                : color ?? const Color(0xff0E1A34).withOpacity(0.35),
            border: Border.all(color: outlineColor),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: hasShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(radius),
              onTap: isLoading
                  ? null
                  : () {
                      if (onTap != null) {
                        onTap!();
                      } else if (onTapWithParam != null && param != null) {
                        onTapWithParam!(param!);
                      }
                    },
              child: Center(
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            loaderColor ?? Colors.white,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon on the left
                          Icon(
                            icon,
                            size: iconSize,
                            color: iconColor ?? textColor ?? kWhite,
                          ),
                          SizedBox(width: spaceBetween),
                          MyText(
                            text: text,
                            fontFamily: AppFonts.Figtree,
                            size: fontSize ?? 16,
                            letterSpacing: 0.5,
                            color: textColor ?? kWhite,
                            weight: fontWeight ?? FontWeight.w800,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.onTap,
    this.onTapWithParam,
    required this.buttonText,
    this.height = 50,
    this.width,
    this.backgroundColor,
    this.fontColor,
    this.fontSize,
    this.outlineColor,
    this.radius = 30.0,
    this.choiceIcon,
    this.isleft = false,
    this.mhoriz = 0,
    this.hasicon = false,
    this.hasshadow = false,
    this.mBottom = 0,
    this.hasgrad = false,
    this.isactive = true,
    this.mTop = 0,
    this.fontWeight,
    this.isLoading = false,
    this.loaderColor,
    this.param,
  });

  final String buttonText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onTapWithParam;
  final String? param;

  final double? height;
  final double? width;
  final double radius;
  final double? fontSize;
  final Color? outlineColor;
  final bool hasicon, isleft, hasshadow, hasgrad, isactive;
  final Color? backgroundColor, fontColor;
  final String? choiceIcon;
  final double mTop, mBottom, mhoriz;
  final FontWeight? fontWeight;
  final bool isLoading;
  final Color? loaderColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = isactive
        ? backgroundColor ?? kDynamicButtonBackground(context)
        : kDynamicButtonDisabled(context);

    final txtColor = fontColor ?? kDynamicButtonText(context);
    
    // Determine the appropriate loader color based on button background
    final Color effectiveLoaderColor = loaderColor ?? _getLoaderColorForButton(bgColor, context);

    return Animate(
      effects: [
        FadeEffect(duration: const Duration(milliseconds: 500)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isactive ? 100 : 0),
        onTap: isLoading
            ? () {}
            : () {
                if (onTap != null) {
                  onTap!();
                } else if (onTapWithParam != null && param != null) {
                  onTapWithParam!(param!);
                }
              },
        child: Container(
          margin: EdgeInsets.only(
            top: mTop,
            bottom: mBottom,
            left: mhoriz,
            right: mhoriz,
          ),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: hasgrad ? null : bgColor,
            gradient: hasgrad ? kDynamicPrimaryGradient(context) : null,
            border: Border.all(color: outlineColor ?? kDynamicOutline(context)),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: hasshadow
                ? [
                    BoxShadow(
                      color: kDynamicShadow(context),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: isLoading
                  ? FunicaLoader(color: effectiveLoaderColor) // Pass the loader color
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasicon)
                          Padding(
                            padding: isleft
                                ? const EdgeInsets.only(left: 10.0)
                                : const EdgeInsets.only(right: 6),
                            child: CommonImageView(
                              imagePath: choiceIcon,
                              height: 18,
                              color: txtColor,
                            ),
                          ),
                        MyText(
                          paddingLeft: hasicon ? 8 : 0,
                          text: buttonText,
                          fontFamily: AppFonts.Figtree,
                          size: fontSize ?? 16,
                          letterSpacing: 0.5,
                          color: txtColor,
                          weight: fontWeight ?? FontWeight.w800,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to determine the best loader color for the button background
  Color _getLoaderColorForButton(Color? buttonBgColor, BuildContext context) {
    if (buttonBgColor == null) {
      return kDynamicText(context); // Fallback to text color
    }
    
    // Calculate the brightness of the button background
    final brightness = ThemeData.estimateBrightnessForColor(buttonBgColor);
    
    // Return contrasting color based on button background
    return brightness == Brightness.dark ? kWhite : kBlack;
  }
}
// ignore: must_be_immutable
class MyBorderButton extends StatelessWidget {
  MyBorderButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.height = 48,
    this.width,
    this.backgroundColor,
    this.fontColor,
    this.fontSize = 16,
    this.outlineColor,
    this.radius = 7,
    this.haveSvg = false,
    this.isleft = false,
    this.mhoriz = 0,
    this.child,
    this.hasicon = false,
    this.hasshadow = false,
    this.mBottom = 0,
    this.hasgrad = false,
    this.isactive = true,
    this.mTop = 0,
    this.fontWeight = FontWeight.w400,
    this.svgIcon,
    this.choiceIcon,
    this.rightpadding,
  });

  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final String? svgIcon, choiceIcon;
  final double? rightpadding;
  final double radius;
  final double fontSize;
  final Color? outlineColor;
  final bool hasicon, isleft, hasshadow, hasgrad, isactive;
  final Color? backgroundColor, fontColor;
  final bool haveSvg;
  final double mTop, mBottom, mhoriz;
  final FontWeight fontWeight;

  FontWeight? weight;
  Widget? child;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: Duration(milliseconds: 1000)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isactive ? 100 : 0),
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(
            top: mTop,
            bottom: mBottom,
            left: mhoriz,
            right: mhoriz,
          ),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: isactive
                ? backgroundColor ?? kTransperentColor
                : backgroundColor ?? Color(0xff0E1A34).withOpacity(0.35),
            border: Border.all(color: outlineColor ?? kBorderColor),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasicon)
                  Padding(
                    padding: isleft
                        ? const EdgeInsets.only(left: 10.0)
                        : const EdgeInsets.only(right: 0),
                    child: CommonImageView(imagePath: choiceIcon, height: 16),
                  ),
                MyText(
                  paddingLeft: hasicon ? 10 : 0,
                  text: buttonText,
                  fontFamily: AppFonts.Figtree,
                  size: 16,
                  paddingRight: rightpadding ?? 0,
                  letterSpacing: 0.5,
                  color: fontColor ?? kWhite,
                  weight: fontWeight ?? FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyBorderButtonwithWidth extends StatelessWidget {
  MyBorderButtonwithWidth({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isactive = true,
    this.height = 48,
    this.Width,
    this.textSize,
    this.weight,
    this.child,
    this.radius,
    this.textColor,
    this.bgColor,
    this.kcontainerbgColor,
    this.fontFamily,
  });

  final String? fontFamily;

  final String buttonText;
  final VoidCallback onTap;
  double? height, Width, textSize;
  FontWeight? weight;
  Widget? child;
  double? radius;
  bool isactive;

  Color? bgColor, kcontainerbgColor, textColor;
  dynamic bgGradinetColor; // Allow both Color and Gradient

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: Duration(milliseconds: 1000)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isactive ? 100 : 0),
        child: Container(
          height: height,
          width: Width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 10),
            color: kcontainerbgColor ?? Colors.transparent,
            border: Border.all(width: 1.0, color: kPrimaryColor),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: bgColor!.withOpacity(0.1),
              highlightColor: bgColor!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(radius ?? 10),
              child:
                  child ??
                  Center(
                    child: MyText(
                      text: buttonText,
                      size: textSize ?? 16,
                      letterSpacing: 0.5,
                      weight: weight ?? FontWeight.w500,
                      color: textColor ?? kWhite,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthButtons extends StatelessWidget {
  final String img;
  final bool isactive;
  final VoidCallback? onTap;
  final String? text;
  final double? width;

  const AuthButtons({
    super.key,
    this.onTap,
    required this.img,
    this.isactive = true,
    this.text,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: Duration(milliseconds: 1000)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isactive ? 100 : 0),
        onTap: onTap,
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CommonImageView(imagePath: img, height: 24),
                if (text != null && text!.isNotEmpty) // Conditional rendering
                  MyText(
                    text: text ?? "",
                    size: 16,
                    weight: FontWeight.w600,
                    color: kBlack,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyGradientButton extends StatelessWidget {
  const MyGradientButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.height = 48,
    this.width,
    this.backgroundColor,
    this.gradient,
    this.fontColor,
    this.fontSize,
    this.outlineColor = Colors.transparent,
    this.radius = 10,
    this.svgIcon,
    this.haveSvg = false,
    this.choiceIcon,
    this.isleft = false,
    this.mhoriz = 0,
    this.hasicon = false,
    this.hasshadow = false,
    this.mBottom = 0,
    this.hasgrad = false,
    this.isactive = true,
    this.mTop = 0,
    this.fontWeight,
  });

  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double radius;
  final double? fontSize;
  final Color outlineColor;
  final bool hasicon, isleft, hasshadow, hasgrad, isactive;
  final Color? backgroundColor, fontColor;
  final LinearGradient? gradient;
  final String? svgIcon, choiceIcon;
  final bool haveSvg;
  final double mTop, mBottom, mhoriz;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: Duration(milliseconds: 1000)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isactive ? 100 : 0),
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(
            top: mTop,
            bottom: mBottom,
            left: mhoriz,
            right: mhoriz,
          ),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: hasgrad
                ? null
                : (isactive
                      ? backgroundColor ?? kPrimaryColor
                      : backgroundColor?.withOpacity(0.35) ??
                            Color(0xff0E1A34).withOpacity(0.35)),
            gradient: hasgrad ? gradient : null,
            border: Border.all(color: outlineColor),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (hasicon)
                  Padding(
                    padding: isleft
                        ? const EdgeInsets.only(left: 20.0)
                        : const EdgeInsets.only(right: 10),
                    child: CommonImageView(imagePath: choiceIcon, height: 16),
                  ),
                MyText(
                  paddingLeft: hasicon ? 10 : 0,
                  text: buttonText,
                  fontFamily: AppFonts.Figtree,
                  size: fontSize ?? 16,
                  letterSpacing: 0.5,
                  color: fontColor ?? kWhite,
                  weight: fontWeight ?? FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
