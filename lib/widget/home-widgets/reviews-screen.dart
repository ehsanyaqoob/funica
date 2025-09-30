import 'package:flutter/material.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/generated/assets.dart';

final List<Map<String, dynamic>> allReviews = [
  {
    'id': 1,
    'userName': 'Sarah Johnson',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Absolutely love this product! The quality exceeded my expectations and it looks even better in person than in the photos. Very comfortable and durable.',
    'likes': 24,
    'isLiked': false,
    'date': '2 days ago',
  },
  {
    'id': 2,
    'userName': 'Mike Chen',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Good value for the price. The delivery was fast and packaging was secure. Minor issue with assembly instructions but overall satisfied with the purchase.',
    'likes': 12,
    'isLiked': true,
    'date': '1 week ago',
  },
  {
    'id': 3,
    'userName': 'Emily Rodriguez',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'This has completely transformed my living space! The craftsmanship is excellent and it\'s very sturdy. Would definitely recommend to friends and family.',
    'likes': 31,
    'isLiked': false,
    'date': '3 days ago',
  },
  {
    'id': 4,
    'userName': 'David Thompson',
    'userImage': Assets.personfilled,
    'rating': 3.0,
    'comment':
        'Decent product but had some quality issues. The color is slightly different from what was shown online. Customer service was helpful in resolving my concerns.',
    'likes': 8,
    'isLiked': false,
    'date': '2 weeks ago',
  },
  {
    'id': 5,
    'userName': 'Lisa Wang',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Very happy with this purchase! The design is modern and functional. Assembly was straightforward and it fits perfectly in my space. Great quality!',
    'likes': 19,
    'isLiked': true,
    'date': '5 days ago',
  },
  {
    'id': 6,
    'userName': 'Robert Martinez',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Outstanding quality and beautiful design. This product has received so many compliments from guests. Worth every penny and would buy again!',
    'likes': 42,
    'isLiked': false,
    'date': '1 day ago',
  },
];

final List<Map<String, dynamic>> sofaReviews = [
  {
    'id': 1,
    'userName': 'Jennifer Lee',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'This sofa is incredibly comfortable! Perfect for movie nights and the fabric is easy to clean. The color matches our decor perfectly.',
    'likes': 28,
    'isLiked': false,
    'date': '3 days ago',
  },
  {
    'id': 2,
    'userName': 'Kevin Brown',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Great sofa overall. Very comfortable and good build quality. Took some time to assemble but worth the effort. Delivery was prompt.',
    'likes': 15,
    'isLiked': true,
    'date': '1 week ago',
  },
  {
    'id': 3,
    'userName': 'Amanda Wilson',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Absolutely stunning sofa! The quality is exceptional and it\'s very comfortable. Perfect size for our living room. Highly recommended!',
    'likes': 33,
    'isLiked': false,
    'date': '4 days ago',
  },
  {
    'id': 4,
    'userName': 'James Taylor',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Very pleased with this purchase. The sofa is comfortable and looks great. Minor issue with one cushion but customer service was excellent.',
    'likes': 21,
    'isLiked': false,
    'date': '2 weeks ago',
  },
];

final List<Map<String, dynamic>> chairReviews = [
  {
    'id': 1,
    'userName': 'Maria Garcia',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Perfect office chair! Very comfortable for long working hours. The lumbar support is excellent and the adjustable height works great.',
    'likes': 19,
    'isLiked': true,
    'date': '2 days ago',
  },
  {
    'id': 2,
    'userName': 'Thomas Clark',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Good quality chair at a reasonable price. Assembly was easy and it feels sturdy. The fabric is nice and seems durable.',
    'likes': 11,
    'isLiked': false,
    'date': '6 days ago',
  },
  {
    'id': 3,
    'userName': 'Sophia Anderson',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Beautiful chair that complements our dining set perfectly. Very comfortable and the craftsmanship is impressive. Fast delivery too!',
    'likes': 25,
    'isLiked': false,
    'date': '1 week ago',
  },
  {
    'id': 4,
    'userName': 'Daniel White',
    'userImage': Assets.personfilled,
    'rating': 3.5,
    'comment':
        'Decent chair but could be more comfortable. The padding is a bit thin for long sitting sessions. Good for occasional use though.',
    'likes': 7,
    'isLiked': false,
    'date': '3 weeks ago',
  },
  {
    'id': 5,
    'userName': 'Olivia Martin',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Love this chair! The design is modern and it\'s very comfortable. Perfect for my home office. Would definitely recommend to others.',
    'likes': 16,
    'isLiked': true,
    'date': '5 days ago',
  },
];

final List<Map<String, dynamic>> tableReviews = [
  {
    'id': 1,
    'userName': 'William Harris',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'Excellent dining table! Perfect size for our family. The wood finish is beautiful and it feels very sturdy. Easy to clean and maintain.',
    'likes': 22,
    'isLiked': false,
    'date': '4 days ago',
  },
  {
    'id': 2,
    'userName': 'Emma Thompson',
    'userImage': Assets.personfilled,
    'rating': 4.0,
    'comment':
        'Good quality table at a reasonable price. The assembly took some time but the instructions were clear. Very satisfied with the purchase.',
    'likes': 14,
    'isLiked': true,
    'date': '1 week ago',
  },
  {
    'id': 3,
    'userName': 'Michael Scott',
    'userImage': Assets.personfilled,
    'rating': 5.0,
    'comment':
        'This table is exactly what we needed! The design is modern and it fits perfectly in our space. Quality is outstanding for the price.',
    'likes': 29,
    'isLiked': false,
    'date': '2 days ago',
  },
  {
    'id': 4,
    'userName': 'Jessica Parker',
    'userImage': Assets.personfilled,
    'rating': 4.5,
    'comment':
        'Beautiful coffee table that completes our living room. The glass top is easy to clean and the metal frame is very sturdy. Love it!',
    'likes': 18,
    'isLiked': false,
    'date': '1 week ago',
  },
];

