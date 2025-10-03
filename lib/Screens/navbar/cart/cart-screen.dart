import 'package:flutter/material.dart';
import 'package:funica/Screens/navbar/cart/checkout-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/models/order-model.dart';
import 'package:funica/widget/bottomsheets/helper-sheets.dart';
import 'package:funica/widget/custom_appbar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ProductController _productController = Get.find<ProductController>();

  void _navigateToCheckout() {
    Get.to(
      () => CheckoutScreen(
        cartItems: _productController.cartItems.toList(),
        totalAmount: _productController.totalCartValue,
      ),
      transition: Transition.cupertino,
      duration: const Duration(milliseconds: 300),
    );
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
              title: "My Cart",
              showSearch: true,
              onSearchChanged: (query) {
                // Handle product search
                print("Searching products: $query");
              },
              searchHint: "Search products...",
            ),
            body: Obx(() {
              if (_productController.cartItems.isEmpty) {
                return _buildEmptyCart();
              }
              return _buildCartWithItems();
            }),
            bottomNavigationBar: _buildBottomBar(),
          ),
        );
      },
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.cartfilled,
                  height: 200,
                  width: 200,
                  color: kDynamicIcon(context),
                ),
              ],
            ),
          ),
          const Gap(20),
          MyText(
            text: "Your cart is empty",
            size: 18,
            weight: FontWeight.w600,
            color: kDynamicText(context),
          ),
          const Gap(8),
          MyText(
            text: "Add some products to your cart",
            size: 14,
            color: kDynamicListTileSubtitle(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCartWithItems() {
    return Column(
      children: [
        Container(
          padding: AppSizes.DEFAULT,
          width: double.infinity,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: kDynamicBackground(context),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: kDynamicBorder(context), width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Total Items
              MyText(
                text: "Total Items",
                size: 14,
                color: kDynamicListTileSubtitle(context),
              ),

              // Right side: Items count + delete button
              Row(
                children: [
                  MyText(
                    text: "${_productController.totalItemsCount} items",
                    size: 14,
                    weight: FontWeight.bold,
                    color: kDynamicListTileSubtitle(context),
                  ),
                  const SizedBox(width: 10), // spacing
                  Bounce(
                    onTap: () {
                      BottomSheetHelper.showClearCartSheet(
                        productController: _productController,
                      );
                    },
                    child: SvgPicture.asset(
                      Assets.delete,
                      height: 20,
                      width: 20,
                      color: kDynamicIcon(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Cart items list
        Expanded(
          child: ListView.builder(
            padding: AppSizes.DEFAULT,
            itemCount: _productController.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = _productController.cartItems[index];
              return _buildCartItem(cartItem);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(CartItem cartItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kDynamicCard(context),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: kDynamicBorder(context), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          CommonImageView(
            url: cartItem.product.image,
            height: 70.0,
            width: 70.0,
            radius: 12.0,
            fit: BoxFit.fill,
          ),
          const Gap(12.0),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: MyText(
                              text: cartItem.product.title,
                              size: 18.0,
                              weight: FontWeight.bold,
                              color: kDynamicText(context),
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Delete button
                          IconButton(
                            onPressed: () {
                              BottomSheetHelper.showRemoveCartItemSheet(
                                cartItem: cartItem,
                                productController: _productController,
                              );
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ],
                      ),

                      const Gap(4.0),
                      // Color selection if available
                      if (cartItem.selectedColorIndex != null)
                        Row(
                          children: [
                            Container(
                              width: 26.0,
                              height: 26.0,
                              decoration: BoxDecoration(
                                color: _getColorFromIndex(
                                  cartItem.selectedColorIndex!,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: kDynamicBorder(context),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            const Gap(10),
                            MyText(
                              text: "Color",
                              size: 16,
                              color: kDynamicListTileSubtitle(context),
                            ),
                            const Gap(20),
                            // Quantity controls
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
                                  // Decrease button
                                  IconButton(
                                    onPressed: cartItem.quantity > 1
                                        ? () {
                                            _productController.updateQuantity(
                                              cartItem,
                                              cartItem.quantity - 1,
                                            );
                                          }
                                        : null,
                                    icon: SvgPicture.asset(
                                      Assets.minus,
                                      color: cartItem.quantity > 1
                                          ? kDynamicIcon(context)
                                          : kDynamicListTileSubtitle(context),
                                      height: 26,
                                    ),
                                  ),

                                  // Quantity
                                  Container(
                                    width: 20,
                                    alignment: Alignment.center,
                                    child: MyText(
                                      text: "${cartItem.quantity}",
                                      size: 16.0,
                                      weight: FontWeight.bold,
                                      color: kDynamicText(context),
                                    ),
                                  ),

                                  // Increase button
                                  IconButton(
                                    onPressed: () {
                                      _productController.updateQuantity(
                                        cartItem,
                                        cartItem.quantity + 1,
                                      );
                                    },
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

                      const Gap(8.0),

                      // Prices
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            text:
                                "\$${(double.tryParse(cartItem.product.price.replaceAll('\$', '')) ?? 0).toStringAsFixed(2)}",
                            size: 18.0,
                            weight: FontWeight.bold,
                            color: kDynamicText(context),
                          ),
                          MyText(
                            text:
                                "Total: \$${cartItem.totalPrice.toStringAsFixed(2)}",
                            size: 16.0,
                            weight: FontWeight.bold,
                            color: kDynamicText(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorFromIndex(int index) {
    final List<Color> _colors = [
      Colors.brown,
      Colors.grey,
      Colors.purple,
      Colors.teal,
      Colors.green,
      Colors.blue,
    ];
    if (index >= 0 && index < _colors.length) {
      return _colors[index];
    }
    return Colors.grey;
  }

  Widget _buildBottomBar() {
    return Obx(() {
      if (_productController.cartItems.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kDynamicCard(context),
          border: Border.all(color: kDynamicBorder(context)),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26.0),
            topRight: Radius.circular(26.0),
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyText(
                      text: "Total Price",
                      size: 14,
                      color: kDynamicListTileSubtitle(context),
                    ),
                    const Gap(2),
                    Obx(
                      () => MyText(
                        text:
                            "\$${_productController.totalCartValue.toStringAsFixed(2)}",
                        size: 20.0,
                        weight: FontWeight.bold,
                        color: kDynamicText(context),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(18.0),
              Expanded(
                child: MyButtonWithIcon(
                  iconPath: Assets.checkout,
                  text: "Checkout",
                  onTap: _navigateToCheckout,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
