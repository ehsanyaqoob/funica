import 'package:funica/Screens/navbar/homebarscreens/orders-screen/track-order-screen.dart';
import 'package:funica/Screens/settings.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/order-cont.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/models/order-model.dart' show Order, OrderStatus;
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/dot-loader.dart';
import 'package:funica/widget/toasts.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(OrderController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: GenericAppBar(
              title: "My Orders",
              showSearch: true,
              onSearchChanged: (query) {
                print("Searching orders: $query");
              },
              searchHint: "Search orders...",
              onSettingsTap: (){
                 Get.to(SettingsScreen(), transition: Transition.fadeIn, duration: Duration(milliseconds: 500));
              },
            ),
            body: GetBuilder<OrderController>(
              builder: (orderController) => _buildBody(orderController),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(OrderController orderController) {
    if (orderController.isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FunicaLoader(),
            const Gap(16),
            MyText(
              text: "Loading your orders...",
              size: 16,
              color: kDynamicListTileSubtitle(Get.context!),
            ),
          ],
        ),
      );
    }

    if (orderController.orders.isEmpty) {
      return _buildEmptyState();
    }

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          // Minimal Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 4.0,
                  color: kDynamicIcon(Get.context!),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: kDynamicIcon(Get.context!),
              unselectedLabelColor: kDynamicListTileSubtitle(Get.context!),
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Completed'),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              children: [
                // Active Tab with Refresh
                _buildRefreshableOrderList(
                  orderController.activeOrders, 
                  "No Active Orders", 
                  "You don't have any ongoing orders"
                ),

                // Completed Tab with Refresh
                _buildRefreshableOrderList(
                  orderController.completedOrders, 
                  "No Completed Orders", 
                  "Your completed orders will appear here"
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshableOrderList(List<Order> orders, String emptyTitle, String emptySubtitle) {
    return RefreshIndicator(
      backgroundColor: kDynamicScaffoldBackground(Get.context!),
      color: kDynamicPrimary(Get.context!),
      onRefresh: () async {
        // Show your custom loader in a dialog
        Get.dialog(
          Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: kDynamicCard(Get.context!),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FunicaLoader(),
                  const Gap(16),
                  MyText(
                    text: "Refreshing orders...",
                    size: 16,
                    weight: FontWeight.w600,
                    color: kDynamicText(Get.context!),
                  ),
                ],
              ),
            ),
          ),
          barrierDismissible: false,
        );

        try {
          final orderController = Get.find<OrderController>();
          await orderController.fetchOrders();
        } finally {
          // Close the loader dialog
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
        }
      },
      child: _buildOrderList(orders, emptyTitle, emptySubtitle),
    );
  }

  Widget _buildOrderList(List<Order> orders, String emptyTitle, String emptySubtitle) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.orderfilled,
              height: 80,
              color: kDynamicListTileSubtitle(Get.context!),
            ),
            const Gap(20),
            MyText(
              text: emptyTitle,
              size: 18,
              weight: FontWeight.w600,
              color: kDynamicText(Get.context!),
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MyText(
                text: emptySubtitle,
                size: 14,
                color: kDynamicListTileSubtitle(Get.context!),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderCard(orders[index]),
    );
  }
