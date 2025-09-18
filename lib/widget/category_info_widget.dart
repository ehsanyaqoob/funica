
import 'package:funica/constants/export.dart';

class CategoryInfoWidget extends StatelessWidget {
  final String categoryTitle;
  final String categoryName;
  final String imagePath;
  final bool arrowright;

  const CategoryInfoWidget({
    super.key,
    required this.categoryTitle,
    required this.categoryName,
    required this.imagePath,
    this.arrowright = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: categoryTitle.tr,
            size: 12,
            weight: FontWeight.w600,
            color: kBlack,
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonImageView(imagePath: imagePath, height: 18),
                  SizedBox(width: 6),
                  MyText(
                    text: categoryName.tr,
                    size: 12,
                    weight: FontWeight.w600,
                    color: kSubText,
                  ),
                ],
              ),
              if (arrowright)
                CommonImageView(
                  imagePath: Assets.imagesArrowRightGreyNew,
                  height: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
