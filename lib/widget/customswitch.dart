
import 'package:funica/constants/export.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 46,
        height: 25,
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor),
          borderRadius: BorderRadius.circular(12),
          color: value ? kBlack : null,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              left: value ? 25 : 2,
              top: 5,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kbackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomSwitch2 extends StatelessWidget {
//   final bool value;
//   final ValueChanged<bool> onChanged;

//   const CustomSwitch2({
//     super.key,
//     required this.value,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onChanged(!value),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         width: 44,
//         height: 14,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: value ? kGrey2 : null, // Active & inactive colors
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             AnimatedPositioned(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               left: value ? 22 : 2, // Toggle button movement
//               child: Container(
//                 width: 20,
//                 height: 20,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: kPrimaryColor,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.2),
//                       blurRadius: 3,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomSwitch2 extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch2({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: SizedBox(
        width: 40, // Matches the image proportions
        height: 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kBorderColor),
                color: value ? kPrimaryColor : kGreylightColor,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: value ? 21 : 2, // Adjusts knob position
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border: Border.all(color: kBorderColor),
                  shape: BoxShape.circle,
                  color: kWhite, // Knob color as in image
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}