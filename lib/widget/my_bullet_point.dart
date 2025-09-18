import 'package:funica/constants/export.dart';


// ignore: must_be_immutable
class MyBullet extends StatelessWidget {
  MyBullet({super.key, required this.point, this.size});
  String point;
  double? size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: '•',
            //paddingLeft: 25,
            color: kSubText,
            paddingRight: 10,
          ),
          Expanded(
            child: MyText(text: point, color: kSubText, size: size ?? 14),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
