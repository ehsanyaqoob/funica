// screens/checkout/edit_shipping_address_screen.dart
import 'package:funica/constants/export.dart';
import 'package:funica/widget/custom_appbar.dart';

class EditShippingAddressScreen extends StatefulWidget {
  final String? currentTitle;
  final String? currentAddress;
  final Function(String title, String address)? onSave;
  final VoidCallback? onDelete;

  const EditShippingAddressScreen({
    super.key,
    this.currentTitle,
    this.currentAddress,
    this.onSave,
    this.onDelete,
  });

  @override
  State<EditShippingAddressScreen> createState() =>
      _EditShippingAddressScreenState();
}

class _EditShippingAddressScreenState extends State<EditShippingAddressScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.currentTitle != null) {
      _titleController.text = widget.currentTitle!;
    }
    if (widget.currentAddress != null) {
      _addressController.text = widget.currentAddress!;
    }
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      widget.onSave?.call(
        _titleController.text.trim(),
        _addressController.text.trim(),
      );
      Get.back();
    }
  }

  void _deleteAddress() {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: MyText(
          text: "Delete Address",
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(Get.context!),
        ),
        content: MyText(
          text: "Are you sure you want to delete this address?",
          size: 14,
          color: kDynamicListTileSubtitle(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: "Cancel",
              size: 14,
              color: kDynamicListTileSubtitle(Get.context!),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              widget.onDelete?.call();
              Get.back(); // Close edit screen too
            },
            child: MyText(
              text: "Delete",
              size: 14,
              color: Colors.red,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
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
              title: widget.currentTitle == null
                  ? "Add Address"
                  : "Edit Address",
              showLeading: true,
              centerTitle: false,
            ),
            body: Padding(
              padding: AppSizes.DEFAULT,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Address Title Field
                    MyTextField(
                      controller: _titleController,
                      hint: "Address Title (e.g., Home, Office)",
                      label: "Title",

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter address title';
                        }
                        return null;
                      },
                    ),
                    const Gap(16),
                    // Address Field
                    MyTextField(
                      controller: _addressController,
                      hint: "Full Address",
                      label: "Address",
                      maxLines: 4,

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter full address';
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    // Delete Button (only for existing addresses)
                    if (widget.currentTitle != null && widget.onDelete != null)
                      MyButton(
                        buttonText: "Delete Address",
                        onTap: _deleteAddress,
                        backgroundColor: Colors.red,
                        fontColor: Colors.white,
                        mBottom: 12,
                      ),
                    // Save Button
                    MyButton(
                      buttonText: "Save Address",
                      onTap: _saveAddress,
                      backgroundColor: kDynamicPrimary(context),
                      fontColor: Colors.white,
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
}

class ShippingAddressWidget extends StatelessWidget {
  final String addressTitle;
  final String fullAddress;
  final bool isSelected;
  final VoidCallback onEditPressed;

  const ShippingAddressWidget({
    super.key,
    required this.addressTitle,
    required this.fullAddress,
    required this.isSelected,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Fixed height
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kDynamicCard(context),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: kDynamicBorder(context), width: 1.5),
      ),
      child: Row(
        children: [
          // Location Icon
          Container(
            //margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: kDynamicCard(context),
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: kDynamicBorder(context), width: 1.5),
            ),
            child: SvgPicture.asset(
              Assets.loaction,
              height: 18.0,
              color: kDynamicIcon(context),
            ),
          ),
          const Gap(8),

          // Address Details - Single line
          Expanded(
            child: Row(
              children: [
                MyText(
                  text: addressTitle,
                  size: 18.0,
                  weight: FontWeight.bold,
                  color: kDynamicText(context),
                ),
                const Gap(4),
                MyText(
                  text: "•",
                  size: 12,
                  color: kDynamicListTileSubtitle(context),
                ),
                const Gap(4),
                Expanded(
                  child: MyText(
                    text: fullAddress,
                    size: 11,
                    color: kDynamicListTileSubtitle(context),
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const Gap(8),

          // Selected indicator (small)
          if (isSelected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: kDynamicPrimary(context).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: MyText(
                text: "✓",
                size: 10,
                color: kDynamicText(context),
                weight: FontWeight.bold,
              ),
            ),

          const Gap(8),

          // Edit Button (small)
          Bounce(
            onTap: onEditPressed,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: kDynamicCard(context),
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: kDynamicBorder(context), width: 1.5),
              ),
              child: SvgPicture.asset(
                Assets.pencilfilled,
                height: 18.0,
                color: kDynamicIcon(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
