import 'package:funica/Screens/navbar/cart/choose-shiping.dart'
    show ShippingScreen;
import 'package:funica/Screens/navbar/cart/shippin-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/controller/prodcut-cont.dart';
import 'package:funica/models/order-model.dart';
import 'package:funica/widget/bottomsheets/helper-sheets.dart'
    as BottomSheetHelper;
import 'package:funica/widget/custom_appbar.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalAmount;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}
class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedAddress = "Home";
  final Map<String, String> _addresses = {
    "Home": "123 Main Street, Apartment 4B, New York, NY 10001, United States",
  };

  void _showAddressPreview(String addressTitle, String currentAddress) {
    BottomSheetHelper.showAddressPreviewSheet(
      addressTitle: addressTitle,
      fullAddress: currentAddress,
      onEdit: (newTitle, newAddress) {
        setState(() {
          _addresses.remove(addressTitle);
          _addresses[newTitle] = newAddress;
          if (_selectedAddress == addressTitle) {
            _selectedAddress = newTitle;
          }
        });
      },
      onDelete: _addresses.length > 1
          ? () {
              setState(() {
                _addresses.remove(addressTitle);
                if (_selectedAddress == addressTitle && _addresses.isNotEmpty) {
                  _selectedAddress = _addresses.keys.first;
                }
              });
            }
          : null, // Don't allow delete if only one address
    );
  }

  void _showAddAddressSheet() {
    BottomSheetHelper.showEditAddressSheet(
      onSave: (title, address) {
        setState(() {
          _addresses[title] = address;
        });
      },
    );
  }

  void _proceedToShipping() {
    Get.to(
      () => ShippingScreen(
        cartItems: widget.cartItems,
        totalAmount: widget.totalAmount,
        selectedAddress: _selectedAddress,
      ),
      transition: Transition.cupertino,
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
            appBar: CustomAppBar(
              title: "Checkout",
              showLeading: true,
              centerTitle: false,
            ),
            body: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shipping Address Section
                  Row(
                    children: [
                      MyText(
                        text: "Shipping Address",
                        size: 20,
                        weight: FontWeight.bold,
                        color: kDynamicText(context),
                      ),
                      const Spacer(),
                      // Add New Address Button (only show if less than 3 addresses)
                      if (_addresses.length < 3)
                        Bounce(
                          onTap: _showAddAddressSheet,
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: kDynamicCard(context),
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: kDynamicBorder(context),
                                width: 1.2,
                              ),
                            ),
                            child: MyText(
                              text: "Add New",
                              size: 12,
                              color: kDynamicText(context),
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(16),

                  // Single Address Display (only show the selected one)
                  ShippingAddressWidget(
                    addressTitle: _selectedAddress,
                    fullAddress: _addresses[_selectedAddress]!,
                    isSelected: true,
                    onEditPressed: () => _showAddressPreview(
                      _selectedAddress,
                      _addresses[_selectedAddress]!,
                    ),
                  ),

                  // Address Selection Dropdown if multiple addresses exist
                  if (_addresses.length > 1) ...[
                    const Gap(12),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: kDynamicCard(context),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: kDynamicBorder(context),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          MyText(
                            text: "Change to:",
                            size: 14,
                            color: kDynamicListTileSubtitle(context),
                          ),
                          const Gap(8),
                          Expanded(
                            child: DropdownButton<String>(
                              value: _selectedAddress,
                              isExpanded: true,
                              underline: const SizedBox(),
                              dropdownColor: kDynamicCard(context),
                              style: TextStyle(
                                color: kDynamicText(context),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              items: _addresses.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: MyText(
                                    text: entry.key,
                                    size: 14,
                                    color: kDynamicText(context),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedAddress = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const Gap(24),

                  // Order List
                  MyText(
                    text: "Order List",
                    size: 20,
                    weight: FontWeight.w600,
                    color: kDynamicText(context),
                  ),
                  const Gap(16),

                  // Cart Items List
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = widget.cartItems[index];
                        return _buildCheckoutItem(cartItem);
                      },
                    ),
                  ),
                ],
              ),
            ),
           bottomNavigationBar: Container(
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
              MyText(
                text: "\$${widget.totalAmount.toStringAsFixed(2)}",
                size: 20.0,
                weight: FontWeight.bold,
                color: kDynamicText(context),
              ),
              const Gap(2),
              MyText(
                text: "${widget.cartItems.length} items",
                size: 12,
                color: kDynamicListTileSubtitle(context),
              ),
            ],
          ),
        ),
        const Gap(18.0),
        Expanded(
          child: MyButtonWithIcon(
            iconPath: Assets.checkout,
            text: "Continue",
            onTap: _proceedToShipping,
          ),
        ),
      ],
    ),
  ),
),

          ),
        );
      },
    );
  }

  Widget _buildCheckoutItem(CartItem cartItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kDynamicCard(context),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: kDynamicBorder(context), width: 1.2),
      ),
      child: Row(
        children: [
          CommonImageView(
            url: cartItem.product.image,
            height: 60,
            width: 60,
            radius: 8,
            fit: BoxFit.fill,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: cartItem.product.title,
                  size: 18.0,
                  weight: FontWeight.bold,
                  color: kDynamicText(context),
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                Row(
                  children: [
                    MyText(
                      text: "Qty: ${cartItem.quantity}",
                      size: 14.0,
                      color: kDynamicListTileSubtitle(context),
                    ),
                    const Gap(8),
                    if (cartItem.selectedColorIndex != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MyText(
                            text: "• Color: ",
                            size: 14.0,
                            color: kDynamicListTileSubtitle(context),
                          ),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getColorFromIndex(
                                cartItem.selectedColorIndex!,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kDynamicBorder(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                const Gap(4),
                MyText(
                  text: "\$${cartItem.totalPrice.toStringAsFixed(2)}",
                  size: 18.0,
                  weight: FontWeight.bold,
                  color: kDynamicText(context),
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
}

  
