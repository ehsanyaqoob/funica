import 'package:flutter/material.dart';
import 'package:funica/constants/export.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kDynamicCard(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: kDynamicBorder(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: SvgPicture.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyText(
                text: title,
                size: 14,
                weight: FontWeight.w600,
                color: kDynamicText(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: MyText(
                text: price,
                size: 13,
                color: kDynamicText(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
