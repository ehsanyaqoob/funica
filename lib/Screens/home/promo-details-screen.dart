import 'package:funica/constants/export.dart';
import 'package:funica/widget/home-widgets/promo-offers-card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromoDetailView extends StatefulWidget {
  final PromoCardModel item;

  const PromoDetailView({super.key, required this.item});

  @override
  State<PromoDetailView> createState() => _PromoDetailViewState();
}

class _PromoDetailViewState extends State<PromoDetailView> {
  final PageController _pageController = PageController();
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness:
                isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            body: CustomScrollView(
              slivers: [
                /// Top section like product details
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: MediaQuery.of(context).size.height * 0.45,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 20),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: 1, // single promo image
                          itemBuilder: (_, __) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              ),
                              child: Image.asset(
                                widget.item.image,
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
                              count: 1,
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

                /// Content Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: AppSizes.DEFAULT,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: widget.item.discount,
                          size: 28,
                          weight: FontWeight.bold,
                          color: kDynamicText(context),
                        ),
                        const Gap(8),
                        MyText(
                          text: widget.item.title,
                          size: 22,
                          weight: FontWeight.w600,
                          color: kDynamicText(context),
                        ),
                        const Gap(12),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          firstChild: MyText(
                            text: widget.item.subtitle,
                            size: 16,
                            color: kDynamicListTileSubtitle(context),
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          secondChild: MyText(
                            text: widget.item.subtitle,
                            size: 16,
                            color: kDynamicListTileSubtitle(context),
                          ),
                          crossFadeState: isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                        ),
                        const Gap(8),
                        Bounce(
                          onTap: () => setState(() => isExpanded = !isExpanded),
                          child: MyText(
                            text: isExpanded ? "View Less" : "View More",
                            size: 16,
                            weight: FontWeight.w600,
                            color: kDynamicText(context),
                          ),
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /// Bottom CTA
            bottomNavigationBar: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  Expanded(
                    child: MyButtonWithIcon(
                      iconPath: Assets.cartfilled, // use promo related icon
                      text: "Redeem Offer",
                      onTap: () {
                        // handle redeem logic
                      },
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
}