Widget _buildOrderCard(Order order) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: kDynamicCard(Get.context!),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
    ),
    child: Column(
      children: [
        // Order Header - Made overflow safe
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Info - Flexible to prevent overflow
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Order #${order.orderNumber}",
                      size: 16,
                      weight: FontWeight.w600,
                      color: kDynamicText(Get.context!),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    const Gap(4),
                    MyText(
                      text: "${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}",
                      size: 12,
                      color: kDynamicListTileSubtitle(Get.context!),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Gap(8),
              // Status Badge - Fixed constraints
              Container(
                constraints: const BoxConstraints(
                  minWidth: 80,
                  maxWidth: 100,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyText(
                  text: _getStatusText(order.status),
                  size: 11,
                  weight: FontWeight.w600,
                  color: _getStatusColor(order.status),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        // Order Items Preview - Made overflow safe
        ...order.items
            .take(2)
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    // Product Image - Fixed size
                    CommonImageView(
                      url: item.product.image,
                      height: 50,
                      width: 50,
                      radius: 8,
                      fit: BoxFit.cover,
                    ),
                    const Gap(12),
                    // Product Info - Flexible
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: item.product.title,
                            size: 14,
                            weight: FontWeight.w500,
                            color: kDynamicText(Get.context!),
                            maxLines: 2,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                          const Gap(2),
                          MyText(
                            text: "Quantity: ${item.quantity}",
                            size: 12,
                            color: kDynamicListTileSubtitle(Get.context!),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const Gap(8),
                    // Price - Fixed width
                    Container(
                      constraints: const BoxConstraints(minWidth: 60),
                      child: MyText(
                        text: "\$${item.totalPrice.toStringAsFixed(2)}",
                        size: 14,
                        weight: FontWeight.w600,
                        color: kDynamicIcon(Get.context!),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),

        // More items indicator
        if (order.items.length > 2) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MyText(
              text: "+ ${order.items.length - 2} more items",
              size: 12,
              color: kDynamicListTileSubtitle(Get.context!),
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(8),
        ],

        const Divider(thickness: 1, height: 1),

        // Order Footer with Dynamic Buttons - Made overflow safe
        Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 300;
              
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total Amount
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "Total Amount",
                          size: isCompact ? 11 : 12,
                          color: kDynamicListTileSubtitle(Get.context!),
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        const Gap(2),
                        MyText(
                          text: "\$${order.totalAmount.toStringAsFixed(2)}",
                          size: isCompact ? 14 : 16,
                          weight: FontWeight.bold,
                          color: kDynamicIcon(Get.context!),
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                 
                  
                  // Reorder Button (only for delivered orders)
                  if (order.status == OrderStatus.delivered) ...[
                    if (!isCompact)
                      Expanded(
                        child: MyButtonWithIcon(
                          iconPath: Assets.cartfilled,
                          text: " Reorder ",
                          onTap: () => _reorderItems(order),
                          backgroundColor: kDynamicScaffoldBackground(Get.context!),
                          fontColor: kDynamicText(Get.context!),
                          outlineColor: kDynamicBorder(Get.context!),
                          height: 40,
                        ),
                      )
                    else
                      IconButton(
                        onPressed: () => _reorderItems(order),
                        icon: SvgPicture.asset(
                          Assets.cartfilled,
                          height: 20,
                          color: kDynamicText(Get.context!),
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: kDynamicScaffoldBackground(Get.context!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: kDynamicBorder(Get.context!)),
                          ),
                        ),
                      ),
                    
                    if (order.status == OrderStatus.delivered) const Gap(8),
                  ],
                  
                  // Primary Action Button
                  if (!isCompact)
                    Expanded(
                      child: MyButtonWithIcon(
                        iconPath: _getActionIcon(order.status),
                        text: _getActionText(order.status),
                        onTap: () => _handleOrderAction(order),
                      ),
                    )
                  else
                    IconButton(
                      onPressed: () => _handleOrderAction(order),
                      icon: SvgPicture.asset(
                        _getActionIcon(order.status),
                        height: 20,
                        color: Colors.white,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: kDynamicPrimary(Get.context!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}
  // Helper Methods
  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.confirmed:
        return "Confirmed";
      case OrderStatus.processing:
        return "Processing";
      case OrderStatus.shipped:
        return "Shipped";
      case OrderStatus.delivered:
        return "Delivered";
      case OrderStatus.cancelled:
        return "Cancelled";
    }
  }

  String _getActionIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return Assets.eye;
      default:
        return Assets.tracking;
    }
  }

  String _getActionText(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
      case OrderStatus.cancelled:
        return " View Details ";
      default:
        return " Track Order ";
    }
  }

  void _handleOrderAction(Order order) {
    if (order.status == OrderStatus.delivered || order.status == OrderStatus.cancelled) {
      _viewOrderDetails(order);
    } else {
      _trackOrder(order);
    }
  }

void _trackOrder(Order order) {
  // Navigate to TrackOrderView
  Get.to(() => TrackOrderScreen(orderNumber: order.orderNumber), 
      transition: Transition.cupertino);
}
  void _viewOrderDetails(Order order) {
    AppToast.info("View Details: ${order.orderNumber}");
  }

  void _reorderItems(Order order) {
    final productController = Get.find<ProductController>();
    for (final item in order.items) {
      for (int i = 0; i < item.quantity; i++) {
        productController.addToCart(item.product);
      }
    }
    AppToast.success("Items added to cart!");
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.orderfilled,
            height: 100,
            color: kDynamicListTileSubtitle(Get.context!),
          ),
          const Gap(20),
          MyText(
            text: "No Orders Yet",
            size: 20,
            weight: FontWeight.w600,
            color: kDynamicText(Get.context!),
          ),
          const Gap(8),
          MyText(
            text: "Your orders will appear here once you make a purchase",
            size: 14,
            color: kDynamicListTileSubtitle(Get.context!),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}