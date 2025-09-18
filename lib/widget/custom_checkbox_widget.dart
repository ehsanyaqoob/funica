
import 'package:funica/constants/export.dart';

// Updated CustomCheckbox with optional value parameter
class CustomCheckbox extends StatefulWidget {
  final String? text;
  final String? text2;
  final Color? textcolor;
  final Function(bool) onChanged;
  final bool? value; // Optional value parameter

  const CustomCheckbox({
    super.key,
    this.text,
    this.text2,
    required this.onChanged,
    this.textcolor,
    this.value, // Make value optional
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    // Initialize with the provided value or false
    _isChecked = widget.value ?? false;
  }

  @override
  void didUpdateWidget(CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update state if the value prop changes
    if (widget.value != null && widget.value != _isChecked) {
      setState(() {
        _isChecked = widget.value!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';

    return Row(
      children: [
        if (!isArabic) ...[
          Expanded(
            child: Row(
              children: [
                Bounce(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                    widget.onChanged(_isChecked);
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _isChecked ? kPrimaryColor : kWhite,
                      border: Border.all(
                        color: _isChecked ? kPrimaryColor : kBorderColor,
                        width: 1,
                      ),
                    ),
                    child: _isChecked
                        ? Icon(Icons.check, color: kWhite, size: 16)
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Row(
                    spacing: 4,
                    children: [
                      MyText(
                        text: widget.text ?? '',
                        letterSpacing: 0,
                        size: 12,
                        color: kBlack,
                        weight: FontWeight.w400,
                      ),
                      MyText(
                        text: widget.text2 ?? '',
                        size: 14,
                        color: kBlack,
                        letterSpacing: 0,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    spacing: 4,
                    children: [
                      MyText(
                        text: widget.text ?? '',
                        letterSpacing: 0,
                        size: 12,
                        color: kBlack,
                        weight: FontWeight.w400,
                      ),
                      MyText(
                        text: widget.text2 ?? '',
                        size: 14,
                        color: kBlack,
                        letterSpacing: 0,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Bounce(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                    widget.onChanged(_isChecked);
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _isChecked ? kPrimaryColor : kWhite,
                      border: Border.all(
                        color: _isChecked ? kPrimaryColor : kBorderColor,
                        width: 1,
                      ),
                    ),
                    child: _isChecked
                        ? Icon(Icons.check, color: kWhite, size: 16)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
class CustomCheckbox2 extends StatefulWidget {
  final String? text;
  final String? text2;

  final Color? textcolor;
  final Function(bool) onChanged;

  const CustomCheckbox2({
    super.key,
    this.text,
    this.text2,

    required this.onChanged,
    this.textcolor,
  });

  @override
  _CustomCheckBox2State createState() => _CustomCheckBox2State();
}

class _CustomCheckBox2State extends State<CustomCheckbox2> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = Get.locale?.languageCode == 'ar';

    return Row(
      children: [
        if (!isArabic) ...[
          Expanded(
            child: Row(
              children: [
                Bounce(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                    widget.onChanged(_isChecked);
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _isChecked ? kPrimaryColor : kWhite,
                      border: Border.all(
                        color: _isChecked ? kPrimaryColor : kBorderColor,
                        width: 1,
                      ),
                    ),
                    child:
                        _isChecked
                            ? Icon(Icons.check, color: kWhite, size: 16)
                            : null,
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Row(
                    spacing: 4,
                    children: [
                      MyText(
                        text: widget.text ?? '',
                        letterSpacing: 0,
                        size: 12,
                        color: kSubText,
                        weight: FontWeight.w400,
                      ),
                      MyText(
                        text: widget.text2 ?? '',
                        size: 14,
                        color: kBlack,
                        letterSpacing: 0,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    spacing: 4,
                    children: [
                      MyText(
                        text: widget.text ?? '',
                        letterSpacing: 0,
                        size: 12,
                        color: kBlack,
                        weight: FontWeight.w400,
                      ),
                      MyText(
                        text: widget.text2 ?? '',
                        size: 14,
                        color: kBlack,
                        letterSpacing: 0,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Bounce(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                    widget.onChanged(_isChecked);
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _isChecked ? kPrimaryColor : kWhite,
                      border: Border.all(
                        color: _isChecked ? kPrimaryColor : kBorderColor,
                        width: 1,
                      ),
                    ),
                    child:
                        _isChecked
                            ? Icon(Icons.check, color: kWhite, size: 16)
                            : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
