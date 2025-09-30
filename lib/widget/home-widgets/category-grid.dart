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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return Bounce(
          onTap: () => widget.onTap?.call(index, item),
          child: Column(
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: kDynamicCard(context),
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: kDynamicBorder(context), width: 1),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    item.icon,
                    color: kDynamicIcon(context),
                    height: 28,
                  ),
                ),
              ),
              const Gap(8),
              MyText(
                text: item.title,
                size: 14,
                weight: FontWeight.w500,
                color: kDynamicText(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
