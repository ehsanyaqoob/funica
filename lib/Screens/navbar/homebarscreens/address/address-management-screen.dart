// address_management_screen.dart
import 'package:funica/Screens/navbar/cart/shippin-screen.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/widget/custom_appbar.dart';
import 'package:funica/widget/toasts.dart';
import 'package:get_storage/get_storage.dart';

class AddressManagementScreen extends StatefulWidget {
  const AddressManagementScreen({super.key});

  @override
  State<AddressManagementScreen> createState() => _AddressManagementScreenState();
}

class _AddressManagementScreenState extends State<AddressManagementScreen> {
  final List<AddressModel> _addresses = [];
  final GetStorage _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _loadAddressesFromStorage();
  }

  void _loadAddressesFromStorage() {
    final savedAddresses = _storage.read<List>('user_addresses') ?? [];
    setState(() {
      _addresses.clear();
      _addresses.addAll(savedAddresses.map((address) => AddressModel.fromJson(address)));
    });
  }

  void _saveAddressesToStorage() {
    _storage.write('user_addresses', _addresses.map((address) => address.toJson()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Addresses",
        showLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _addresses.isEmpty 
              ? _buildEmptyState()
              : ListView.builder(
                  padding: AppSizes.DEFAULT,
                  itemCount: _addresses.length,
                  itemBuilder: (context, index) {
                    final address = _addresses[index];
                    return _buildAddressCard(address);
                  },
                ),
          ),
          Padding(
            padding: AppSizes.DEFAULT,
            child: MyButton(
              buttonText: "Add New Address",
              onTap: _addNewAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(AddressModel address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kDynamicCard(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: address.isDefault ? kPrimaryColor : kDynamicBorder(context)!,
          width: address.isDefault ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kDynamicBackground(context),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: SvgPicture.asset(
                  Assets.loaction,
                  height: 16,
                  color: kDynamicIcon(context),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Row(
                  children: [
                    MyText(
                      text: address.title,
                      size: 16,
                      weight: FontWeight.w600,
                      color: kDynamicText(context),
                    ),
                    const Gap(8),
                    if (address.isDefault)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: MyText(
                          text: "Default",
                          size: 10,
                          color: kPrimaryColor,
                          weight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ),
              Bounce(
                onTap: () => _editAddress(address),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kDynamicBackground(context),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(
                    Assets.pencilfilled,
                    height: 16,
                    color: kDynamicIcon(context),
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          MyText(
            text: address.fullAddress,
            size: 14,
            color: kDynamicSubtitleText(context),
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
          const Gap(12),
          Row(
            children: [
              if (!address.isDefault)
                Expanded(
                  child: MyButton(
                    buttonText: "Set as Default",
                    onTap: () => _setAsDefault(address.id),
                   
                  ),
                ),
              if (!address.isDefault) const Gap(8),
              Expanded(
                child: MyButton(
                  buttonText: "Delete",
                  onTap: () => _deleteAddress(address),
                 
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.loaction,
            height: 80,
            color: kDynamicIcon(context),
          ),
          const Gap(20),
          MyText(
            text: "No addresses saved",
            size: 18,
            color: kDynamicText(context),
            weight: FontWeight.w500,
          ),
          const Gap(8),
          MyText(
            text: "Add your first address to get started",
            size: 14,
            color: kDynamicSubtitleText(context),
          ),
        ],
      ),
    );
  }

  void _addNewAddress() {
    Get.to(() => EditShippingAddressScreen(
      onSave: (title, address) {
        _saveNewAddress(title, address);
      },
    ));
  }

  void _saveNewAddress(String title, String fullAddress) {
    final newAddress = AddressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      fullAddress: fullAddress,
      isDefault: _addresses.isEmpty,
    );
    
    setState(() {
      _addresses.add(newAddress);
    });
    _saveAddressesToStorage();
    AppToast.success('Address added successfully');
    Get.back();
  }

  void _editAddress(AddressModel address) {
    Get.to(() => EditShippingAddressScreen(
      currentTitle: address.title,
      currentAddress: address.fullAddress,
      onSave: (title, newAddress) {
        _updateAddress(address.id, title, newAddress);
      },
      onDelete: () {
        _deleteAddress(address);
      },
    ));
  }

  void _updateAddress(String id, String title, String fullAddress) {
    setState(() {
      final index = _addresses.indexWhere((a) => a.id == id);
      if (index != -1) {
        _addresses[index] = _addresses[index].copyWith(
          title: title,
          fullAddress: fullAddress,
        );
      }
    });
    _saveAddressesToStorage();
    AppToast.success('Address updated successfully');
    Get.back();
  }

  void _setAsDefault(String id) {
    setState(() {
      for (var address in _addresses) {
        if (address.isDefault) {
          final index = _addresses.indexWhere((a) => a.id == address.id);
          _addresses[index] = address.copyWith(isDefault: false);
        }
      }
      
      final index = _addresses.indexWhere((a) => a.id == id);
      if (index != -1) {
        _addresses[index] = _addresses[index].copyWith(isDefault: true);
      }
    });
    _saveAddressesToStorage();
    AppToast.success('Default address updated');
  }

  void _deleteAddress(AddressModel address) {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: MyText(
          text: "Delete Address",
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(context),
        ),
        content: MyText(
          text: "Are you sure you want to delete ${address.title}?",
          size: 14,
          color: kDynamicSubtitleText(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: "Cancel",
              size: 14,
              color: kDynamicSubtitleText(context),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              setState(() {
                _addresses.removeWhere((a) => a.id == address.id);
                if (address.isDefault && _addresses.isNotEmpty) {
                  _addresses[0] = _addresses[0].copyWith(isDefault: true);
                }
              });
              _saveAddressesToStorage();
              AppToast.success('Address deleted successfully');
              Get.back(); // Close edit screen
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
}

class AddressModel {
  final String id;
  final String title;
  final String fullAddress;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.fullAddress,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fullAddress': fullAddress,
      'isDefault': isDefault,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      fullAddress: json['fullAddress'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }

  AddressModel copyWith({
    String? title,
    String? fullAddress,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id,
      title: title ?? this.title,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}