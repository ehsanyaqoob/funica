import 'package:funica/controller/fav-cont.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/widget/home-widgets/reviews-screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/models/product-model.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product;
  final bool initialIsLiked;
  final ValueChanged<bool>? onLikeChanged;

  const ProductDetailsView({
    super.key,
    required this.product,
    this.initialIsLiked = false,
    this.onLikeChanged,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  final FavouritesController favouritesController = Get.find<FavouritesController>();
  final ProductController productController = Get.put(ProductController());
  late bool _isLiked;
  bool isExpanded = false;

  final List<Color> _colors = [
    Colors.brown,
    Colors.grey,
    Colors.purple,
    Colors.teal,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
    productController.resetSelection();
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
      () => ReviewsScreen(product: widget.product),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _handleAddToCart() {
    productController.addToCart(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery.of(context).size.height * 0.5,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            _isLiked ? Assets.heartfilled : Assets.heartunfilled,
                            height: 30,
                            color: _isLiked ? Colors.red : Colors.white,
                          ),
                          onPressed: _handleLikeTap,
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: 6,
                          itemBuilder: (_, index) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              child: Image.asset(
                                widget.product.image,
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: 6,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: kPrimaryColor,
                                dotColor: kGreyColor4.withOpacity(0.5),
                                spacing: 6,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSizes.DEFAULT,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: widget.product.title,
                          size: 28,
                          weight: FontWeight.bold,
                          color: kDynamicText(context),
                        ),
                        const Gap(6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: kDynamicCard(context),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: kDynamicBorder(context),
                                ),
                              ),
                              child: MyText(
                                text: "${widget.product.viewCount} sold",
                                size: 14,
                                weight: FontWeight.w500,
                                color: kDynamicText(context),
                              ),
                            ),
                            const Gap(16.0),
                            Bounce(
                              onTap: _handleReviewsTap,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.starfilled,
                                    height: 18,
                                    color: kDynamicIcon(context),
                                  ),
                                  const Gap(6),
                                  MyText(
                                    text: widget.product.reviews,
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: kDynamicText(context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(6),
                        Divider(
                          thickness: 1.5,
                          color: kDynamicDivider(context),
                        ),
                        const Gap(6),
                        MyText(
                          text: "Description",
                          size: 22,
                          weight: FontWeight.bold,
                          color: kDynamicText(context),
                        ),
                        const Gap(12),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          firstChild: MyText(
                            text: widget.product.description,
                            size: 16,
                            color: kDynamicListTileSubtitle(context),
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          secondChild: MyText(
                            text: widget.product.description,
                            size: 16,
                            color: kDynamicListTileSubtitle(context),
                          ),
                          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        ),
                        const Gap(6),
                        Bounce(
                          onTap: () => setState(() => isExpanded = !isExpanded),
                          child: MyText(
                            text: isExpanded ? "View Less" : "View More",
                            size: 16,
                            weight: FontWeight.w600,
                            color: kDynamicText(context),
                          ),
                        ),
                        const Gap(6),
                        MyText(
                          text: "Color",
                          size: 22,
                          weight: FontWeight.bold,
                          color: kDynamicText(context),
                        ),
                        const Gap(6),
                        Row(
                          children: [
                            for (int i = 0; i < _colors.length; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {});
                                  productController.setSelectedColor(i);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _colors[i],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: productController.selectedColorIndex.value == i
                                          ? kDynamicBorder(context)
                                          : Colors.transparent,
                                      width: 2.5,
                                    ),
                                  ),
                                  child: productController.selectedColorIndex.value == i
                                      ? SvgPicture.asset(
                                          Assets.check,
                                          height: 22,
                                          color: kDynamicIcon(context),
                                        )
                                      : const SizedBox(width: 16, height: 16),
                                ),
                              ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            MyText(
                              text: "Quantity",
                              size: 22,
                              weight: FontWeight.bold,
                              color: kDynamicText(context),
                            ),
                            const Gap(16.0),
                            Container(
                              decoration: BoxDecoration(
                                color: kDynamicCard(context),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: kDynamicBorder(context),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: productController.decreaseQuantity,
                                    icon: SvgPicture.asset(
                                      Assets.minus,
                                      color: kDynamicIcon(context),
                                      height: 26,
                                    ),
                                  ),
                                  Obx(() => Container(
                                    width: 60,
                                    alignment: Alignment.center,
                                    child: MyText(
                                      text: productController.quantity.value.toString(),
                                      size: 18,
                                      weight: FontWeight.bold,
                                      color: kDynamicText(context),
                                    ),
                                  )),
                                  IconButton(
                                    onPressed: productController.increaseQuantity,
                                    icon: SvgPicture.asset(
                                      Assets.add,
                                      color: kDynamicIcon(context),
                                      height: 26,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16.0),
                        Divider(
                          thickness: 1.5,
                          color: kDynamicDivider(context),
                        ),
                        const Gap(32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: kDynamicScaffoldBackground(context),
                boxShadow: [
                  BoxShadow(
                    color: kDynamicShadow(context),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(26.0),
                  topRight: Radius.circular(26.0),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: "Total Price",
                        size: 14,
                        color: kDynamicListTileSubtitle(context),
                      ),
                      const Gap(2),
                      Obx(() => MyText(
                        text: _calculateTotalPrice(),
                        size: 24,
                        weight: FontWeight.bold,
                        color: kDynamicText(context),
                      )),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: MyButtonWithIcon(
                      iconPath: Assets.cartfilled,
                      text: "Add to Cart",
                      onTap: _handleAddToCart,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _calculateTotalPrice() {
    final price = double.tryParse(widget.product.price.replaceAll('\$', '')) ?? 0;
    final total = price * productController.quantity.value;
    return '\$${total.toStringAsFixed(2)}';
  }

  String _getPriceWithoutDollarSign() {
    String price = widget.product.price;
    if (price.startsWith('\$')) {
      return price;
    } else {
      return '\$$price';
    }
  }
}