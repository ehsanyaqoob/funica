import 'package:funica/Screens/prodcuts/prodcut-details-screen.dart';
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
    // Initialize controller if not already done
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
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: GenericAppBar(
              title: "My Orders",
              showSearch: true,
              onSearchChanged: (query) {
                // Handle product search
                print("Searching products: $query");
              },
              searchHint: "Search products...",
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.cartfilled,
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
            const Gap(24),
            MyButton(
              buttonText: "Start Shopping",
              onTap: () {
              //  Get.to(ProductDetailsView(product: product));
              },
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      backgroundColor: kDynamicScaffoldBackground(Get.context!),
      color: kDynamicPrimary(Get.context!),
      onRefresh: () async => await orderController.fetchOrders(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orderController.orders.length,
        itemBuilder: (context, index) => _buildOrderCard(orderController.orders[index]),
      ),
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
          // Order Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Order #${order.orderNumber}",
                      size: 16,
                      weight: FontWeight.w600,
                      color: kDynamicText(Get.context!),
                    ),
                    const Gap(4),
                    MyText(
                      text: "${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}",
                      size: 12,
                      color: kDynamicListTileSubtitle(Get.context!),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: MyText(
                    text: _getStatusText(order.status),
                    size: 12,
                    weight: FontWeight.w600,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ],
            ),
          ),

          // Order Items Preview
          ...order.items.take(2).map((item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CommonImageView(
                  url: item.product.image,
                  height: 50,
                  width: 50,
                  radius: 8,
                  fit: BoxFit.fill,
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: item.product.title,
                        size: 14,
                        weight: FontWeight.w500,
                        color: kDynamicText(Get.context!),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      const Gap(2),
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
                  weight: FontWeight.w600,
                  color: kDynamicText(Get.context!),
                ),
              ],
            ),
          )),

          if (order.items.length > 2) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MyText(
                text: "+ ${order.items.length - 2} more items",
                size: 12,
                color: kDynamicListTileSubtitle(Get.context!),
              ),
            ),
            const Gap(8),
          ],

          const Divider(thickness: 1, height: 1),

          // Order Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Total Amount",
                      size: 12,
                      color: kDynamicListTileSubtitle(Get.context!),
                    ),
                    const Gap(2),
                    MyText(
                      text: "\$${order.totalAmount.toStringAsFixed(2)}",
                      size: 16,
                      weight: FontWeight.bold,
                      color: kDynamicPrimary(Get.context!),
                    ),
                  ],
                ),
                Spacer(),
                if (order.status == OrderStatus.delivered)
                  Expanded(
                    child: MyButtonWithIcon(
                     iconPath:Assets.cartfilled ,
                      text: " Reorder ",
                      onTap: () => _reorderItems(order),
                      backgroundColor: kDynamicScaffoldBackground(Get.context!),
                      fontColor: kDynamicText(Get.context!),
                      outlineColor: kDynamicBorder(Get.context!),
                      height: 40,
                    ),
                  ),
                const Gap(8),
                Expanded(
                  child: MyButtonWithIcon(
                    iconPath: Assets.cartfilled,
                    text: " View ",
                    onTap: () => _viewOrderDetails(order),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending: return Colors.orange;
      case OrderStatus.confirmed: return Colors.blue;
      case OrderStatus.processing: return Colors.purple;
      case OrderStatus.shipped: return Colors.indigo;
      case OrderStatus.delivered: return Colors.green;
      case OrderStatus.cancelled: return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending: return "Pending";
      case OrderStatus.confirmed: return "Confirmed";
      case OrderStatus.processing: return "Processing";
      case OrderStatus.shipped: return "Shipped";
      case OrderStatus.delivered: return "Delivered";
      case OrderStatus.cancelled: return "Cancelled";
    }
  }

  void _reorderItems(Order order) {
    final productController = Get.find<ProductController>();
    for (final item in order.items) {
      // If addToCart only accepts product, add each item multiple times
      for (int i = 0; i < item.quantity; i++) {
        productController.addToCart(item.product);
      }
    }
    AppToast.success("Items added to cart!");
  }

  void _viewOrderDetails(Order order) {
    // Get.to(() => OrderDetailScreen(order: order), transition: Transition.cupertino);
  }
}