class ReviewsTabBar extends StatefulWidget {
  final List<String> ratingFilters;
  final Function(String)? onRatingSelected;
  final int totalReviews;

  const ReviewsTabBar({
    super.key,
    this.ratingFilters = const ['All', '5', '4', '3', '2', '1'],
    this.onRatingSelected,
    required this.totalReviews,
  });

  @override
  State<ReviewsTabBar> createState() => _ReviewsTabBarState();
}

class _ReviewsTabBarState extends State<ReviewsTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.ratingFilters.length,
      vsync: this,
    );
    _selectedFilter = widget.ratingFilters.first;
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _selectedFilter = widget.ratingFilters[_tabController.index];
      });
      widget.onRatingSelected?.call(_selectedFilter);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (_) {
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.ratingFilters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      final index = widget.ratingFilters.indexOf(filter);
                      _tabController.animateTo(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isSelected ? kPrimaryColor : kTransperentColor,
                        border: Border.all(
                          color: isSelected
                              ? kPrimaryColor
                              : kDynamicColor(
                                  context,
                                  kGreyColor4,
                                  kGreyColor4,
                                ),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (filter != 'All')
                            SvgPicture.asset(
                              Assets.starfilled,
                              height: 14,
                              color: isSelected ? Colors.white : kYellowColor,
                            ),
                          if (filter != 'All') const Gap(4),
                          MyText(
                            text: filter == 'All'
                                ? 'All (${widget.totalReviews})'
                                : filter,
                            size: 12,
                            weight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: isSelected
                                ? Colors.white
                                : kDynamicText(context),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Gap(16),
          ],
        );
      },
    );
  }
}

class ReviewsScreen extends StatefulWidget {
  final ProductModel product;

  const ReviewsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String _selectedRatingFilter = 'All';
  List<Map<String, dynamic>> _filteredReviews = [];

  @override
  void initState() {
    super.initState();
    _filteredReviews = _getReviewsForProduct(widget.product);
  }

  List<Map<String, dynamic>> _getReviewsForProduct(ProductModel product) {
    if (product.title.toLowerCase().contains('sofa')) {
      return List.from(sofaReviews);
    } else if (product.title.toLowerCase().contains('chair')) {
      return List.from(chairReviews);
    } else if (product.title.toLowerCase().contains('table')) {
      return List.from(tableReviews);
    } else {
      return List.from(allReviews);
    }
  }

  void _handleRatingFilter(String filter) {
    setState(() {
      _selectedRatingFilter = filter;
      final allReviews = _getReviewsForProduct(widget.product);
      if (filter == 'All') {
        _filteredReviews = allReviews;
      } else {
        final rating = double.parse(filter);
        _filteredReviews = allReviews
            .where((review) => review['rating'] == rating)
            .toList();
      }
    });
  }

  void _handleLikeReview(int reviewId) {
    setState(() {
      final review = _filteredReviews.firstWhere((r) => r['id'] == reviewId);
      final isCurrentlyLiked = review['isLiked'] as bool;
      review['isLiked'] = !isCurrentlyLiked;
      review['likes'] = isCurrentlyLiked
          ? (review['likes'] as int) - 1
          : (review['likes'] as int) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '${widget.product.reviews} Reviews',
        showLeading: true,
      ),
      body: SingleChildScrollView(
        padding: AppSizes.DEFAULT,
        child: Column(
          children: [
            ReviewsTabBar(
              totalReviews: _getReviewsForProduct(widget.product).length,
              onRatingSelected: _handleRatingFilter,
            ),
            _buildReviewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredReviews.length,
      itemBuilder: (context, index) {
        final review = _filteredReviews[index];
        return _buildReviewItem(review);
      },
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(26.0),
      decoration: BoxDecoration(
        color: kDynamicCard(context),
        borderRadius: BorderRadius.circular(26.0),
        border: Border.all(color: kDynamicBorder(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
              backgroundColor:  kDynamicBorder(context),
                child: review['userImage'].toString().endsWith('.svg')
                    ? ClipOval(
                        child: SvgPicture.asset(
                          review['userImage'],
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                          review['userImage'],
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: review['userName'],
                      size: 18,
                      weight: FontWeight.bold,
                      color: kDynamicText(context),
                    ),
                    Gap(4),
                    MyText(
                      text: review['date'],
                      size: 12,
                      weight: FontWeight.w400,
                      color: kDynamicListTileSubtitle(context),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.starfilled,
                    height: 14,
                    color: kYellowColor,
                  ),
                  Gap(4),
                  MyText(
                    text: review['rating'].toString(),
                    size: 14,
                    color: kDynamicText(context),
                  ),
                ],
              ),
            ],
          ),
          Gap(6),
          MyText(
            text: review['comment'],
            size: 14,
            color: kDynamicText(context),
            maxLines: 3,
            textOverflow: TextOverflow.ellipsis,
          ),
          Gap(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _handleLikeReview(review['id']),
                child: Row(
                  children: [
                    Icon(
                      review['isLiked']
                          ? Icons.thumb_up
                          : Icons.thumb_up_alt_outlined,
                      size: 16,
                      color: review['isLiked']
                          ? kPrimaryColor
                          : kDynamicListTileSubtitle(context),
                    ),
                    Gap(6),
                    MyText(
                      text: '${review['likes']}',
                      size: 12,
                      weight: FontWeight.bold,
                      color: kDynamicListTileSubtitle(context),
                    ),
                    Gap(30),
                    MyText(
                      text: review['date'],
                      size: 12,
                      color: kDynamicListTileSubtitle(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
