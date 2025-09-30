import 'package:funica/constants/export.dart';
import 'package:funica/controller/fav-cont.dart';
import 'package:funica/widget/home-widgets/reviews-screen.dart';
import 'package:funica/models/product-model.dart'; // Import your ProductModel

class ProductCard extends StatefulWidget {
  final ProductModel product; // Accept full product object
  final bool initialIsLiked;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onLikeChanged;

  const ProductCard({
    super.key,
    required this.product, // Only need product now
    this.initialIsLiked = false,
    this.onTap,
    this.onLikeChanged,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
late bool _isLiked;
  final FavouritesController favouritesController = Get.find<FavouritesController>();
  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
  }

 void _handleLikeTap() {
  setState(() {
    _isLiked = !_isLiked;
  });
  favouritesController.toggleFavourite(widget.product, _isLiked);
  widget.onLikeChanged?.call(_isLiked);
}


  void _handleReviewsTap() {
    Get.to(
      () => ReviewsScreen(
        product: widget.product, // Use widget.product
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Container
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: kDynamicCard(context),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kDynamicBorder(context)),
            ),
            child: Stack(
              children: [
                // Center Image
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      widget.product.image, // Use widget.product.image
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                // Top Right Heart Icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _handleLikeTap,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: kDynamicContainer(context),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        _isLiked ? Assets.heartfilled : Assets.heartunfilled,
                        height: 26.0,
                        color: _isLiked ? Colors.red : kDynamicIcon(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(8),
          // Product Details
          MyText(
            text: widget.product.title, // Use widget.product.title
            size: 14,
            weight: FontWeight.w600,
            color: kDynamicText(context),
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
          ),
          const Gap(4),
          // Reviews and Views
          Row(
            children: [
              SvgPicture.asset(
                Assets.starfilled,
                height: 8,
                color: kYellowColor,
              ),
              const Gap(4),
              MyText(
                text: widget.product.reviews, // Use widget.product.reviews
                size: 12, 
                color: kDynamicListTileSubtitle(context)
              ),
              const Gap(8),
              MyText(
                text: '|', 
                size: 12, 
                color: kDynamicListTileSubtitle(context)
              ),
              const Gap(8),
              Bounce(
                onTap: _handleReviewsTap, // Use the method
                child: MyText(
                  text: '${widget.product.viewCount} views', // Use widget.product.viewCount
                  size: 12, 
                  color: kDynamicListTileSubtitle(context)
                ),
              ),
            ],
          ), 
          const Gap(4),
          // Price
          MyText(
            text: widget.product.price, // Use widget.product.price
            size: 16,
            weight: FontWeight.bold,
            color: kDynamicText(context),
          ),
        ],
      ),
    );
  }
}