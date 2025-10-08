import 'package:funica/constants/export.dart';
import 'package:funica/controller/order-cont.dart';
import 'package:funica/models/order-model.dart'
    show Order, OrderStatus, OrderStatusUpdate, CartItem;
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/dot-loader.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderNumber;
  const TrackOrderScreen({super.key, required this.orderNumber});
  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  Order? _order;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOrder();
    });
  }

  void _loadOrder() async {
    try {
      final orderController = Get.find<OrderController>();

      // Force refresh orders from cache/API
      await orderController.fetchOrders();

      // Get the updated order
      final updatedOrder = orderController.getOrderById(widget.orderNumber);

      if (mounted) {
        setState(() {
          _order = updatedOrder;
        });
      }
    } catch (e) {
      print('Error loading order: $e');
      // Handle error state if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_order == null) {
      return Scaffold(
        backgroundColor: kDynamicScaffoldBackground(context),
        appBar: CustomAppBar(
          title: "Track Order",
          showLeading: true,
          onBackTap: () => Get.back(),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FunicaLoader(),
              const Gap(16),
              MyText(
                text: "Loading order details...",
                size: 16,
                color: kDynamicListTileSubtitle(Get.context!),
              ),
            ],
          ),
        ),
      );
    }

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
            appBar: CustomAppBar(
              title: "Track Order",
              showLeading: true,
              onBackTap: () => Get.back(),
            ),
            body: RefreshIndicator(
              color: kDynamicIcon(context),
                backgroundColor: kDynamicScaffoldBackground(context),
                displacement: 40,
                strokeWidth: 2.5,
                edgeOffset: 0,
                notificationPredicate: (notification) {
                  // Only trigger refresh when at the top
                  return notification.metrics.pixels == 0;
                },
              onRefresh: () async {
                // Show custom loader during refresh
                Get.dialog(
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: kDynamicCard(context),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FunicaLoader(),
                          const Gap(16),
                          MyText(
                            text: "Checking for updates...",
                            size: 16,
                            weight: FontWeight.w600,
                            color: kDynamicText(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );

                try {
                  _loadOrder();
                  await Future.delayed(const Duration(seconds: 1)); // Smooth UX
                } finally {
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                  }
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderHeaderCard(_order!),
                    const Gap(20),

                    // Horizontal Status Stepper
                    _buildHorizontalStatusStepper(_order!),
                    const Gap(20),

                    _buildTrackingTimeline(_order!),
                    const Gap(20),
                    _buildOrderDetailsCard(_order!),
                    const Gap(20),
                    _buildShippingInfoCard(_order!),
                    const Gap(20),
                    _buildOrderItemsCard(_order!),
                    const Gap(32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderHeaderCard(Order order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
      ),
      child: Column(
        children: [
          // Header Row - Made overflow safe
          Row(
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
                      size: 18,
                      weight: FontWeight.w700,
                      color: kDynamicText(Get.context!),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    const Gap(4),
                    MyText(
                      text: "Placed on ${_formatDate(order.orderDate)}",
                      size: 14,
                      color: kDynamicListTileSubtitle(Get.context!),
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Gap(12),
              // Status Badge - Fixed width to prevent overflow
              Container(
                constraints: const BoxConstraints(minWidth: 80, maxWidth: 120),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyText(
                  text: _getStatusText(order.status),
                  size: 12, // Slightly smaller for safety
                  weight: FontWeight.w600,
                  color: _getStatusColor(order.status),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const Gap(16),
          Divider(color: kDynamicBorder(Get.context!), height: 1),
          const Gap(16),

          // Info Row - Made responsive
          LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 350;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: _buildInfoItem(
                      "Estimated Delivery",
                      _formatDate(order.estimatedDelivery),
                      compact: isSmallScreen,
                    ),
                  ),
                  const Gap(16),
                  Flexible(
                    child: _buildInfoItem(
                      "Total Amount",
                      "\$${order.totalAmount.toStringAsFixed(2)}",
                      compact: isSmallScreen,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Updated helper method with compact mode
  Widget _buildInfoItem(String label, String value, {bool compact = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          text: compact && label.length > 15 ? "Est. Delivery" : label,
          size: compact ? 11 : 12,
          color: kDynamicListTileSubtitle(Get.context!),
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
        const Gap(4),
        MyText(
          text: value,
          size: compact ? 13 : 14,
          weight: FontWeight.w600,
          color: kDynamicText(Get.context!),
          maxLines: 1,
          textOverflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildTrackingTimeline(Order order) {
    final currentStatusIndex = _getCurrentStatusIndex(order);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: "Order Status",
            size: 18,
            weight: FontWeight.w700,
            color: kDynamicText(Get.context!),
          ),
          const Gap(16),
          ..._buildTimelineSteps(order, currentStatusIndex),
        ],
      ),
    );
  }

  List<Widget> _buildTimelineSteps(Order order, int currentIndex) {
    final steps = [
      _TimelineStep(
        OrderStatus.pending,
        "Order Placed",
        "Your order has been confirmed",
      ),
      _TimelineStep(
        OrderStatus.confirmed,
        "Order Confirmed",
        "Payment received and order confirmed",
      ),
      _TimelineStep(
        OrderStatus.processing,
        "Processing",
        "Seller is preparing your order",
      ),
      _TimelineStep(OrderStatus.shipped, "Shipped", "Your order is on the way"),
      _TimelineStep(
        OrderStatus.delivered,
        "Delivered",
        "Order delivered successfully",
      ),
    ];

    return steps.asMap().entries.map((entry) {
      final index = entry.key;
      final step = entry.value;
      final isCompleted = index <= currentIndex;
      final isCurrent = index == currentIndex;

      return _buildTimelineItem(
        status: step.status,
        title: step.title,
        description: step.description,
        isCompleted: isCompleted,
        isCurrent: isCurrent,
        order: order,
      );
    }).toList();
  }
Widget _buildTimelineItem({
  required OrderStatus status,
  required String title,
  required String description,
  required bool isCompleted,
  required bool isCurrent,
  required Order order,
}) {
  final statusUpdate = order.statusHistory.firstWhere(
    (update) => update.status == status,
    orElse: () => OrderStatusUpdate(
      status: status,
      timestamp: order.orderDate,
      note: description,
    ),
  );

  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline dot and line
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted
                    ? kDynamicPrimary(Get.context!)
                    : kDynamicListTileSubtitle(Get.context!),
                shape: BoxShape.circle,
              ),
              child: isCompleted
                  ? Center(
                      child: SvgPicture.asset(
                        Assets.check,
                        width: 14, // Slightly larger for better visibility
                        height: 14,
                        color:kWhite,
                      ),
                    )
                  : null,
            ),
            if (status != OrderStatus.delivered)
              Container(
                width: 2,
                height: 40,
                margin: const EdgeInsets.only(top: 4),
                color: isCompleted
                    ? kDynamicPrimary(Get.context!)
                    : kDynamicListTileSubtitle(Get.context!)!.withOpacity(0.3),
              ),
          ],
        ),
        const Gap(16),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: title,
                size: 16,
                weight: FontWeight.w600,
                color: isCurrent
                    ? kDynamicPrimary(Get.context!)
                    : kDynamicText(Get.context!),
              ),
              const Gap(4),
              MyText(
                text: description,
                size: 14,
                color: kDynamicListTileSubtitle(Get.context!),
              ),
              const Gap(4),
              MyText(
                text: _formatDateTime(statusUpdate.timestamp),
                size: 12,
                color: kDynamicListTileSubtitle(Get.context!),
              ),
              if (statusUpdate.note != null &&
                  statusUpdate.note!.isNotEmpty) ...[
                const Gap(4),
                MyText(
                  text: statusUpdate.note!,
                  size: 12,
                  color: kDynamicSubtitleText(Get.context!), // Use primary color for notes
                  fontStyle: FontStyle.italic,
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
  Widget _buildOrderDetailsCard(Order order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: "Order Details",
            size: 18,
            weight: FontWeight.w700,
            color: kDynamicText(Get.context!),
          ),
          const Gap(16),
          _buildDetailRow("Order Number", order.orderNumber),
          const Gap(12),
          _buildDetailRow("Order Date", _formatDateTime(order.orderDate)),
          const Gap(12),
          _buildDetailRow("Payment Method", order.paymentMethod),
          const Gap(12),
          _buildDetailRow(
            "Total Amount",
            "\$${order.totalAmount.toStringAsFixed(2)}",
          ),
        ],
      ),
    );
  }

  Widget _buildShippingInfoCard(Order order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: "Shipping Information",
            size: 18,
            weight: FontWeight.w700,
            color: kDynamicText(Get.context!),
          ),
          const Gap(16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: kDynamicPrimary(Get.context!),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Delivery Address",
                      size: 14,
                      weight: FontWeight.w600,
                      color: kDynamicText(Get.context!),
                    ),
                    const Gap(4),
                    MyText(
                      text: order.shippingAddress,
                      size: 14,
                      color: kDynamicListTileSubtitle(Get.context!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(12),
          Divider(color: kDynamicBorder(Get.context!), height: 1),
          const Gap(12),
          Row(
            children: [
              Icon(
                Icons.delivery_dining,
                size: 20,
                color: kDynamicPrimary(Get.context!),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Estimated Delivery",
                      size: 14,
                      weight: FontWeight.w600,
                      color: kDynamicText(Get.context!),
                    ),
                    const Gap(4),
                    MyText(
                      text: _formatDate(order.estimatedDelivery),
                      size: 14,
                      color: kDynamicListTileSubtitle(Get.context!),
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

  Widget _buildHorizontalStatusStepper(Order order) {
    final currentStatusIndex = _getCurrentStatusIndex(order);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
      ),
      child: Column(
        children: [
          MyText(
            text: "Order Progress",
            size: 18,
            weight: FontWeight.w700,
            color: kDynamicText(Get.context!),
          ),
          const Gap(16),
          _buildStatusStepper(order, currentStatusIndex),
        ],
      ),
    );
  }
Widget _buildStatusStepper(Order order, int currentIndex) {
  final steps = [
    _StatusStep(OrderStatus.pending, "Placed", Assets.cartfilled),
    _StatusStep(OrderStatus.confirmed, "Confirmed", Assets.check),
    _StatusStep(OrderStatus.processing, "Processing", Assets.processing),
    _StatusStep(OrderStatus.shipped, "Shipped", Assets.truck),
    _StatusStep(OrderStatus.delivered, "Delivered", Assets.check),
  ];

  return Column(
    children: [
      // Icons Row
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isCompleted = index <= currentIndex;
          final isCurrent = index == currentIndex;

          return _buildStatusIcon(
            iconPath: step.icon,
            label: step.label,
            isCompleted: isCompleted,
            isCurrent: isCurrent,
          );
        }).toList(),
      ),

      const Gap(8),

      // Connecting Lines
      Row(
        children: List.generate(steps.length - 1, (index) {
          final isCompleted = index < currentIndex;
          return Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isCompleted
                    ? kDynamicText(Get.context!)
                    : kDynamicListTileSubtitle(Get.context!)!.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    ],
  );
}

Widget _buildStatusIcon({
  required String iconPath,
  required String label,
  required bool isCompleted,
  required bool isCurrent,
}) {
  return Column(
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isCompleted
              ? kDynamicPrimary(Get.context!)
              : (isCurrent
                    ? kDynamicPrimary(Get.context!)!.withOpacity(0.1)
                    : kDynamicListTileSubtitle(Get.context!)!.withOpacity(0.1)),
          shape: BoxShape.circle,
          border: isCurrent
              ? Border.all(color: kDynamicPrimary(Get.context!)!, width: 2)
              : null,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            height: 24,
            width: 24,
            color: isCompleted
                ? Colors.white
                : (isCurrent
                      ? kDynamicText(Get.context!)
                      : kDynamicListTileSubtitle(Get.context!)),
          ),
        ),
      ),
      const Gap(6),
      MyText(
        text: label,
        size: 12,
        weight: FontWeight.w600,
        color: isCompleted || isCurrent
            ? kDynamicText(Get.context!)
            : kDynamicListTileSubtitle(Get.context!),
        textAlign: TextAlign.center,
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

  Widget _buildOrderItemsCard(Order order) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: "Order Items (${order.items.length})",
            size: 18,
            weight: FontWeight.w700,
            color: kDynamicText(Get.context!),
          ),
          const Gap(16),
          ...order.items.map((item) => _buildOrderItem(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CommonImageView(
            url: item.product.image,
            height: 60,
            width: 60,
            radius: 12,
            fit: BoxFit.cover,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: item.product.title,
                  size: 14,
                  weight: FontWeight.w600,
                  color: kDynamicText(Get.context!),
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                MyText(
                  text: "Quantity: ${item.quantity}",
                  size: 12,
                  color: kDynamicListTileSubtitle(Get.context!),
                ),
              ],
            ),
          ),
          MyText(
            text: "\$${item.totalPrice.toStringAsFixed(2)}",
            size: 14,
            weight: FontWeight.w700,
            color: kDynamicText(Get.context!),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          text: label,
          size: 14,
          color: kDynamicListTileSubtitle(Get.context!),
        ),
        MyText(
          text: value,
          size: 14,
          weight: FontWeight.w600,
          color: kDynamicText(Get.context!),
        ),
      ],
    );
  }

  // Helper Methods
  int _getCurrentStatusIndex(Order order) {
    final statusOrder = [
      OrderStatus.pending,
      OrderStatus.confirmed,
      OrderStatus.processing,
      OrderStatus.shipped,
      OrderStatus.delivered,
    ];
    return statusOrder.indexOf(order.status);
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatDateTime(DateTime date) {
    return "${_formatDate(date)} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

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
}

class _TimelineStep {
  final OrderStatus status;
  final String title;
  final String description;

  _TimelineStep(this.status, this.title, this.description);
}

class _StatusStep {
  final OrderStatus status;
  final String label;
  final String icon; // Changed from IconData to String

  _StatusStep(this.status, this.label, this.icon);
}