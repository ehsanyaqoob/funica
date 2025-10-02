import 'package:funica/constants/export.dart';
import 'package:funica/models/category-model.dart';

class CategoryGrid extends StatefulWidget {
  final List<CategoryModel> items;
  final void Function(int index, CategoryModel item)? onTap;

  const CategoryGrid({super.key, required this.items, this.onTap});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return Center(
        child: MyText(
          text: "No categories available",
          size: 16,
          color: kDynamicCaptionText(context),
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Bounce(
          onTap: () => widget.onTap?.call(index, item),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: kDynamicCard(context),
                  borderRadius: BorderRadius.circular(32.0),
                  border: Border.all(
                    color: kDynamicBorder(context),
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    item.icon,
                    color: kDynamicIcon(context),
                    height: 24,
                  ),
                ),
              ),
              const Gap(8),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText(
                    text: item.title,
                    size: 14,
                    weight: FontWeight.w500,
                    color: kDynamicText(context),
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
