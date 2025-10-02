import 'package:funica/Screens/navbar/cart/shippin-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/models/product-model.dart';
import 'package:funica/widget/toasts.dart';

class BottomSheetHelper {
// Generic confirmation bottom sheet for removing items with item preview
static void showRemoveItemSheet({
  required String title,
  required String message,
  required CartItem cartItem, // Add cartItem parameter
  required VoidCallback onConfirm,
  String confirmText = "Remove",
  String cancelText = "Cancel",
}) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 66,
              height: 4,
              decoration: BoxDecoration(
                color: kDynamicListTileSubtitle(Get.context!),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
          const Gap(20),
          Align(
            alignment: Alignment.center,
            child: MyText(
              text: title,
              size: 24.0,
              weight: FontWeight.w600,
              color: kDynamicText(Get.context!),
            ),
          ),
          const Gap(12),
          
          // Item Preview Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kDynamicScaffoldBackground(Get.context!),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kDynamicBorder(Get.context!)),
            ),
            child: Row(
              children: [
                // Product Image
                Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: kDynamicCard(Get.context!),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: kDynamicBorder(Get.context!), width: 1.2),
            ),
            child: CommonImageView(
              url: cartItem.product.image,
              height: 70.0,
              width: 70.0,
              radius: 12.0,
              fit: BoxFit.fill,
            ),
          ),
                const Gap(12),
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: cartItem.product.title,
                        size: 14,
                        weight: FontWeight.w600,
                        color: kDynamicText(Get.context!),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                      MyText(
                        text: "Quantity: ${cartItem.quantity}",
                        size: 12,
                        color: kDynamicListTileSubtitle(Get.context!),
                      ),
                      const Gap(2),
                      MyText(
                        text: "Total: \$${cartItem.totalPrice.toStringAsFixed(2)}",
                        size: 12,
                        weight: FontWeight.w600,
                        color: kDynamicPrimary(Get.context!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const Gap(16),
          MyText(
            text: message,
            size: 14,
            color: kDynamicListTileSubtitle(Get.context!),
          ),
          const Gap(24),
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: MyButton(
                  buttonText: cancelText,
                  onTap: () => Get.back(),
                  backgroundColor: kDynamicScaffoldBackground(Get.context!),
                  fontColor: kDynamicText(Get.context!),
                  outlineColor: kDynamicBorder(Get.context!),
                ),
              ),
              const Gap(12),
              // Confirm Button
              Expanded(
                child: MyButton(
                  buttonText: confirmText,
                  onTap: () {
                    Get.back();
                    onConfirm();
                  },
                  backgroundColor: Colors.red,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

// Updated specific cart item removal bottom sheet
static void showRemoveCartItemSheet({
  required CartItem cartItem,
  required ProductController productController,
}) {
  showRemoveItemSheet(
    title: "Remove Item ?",
    message: "Are you sure you want to remove this item from your cart?",
    cartItem: cartItem, // Pass the cartItem
    onConfirm: () => productController.removeFromCart(cartItem),
    confirmText: "Remove",
  );
}

// Updated clear cart bottom sheet with multiple items preview
static void showClearCartSheet({
  required ProductController productController,
}) {
  final cartItems = productController.cartItems;
  
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: const BorderRadius.only(
         topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 66,
              height: 4,
              decoration: BoxDecoration(
                color: kDynamicListTileSubtitle(Get.context!),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const Gap(20),
          MyText(
            text: "Clear Cart",
            size: 18,
            weight: FontWeight.w600,
            color: kDynamicText(Get.context!),
          ),
          const Gap(12),
          
          // Cart Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kDynamicScaffoldBackground(Get.context!),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kDynamicBorder(Get.context!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "You're about to remove ${cartItems.length} items from your cart:",
                  size: 14,
                  color: kDynamicListTileSubtitle(Get.context!),
                ),
                const Gap(8),
                
                // Limited items preview (show first 3 items)
                ...cartItems.take(3).map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      // In the clear cart sheet - replace the Container with:
CommonImageView(
  url: item.product.image,
  height: 30.0,
  width: 30.0,
  radius: 6.0,
  fit: BoxFit.fill,
),
                      const Gap(8),
                      Expanded(
                        child: MyText(
                          text: item.product.title,
                          size: 12,
                          color: kDynamicText(Get.context!),
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      MyText(
                        text: "×${item.quantity}",
                        size: 12,
                        color: kDynamicListTileSubtitle(Get.context!),
                      ),
                    ],
                  ),
                )),
                
                if (cartItems.length > 3) ...[
                  const Gap(4),
                  MyText(
                    text: "...and ${cartItems.length - 3} more items",
                    size: 12,
                    color: kDynamicListTileSubtitle(Get.context!),
                  ),
                ],
                
                const Gap(8),
                Divider(
                  color: kDynamicBorder(Get.context!),
                  height: 1,
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "Total Value:",
                      size: 14,
                      color: kDynamicText(Get.context!),
                    ),
                    MyText(
                      text: "\$${productController.totalCartValue.toStringAsFixed(2)}",
                      size: 16,
                      weight: FontWeight.w700,
                      color: kDynamicPrimary(Get.context!),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Gap(16),
          MyText(
            text: "Are you sure you want to remove all items from your cart? This action cannot be undone.",
            size: 14,
            color: kDynamicListTileSubtitle(Get.context!),
          ),
          const Gap(24),
          Row(
            children: [
              // Cancel Button
              Expanded(
                child: MyButton(
                  buttonText: "Cancel",
                  onTap: () => Get.back(),
                  backgroundColor: kDynamicScaffoldBackground(Get.context!),
                  fontColor: kDynamicText(Get.context!),
                  outlineColor: kDynamicBorder(Get.context!),
                ),
              ),
              const Gap(12),
              // Confirm Button
              Expanded(
                child: MyButton(
                  buttonText: "Clear All",
                  onTap: () {
                    Get.back();
                    productController.clearCart();
                  },
                  backgroundColor: Colors.red,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}


// Generic action bottom sheet with multiple options
static void showActionSheet({
  required String title,
  required List<SheetAction> actions,
}) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 66,
              height: 6,
              decoration: BoxDecoration(
                color: kDynamicListTileSubtitle(Get.context!),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(20),
          if (title.isNotEmpty) ...[
            MyText(
              text: title,
              size: 18,
              weight: FontWeight.w600,
              color: kDynamicText(Get.context!),
            ),
            const Gap(16),
          ],
          ...actions.map((action) => Column(
            children: [
              MyButtonWithIcon(
                text: action.title,
                onTap: () {
                  Get.back();
                  action.onTap();
                },
                iconPath: _getIconPathForAction(action.icon),
                iconColor: action.isDestructive 
                    ? Colors.red 
                    : kDynamicPrimary(Get.context!),
                fontColor: action.isDestructive 
                    ? Colors.red 
                    : kDynamicText(Get.context!),
                backgroundColor: kDynamicScaffoldBackground(Get.context!),
                outlineColor: kDynamicBorder(Get.context!),
                radius: 12.0,
                height: 50.0,
                hasShadow: false,
                isActive: true,
                isLoading: false,
              ),
              if (action != actions.last) const Gap(8),
            ],
          )),
          const Gap(12),
          // Cancel button
          MyButton(
            buttonText: "Cancel",
            onTap: () => Get.back(),
            backgroundColor: kDynamicScaffoldBackground(Get.context!),
            fontColor: kDynamicText(Get.context!),
            outlineColor: kDynamicBorder(Get.context!),
            radius: 12.0,
            height: 50.0,
            hasicon: false,
            hasshadow: false,
            isactive: true,
            isLoading: false,
          ),
          const Gap(10),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

// Helper method to convert IconData to icon path
static String _getIconPathForAction(IconData? icon) {
  if (icon == null) return Assets.cartfilled; // Use a placeholder asset
  
  // Map common IconData to your asset paths
  switch (icon) {
    case Icons.remove_red_eye_outlined:
      return Assets.cartfilled; // Replace with your actual asset path
    case Icons.shopping_cart_outlined:
      return Assets.cartfilled; // Replace with your actual asset path
    case Icons.share_outlined:
      return Assets.cartfilled; // Replace with your actual asset path
    case Icons.filter_alt:
      return Assets.filter; // Replace with your actual asset path
    case Icons.clear_all:
      return Assets.cartfilled; // Replace with your actual asset path
    case Icons.check:
      return Assets.check; // Replace with your actual asset path
    default:
      return Assets.cartfilled; // Default placeholder
  }
}
  // Product options bottom sheet
  static void showProductOptionsSheet({
    required ProductModel product,
    required VoidCallback onViewDetails,
    required VoidCallback onAddToCart,
  }) {
    showActionSheet(
      title: "Product Options",
      actions: [
        SheetAction(
          title: "View Details",
          icon: Icons.remove_red_eye_outlined,
          onTap: onViewDetails,
        ),
        SheetAction(
          title: "Add to Cart",
          icon: Icons.shopping_cart_outlined,
          onTap: onAddToCart,
        ),
        SheetAction(
          title: "Share Product",
          icon: Icons.share_outlined,
          onTap: () {
            // Implement share functionality
          },
        ),
      ],
    );
  }

  // Sort options bottom sheet
  static void showSortOptionsSheet({
    required String currentSort,
    required Function(String) onSortSelected,
  }) {
    final sortOptions = [
      {"label": "Price: Low to High", "value": "price_low"},
      {"label": "Price: High to Low", "value": "price_high"},
      {"label": "Most Popular", "value": "popular"},
      {"label": "Newest First", "value": "newest"},
      {"label": "Highest Rated", "value": "rating"},
    ];

    showActionSheet(
      title: "Sort By",
      actions: sortOptions.map((option) => SheetAction(
        title: option["label"]!,
        icon: currentSort == option["value"] ? Icons.check : null,
        onTap: () => onSortSelected(option["value"]!),
      )).toList(),
    );
  }

  // Filter options bottom sheet
  static void showFilterSheet({
    required VoidCallback onApplyFilters,
    required VoidCallback onClearFilters,
  }) {
    showActionSheet(
      title: "Filters",
      actions: [
        SheetAction(
          title: "Apply Filters",
          icon: Icons.filter_alt,
          onTap: onApplyFilters,
        ),
        SheetAction(
          title: "Clear All Filters",
          icon: Icons.clear_all,
          onTap: onClearFilters,
          isDestructive: true,
        ),
      ],
    );
  }

  // Quantity selector bottom sheet
  static void showQuantitySheet({
    required ProductModel product,
    required ProductController productController,
    required VoidCallback onAddToCart,
  }) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: kDynamicCard(Get.context!),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 66,
                height: 6,
                decoration: BoxDecoration(
                  color: kDynamicListTileSubtitle(Get.context!),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(20),
            MyText(
              text: "Select Quantity",
              size: 18,
              weight: FontWeight.w600,
              color: kDynamicText(Get.context!),
            ),
            const Gap(16),
            // Quantity Controls
            Container(
              decoration: BoxDecoration(
                color: kDynamicCard(Get.context!),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: kDynamicBorder(Get.context!),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Decrease button
                  IconButton(
                    onPressed: productController.decreaseQuantity,
                    icon: SvgPicture.asset(
                      Assets.minus,
                      color: kDynamicIcon(Get.context!),
                      height: 26,
                    ),
                  ),
                  // Quantity
                  Obx(() => Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: MyText(
                      text: productController.quantity.value.toString(),
                      size: 18,
                      weight: FontWeight.bold,
                      color: kDynamicText(Get.context!),
                    ),
                  )),
                  // Increase button
                  IconButton(
                    onPressed: productController.increaseQuantity,
                    icon: SvgPicture.asset(
                      Assets.add,
                      color: kDynamicIcon(Get.context!),
                      height: 26,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: MyButton(
                    buttonText: "Cancel",
                    onTap: () => Get.back(),
                  ),
                ),
                const Gap(12),
                // Add to Cart Button
                Expanded(
                  child: MyButton(
                    buttonText: "Add to Cart",
                    onTap: () {
                      Get.back();
                      onAddToCart();
                    },
                    backgroundColor: kDynamicPrimary(Get.context!),
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Color selection bottom sheet
  static void showColorSelectionSheet({
    required ProductModel product,
    required ProductController productController,
    required List<Color> colors,
    required VoidCallback onAddToCart,
  }) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: kDynamicCard(Get.context!),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(26.0),
          topRight: Radius.circular(26.0),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 66,
                height: 6,
                decoration: BoxDecoration(
                  color: kDynamicListTileSubtitle(Get.context!),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Gap(20),
            MyText(
              text: "Select Color",
              size: 18,
              weight: FontWeight.w600,
              color: kDynamicText(Get.context!),
            ),
            const Gap(16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(colors.length, (index) {
                return GestureDetector(
                  onTap: () => productController.setSelectedColor(index),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: productController.selectedColorIndex.value == index
                            ? kDynamicBorder(Get.context!)
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    child: productController.selectedColorIndex.value == index
                        ? SvgPicture.asset(
                            Assets.check,
                            height: 22,
                            color: kDynamicIcon(Get.context!),
                          )
                        : const SizedBox(width: 16, height: 16),
                  ),
                );
              }),
            ),
            const Gap(24),
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: MyButton(
                    buttonText: "Cancel",
                    onTap: () => Get.back(),
                  ),
                ),
                const Gap(12),
                // Add to Cart Button
                Expanded(
                  child: MyButton(
                    buttonText: "Add to Cart",
                    onTap: () {
                      Get.back();
                      onAddToCart();
                    },
                    backgroundColor: kDynamicPrimary(Get.context!),
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
// Add to BottomSheetHelper class
 void showAddressPreviewSheet({
  required String addressTitle,
  required String fullAddress,
  required Function(String title, String address) onEdit,
  VoidCallback? onDelete,
}) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: kDynamicListTileSubtitle(Get.context!),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(20),
          MyText(
            text: "Shipping Address",
            size: 18,
            weight: FontWeight.w600,
            color: kDynamicText(Get.context!),
          ),
          const Gap(16),
          // Current Address Display
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kDynamicScaffoldBackground(Get.context!),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kDynamicBorder(Get.context!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.pencilfilled, // Your location icon
                      height: 20,
                      color: kDynamicPrimary(Get.context!),
                    ),
                    const Gap(12),
                    MyText(
                      text: addressTitle,
                      size: 16,
                      weight: FontWeight.w600,
                      color: kDynamicText(Get.context!),
                    ),
                  ],
                ),
                const Gap(12),
                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: MyText(
                    text: fullAddress,
                    size: 14,
                    color: kDynamicListTileSubtitle(Get.context!),
                    maxLines: 4,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Gap(24),
          Row(
            children: [
              // Delete Button (only for existing addresses)
              if (onDelete != null) ...[
                Expanded(
                  child: MyButton(
                    buttonText: "Delete",
                    onTap: () {
                      Get.back();
                      onDelete();
                    },
                    backgroundColor: Colors.red,
                    fontColor: Colors.white,
                  ),
                ),
                const Gap(12),
              ],
              // Cancel Button
              Expanded(
                child: MyButton(
                  buttonText: "Cancel",
                  onTap: () => Get.back(),
                  backgroundColor: kDynamicScaffoldBackground(Get.context!),
                  fontColor: kDynamicText(Get.context!),
                  outlineColor: kDynamicBorder(Get.context!),
                ),
              ),
              const Gap(12),
              // Edit Button
              Expanded(
                child: MyButton(
                  buttonText: "Edit Address",
                  onTap: () {
                    Get.back(); // Close the sheet first
                    Get.to(
                      () => EditShippingAddressScreen(
                        currentTitle: addressTitle,
                        currentAddress: fullAddress,
                        onSave: onEdit,
                        onDelete: onDelete,
                      ),
                      transition: Transition.cupertino,
                    );
                  },
                  backgroundColor: kDynamicPrimary(Get.context!),
                
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}
// Add to BottomSheetHelper class
 void showEditAddressSheet({
  String? currentTitle,
  String? currentAddress,
  required Function(String title, String address) onSave,
  VoidCallback? onDelete,
}) {
  final TextEditingController titleController = 
      TextEditingController(text: currentTitle);
  final TextEditingController addressController = 
      TextEditingController(text: currentAddress);
  
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        color: kDynamicCard(Get.context!),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: kDynamicListTileSubtitle(Get.context!),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(20),
          MyText(
            text: currentTitle == null ? "Add New Address" : "Edit Address",
            size: 18,
            weight: FontWeight.w600,
            color: kDynamicText(Get.context!),
          ),
          const Gap(16),
          // Address Title Field
          MyTextField(
            controller: titleController,
            hint: "Address Title (e.g., Home, Office)",
            label: "Title",
           
          ),
          const Gap(12),
          // Address Field
          MyTextField(
            controller: addressController,
            hint: "Full Address",
            label: "Address",
            maxLines: 3,
           
          ),
          const Gap(24),
          Row(
            children: [
              // Delete Button (only for existing addresses)
              if (currentTitle != null && onDelete != null) ...[
                Expanded(
                  child: MyButton(
                    buttonText: "Delete",
                    onTap: () {
                      Get.back();
                      onDelete();
                    },
                    backgroundColor: Colors.red,
                    
                  ),
                ),
                const Gap(12),
              ],
              // Cancel Button
              Expanded(
                child: MyButton(
                  buttonText: "Cancel",
                  onTap: () => Get.back(),
                  
                ),
              ),
              const Gap(12),
              // Save Button
              Expanded(
                child: MyButton(
                  buttonText: "Save",
                  onTap: () {
                    if (titleController.text.trim().isEmpty || 
                        addressController.text.trim().isEmpty) {
                      AppToast.error("Please fill all fields");
                      return;
                    }
                    Get.back();
                    onSave(
                      titleController.text.trim(),
                      addressController.text.trim(),
                    );
                  },
                
                ),
              ),
            ],
          ),
          const Gap(10),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
}

// Model for sheet actions
class SheetAction {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isDestructive;

  SheetAction({
    required this.title,
    this.icon,
    required this.onTap,
    this.isDestructive = false,
  });
}