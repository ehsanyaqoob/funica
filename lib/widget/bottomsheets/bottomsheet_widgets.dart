import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:funica/constants/export.dart';


class ChatWidgetHeart extends StatelessWidget {
  final String name;
  final String? message;
  final String imagePath;
  final int likeCount;
  final bool isHeartFilled;
  final VoidCallback onHeartToggle;

  const ChatWidgetHeart({
    super.key,
    required this.name,
    this.message,
    required this.imagePath,
    required this.likeCount,
    required this.isHeartFilled,
    required this.onHeartToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonImageView(imagePath: imagePath, height: 56, radius: 10),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: name,
                      color: kBlack,
                      size: 14,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 4),
                    MyText(
                      text: message ?? "",
                      color: kSubText,
                      size: 12,
                      weight: FontWeight.w400,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Bounce(
                      onTap: onHeartToggle,
                      child: CommonImageView(
                        imagePath:
                            isHeartFilled
                                ? Assets.imagesHeartBlue
                                : Assets.imagesEmptyHeart,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 4),
                    MyText(
                      text: likeCount.toString(),
                      color: kSubText,
                      size: 12,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
