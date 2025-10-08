// // payment_management_screen.dart
// import 'package:funica/constants/export.dart';
// import 'package:funica/widget/custom_appbar.dart';
// import 'package:funica/widget/toasts.dart';
// import 'package:funica/widget/visa-card/visa-card.dart';
// import 'package:get_storage/get_storage.dart';

// class PaymentManagementScreen extends StatefulWidget {
//   const PaymentManagementScreen({super.key});

//   @override
//   State<PaymentManagementScreen> createState() => _PaymentManagementScreenState();
// }

// class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
//   final List<PaymentMethod> _paymentMethods = [];
//   final GetStorage _storage = GetStorage();
//   PaymentMethod? _defaultMethod;
//   // Add the method here
//   String _getPaymentMethodIcon(String methodId) {
//     switch (methodId) {
//       case "wallet":
//         return Assets.walletfilled;
//       case "paypal":
//         return Assets.paypal;
//       case "google_pay":
//         return Assets.google;
//       case "apple_pay":
//         return Assets.apple;
//       case "stripe":
//         return Assets.walletfilled;
//       case "amazon_pay":
//         return Assets.amazon;
//       case "card":
//         return Assets.visa;
//       default:
//         return Assets.walletfilled;
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     _loadPaymentMethods();
//   }

//   void _loadPaymentMethods() {
//     final savedMethods = _storage.read<List>('user_payment_methods') ?? [];
//     final savedDefault = _storage.read<String>('default_payment_method');
    
//     setState(() {
//       _paymentMethods.clear();
//       _paymentMethods.addAll(savedMethods.map((method) => PaymentMethod.fromJson(method)));
      
//       if (savedDefault != null) {
//         _defaultMethod = _paymentMethods.firstWhere(
//           (method) => method.id == savedDefault,
//           orElse: () => _paymentMethods.first,
//         );
//       } else if (_paymentMethods.isNotEmpty) {
//         _defaultMethod = _paymentMethods.first;
//       }
//     });
//   }

//   void _savePaymentMethods() {
//     _storage.write('user_payment_methods', _paymentMethods.map((method) => method.toJson()).toList());
//     if (_defaultMethod != null) {
//       _storage.write('default_payment_method', _defaultMethod!.id);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: "Payment Methods",
//         showLeading: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _paymentMethods.isEmpty 
//               ? _buildEmptyState()
//               : ListView.builder(
//                   padding: AppSizes.DEFAULT,
//                   itemCount: _paymentMethods.length,
//                   itemBuilder: (context, index) {
//                     final method = _paymentMethods[index];
//                     return _buildPaymentMethodTile(method);
//                   },
//                 ),
//           ),
//           Padding(
//             padding: AppSizes.DEFAULT,
//             child: MyButton(
//               buttonText: "Add Payment Method",
//               onTap: _addPaymentMethod,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentMethodTile(PaymentMethod method) {
//     final isDefault = _defaultMethod?.id == method.id;
    
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: kDynamicCard(context),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isDefault ? kPrimaryColor : kDynamicBorder(context)!,
//           width: isDefault ? 2 : 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               // Payment Method Icon
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: kDynamicBackground(context),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: SvgPicture.asset(
//                   _getPaymentMethodIcon(method.type),
//                   height: 24,
//                   color: kDynamicIcon(context),
//                 ),
//               ),
//               const Gap(12),
              
//               // Payment Method Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MyText(
//                       text: method.type == 'card' 
//                           ? '${method.cardType} •••• ${method.cardNumber?.substring(method.cardNumber!.length - 4)}'
//                           : method.type.replaceAll('_', ' ').toUpperCase(),
//                       size: 16,
//                       weight: FontWeight.w600,
//                       color: kDynamicText(context),
//                     ),
//                     const Gap(4),
//                     MyText(
//                       text: method.type == 'card' 
//                           ? 'Expires ${method.expiryDate}'
//                           : method.email ?? '',
//                       size: 12,
//                       color: kDynamicSubtitleText(context),
//                     ),
//                   ],
//                 ),
//               ),
              
//               // Default Badge
//               if (isDefault)
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: kPrimaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: MyText(
//                     text: "Default",
//                     size: 10,
//                     color: kPrimaryColor,
//                     weight: FontWeight.w500,
//                   ),
//                 ),
              
//               const Gap(12),
              
//               // Edit Button
//               Bounce(
//                 onTap: () => _editPaymentMethod(method),
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: kDynamicBackground(context),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: SvgPicture.asset(
//                     Assets.pencilfilled,
//                     height: 16,
//                     color: kDynamicIcon(context),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Gap(12),
          
//           // Action Buttons
//           Row(
//             children: [
//               // Set as Default Button
//               if (!isDefault)
//                 Expanded(
//                   child: MyButton(
//                     buttonText: "Set as Default",
//                     onTap: () => _setAsDefault(method.id),
                    
//                   ),
//                 ),
//               if (!isDefault) const Gap(8),
              
//               // Delete Button
//               Expanded(
//                 child: MyButton(
//                   buttonText: "Delete",
//                   onTap: () => _deletePaymentMethod(method),
                 
//                   height: 36,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             Assets.walletfilled,
//             height: 80,
//             color: kDynamicIcon(context),
//           ),
//           const Gap(20),
//           MyText(
//             text: "No payment methods",
//             size: 18,
//             color: kDynamicText(context),
//             weight: FontWeight.w500,
//           ),
//           const Gap(8),
//           MyText(
//             text: "Add your first payment method to get started",
//             size: 14,
//             color: kDynamicSubtitleText(context),
//           ),
//         ],
//       ),
//     );
//   }

//   void _addPaymentMethod() {
//     Get.to(() => AddPaymentMethodScreen(
//       onSave: (method) {
//         _saveNewPaymentMethod(method);
//       },
//     ));
//   }

//   void _saveNewPaymentMethod(PaymentMethod method) {
//     setState(() {
//       _paymentMethods.add(method);
//       if (_paymentMethods.length == 1) {
//         _defaultMethod = method;
//       }
//     });
//     _savePaymentMethods();
//     AppToast.success('Payment method added successfully');
//     Get.back();
//   }

//   void _editPaymentMethod(PaymentMethod method) {
//     Get.to(() => AddPaymentMethodScreen(
//       method: method,
//       onSave: (updatedMethod) {
//         _updatePaymentMethod(method.id, updatedMethod);
//       },
//     ));
//   }

//   void _updatePaymentMethod(String id, PaymentMethod updatedMethod) {
//     setState(() {
//       final index = _paymentMethods.indexWhere((method) => method.id == id);
//       if (index != -1) {
//         _paymentMethods[index] = updatedMethod.copyWith(id: id);
//         if (_defaultMethod?.id == id) {
//           _defaultMethod = updatedMethod.copyWith(id: id);
//         }
//       }
//     });
//     _savePaymentMethods();
//     AppToast.success('Payment method updated successfully');
//     Get.back();
//   }

//   void _setAsDefault(String id) {
//     setState(() {
//       _defaultMethod = _paymentMethods.firstWhere((method) => method.id == id);
//     });
//     _savePaymentMethods();
//     AppToast.success('Default payment method updated');
//   }

//   void _deletePaymentMethod(PaymentMethod method) {
//     Get.dialog(
//       AlertDialog(
//         backgroundColor: kDynamicCard(context),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: MyText(
//           text: "Delete Payment Method",
//           size: 18,
//           weight: FontWeight.w600,
//           color: kDynamicText(context),
//         ),
//         content: MyText(
//           text: "Are you sure you want to delete this payment method?",
//           size: 14,
//           color: kDynamicSubtitleText(context),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: MyText(
//               text: "Cancel",
//               size: 14,
//               color: kDynamicSubtitleText(context),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Get.back();
//               setState(() {
//                 _paymentMethods.removeWhere((m) => m.id == method.id);
//                 if (_defaultMethod?.id == method.id && _paymentMethods.isNotEmpty) {
//                   _defaultMethod = _paymentMethods.first;
//                 } else if (_paymentMethods.isEmpty) {
//                   _defaultMethod = null;
//                 }
//               });
//               _savePaymentMethods();
//               AppToast.success('Payment method deleted successfully');
//             },
//             child: MyText(
//               text: "Delete",
//               size: 14,
//               color: Colors.red,
//               weight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// }
// // Add/Edit Payment Method Screen
// class AddPaymentMethodScreen extends StatefulWidget {
//   final PaymentMethod? method;
//   final Function(PaymentMethod) onSave;

//   const AddPaymentMethodScreen({
//     super.key,
//     this.method,
//     required this.onSave,
//   });

//   @override
//   State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
// }

// class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {
//   final TextEditingController _cardNumberController = TextEditingController();
//   final TextEditingController _cardHolderController = TextEditingController();
//   final TextEditingController _expiryDateController = TextEditingController();
//   final TextEditingController _cvvController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
  
//   String _selectedType = 'card';
//   String _cardType = 'Visa';

//   @override
//   void initState() {
//     super.initState();
//     if (widget.method != null) {
//       _selectedType = widget.method!.type;
//       _cardNumberController.text = widget.method!.cardNumber ?? '';
//       _cardHolderController.text = widget.method!.cardHolderName ?? '';
//       _expiryDateController.text = widget.method!.expiryDate ?? '';
//       _cvvController.text = widget.method!.cvv ?? '';
//       _emailController.text = widget.method!.email ?? '';
//       _cardType = widget.method!.cardType ?? 'Visa';
//     }
//   }

//   void _savePaymentMethod() {
//     if (_formKey.currentState!.validate()) {
//       final method = PaymentMethod(
//         id: widget.method?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
//         type: _selectedType,
//         cardNumber: _selectedType == 'card' ? _cardNumberController.text : null,
//         cardHolderName: _selectedType == 'card' ? _cardHolderController.text : null,
//         expiryDate: _selectedType == 'card' ? _expiryDateController.text : null,
//         cvv: _selectedType == 'card' ? _cvvController.text : null,
//         email: _selectedType != 'card' ? _emailController.text : null,
//         cardType: _selectedType == 'card' ? _cardType : null,
//       );
      
//       widget.onSave(method);
//     }
//   }

//   void _detectCardType(String number) {
//     if (number.startsWith('4')) {
//       setState(() => _cardType = 'Visa');
//     } else if (number.startsWith('5')) {
//       setState(() => _cardType = 'MasterCard');
//     } else if (number.startsWith('3')) {
//       setState(() => _cardType = 'American Express');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: widget.method == null ? "Add Payment Method" : "Edit Payment Method",
//         showLeading: true,
//       ),
//       body: Padding(
//         padding: AppSizes.DEFAULT,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Payment Method Type Selection
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: kDynamicCard(context),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     MyText(
//                       text: "Payment Method Type",
//                       size: 16,
//                       weight: FontWeight.w600,
//                       color: kDynamicText(context),
//                     ),
//                     const Gap(12),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: [
//                         _buildTypeOption('card', 'Credit/Debit Card'),
//                         _buildTypeOption('paypal', 'PayPal'),
//                         _buildTypeOption('google_pay', 'Google Pay'),
//                         _buildTypeOption('apple_pay', 'Apple Pay'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Gap(16),
              
//               // Card Preview
//               if (_selectedType == 'card')
//                 CustomVisaCard(
//                   name: _cardHolderController.text.isEmpty ? 'Your Name' : _cardHolderController.text,
//                   cardNumber: _cardNumberController.text.isEmpty ? '0000000000000000' : _cardNumberController.text,
//                   balance: 0.0,
//                   expiryDate: _expiryDateController.text.isEmpty ? 'MM/YY' : _expiryDateController.text,
//                   cvv: _cvvController.text.isEmpty ? '000' : _cvvController.text,
//                 ),
              
//               const Gap(16),
              
//               // Dynamic Form Fields
//               Expanded(
//                 child: ListView(
//                   children: [
//                     if (_selectedType == 'card') ..._buildCardForm(),
//                     if (_selectedType != 'card') ..._buildDigitalWalletForm(),
//                   ],
//                 ),
//               ),
              
//               // Save Button
//               MyButton(
//                 buttonText: widget.method == null ? "Add Payment Method" : "Update Payment Method",
//                 onTap: _savePaymentMethod,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTypeOption(String type, String label) {
//     final isSelected = _selectedType == type;
//     return Bounce(
//       onTap: () => setState(() => _selectedType = type),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? kPrimaryColor : kDynamicBackground(context),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isSelected ? kPrimaryColor : kDynamicBorder(context)!,
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SvgPicture.asset(
//               PaymentManagementScreen._getPaymentMethodIcon(type),
//               height: 20,
//               color: isSelected ? Colors.white : kDynamicIcon(context),
//             ),
//             const Gap(8),
//             MyText(
//               text: label,
//               size: 14,
//               color: isSelected ? Colors.white : kDynamicText(context),
//               weight: FontWeight.w500,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildCardForm() {
//     return [
//       MyTextField(
//         controller: _cardHolderController,
//         hint: "Card Holder Name",
//         label: "Full Name",
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) {
//             return 'Please enter card holder name';
//           }
//           return null;
//         },
//       ),
//       const Gap(12),
//       MyTextField(
//         controller: _cardNumberController,
//         hint: "Card Number",
//         label: "Card Number",
//         keyboardType: TextInputType.number,
//         onChanged: (value) => _detectCardType(value),
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) {
//             return 'Please enter card number';
//           }
//           if (value.replaceAll(' ', '').length != 16) {
//             return 'Card number must be 16 digits';
//           }
//           return null;
//         },
//       ),
//       const Gap(12),
//       Row(
//         children: [
//           Expanded(
//             child: MyTextField(
//               controller: _expiryDateController,
//               hint: "MM/YY",
//               label: "Expiry Date",
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Please enter expiry date';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           const Gap(12),
//           Expanded(
//             child: MyTextField(
//               controller: _cvvController,
//               hint: "CVV",
//               label: "CVV",
//               keyboardType: TextInputType.number,
//               isObSecure: true,
//               validator: (value) {
//                 if (value == null || value.trim().isEmpty) {
//                   return 'Please enter CVV';
//                 }
//                 if (value.length != 3) {
//                   return 'CVV must be 3 digits';
//                 }
//                 return null;
//               },
//             ),
//           ),
//         ],
//       ),
//     ];
//   }

//   List<Widget> _buildDigitalWalletForm() {
//     return [
//       MyTextField(
//         controller: _emailController,
//         hint: "Email Address",
//         label: "Email",
//         keyboardType: TextInputType.emailAddress,
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) {
//             return 'Please enter email address';
//           }
//           if (!value.contains('@')) {
//             return 'Please enter a valid email';
//           }
//           return null;
//         },
//       ),
//     ];
//   }
// }

// class _getPaymentMethodIcon {
// }

// // Payment Method Model
// class PaymentMethod {
//   final String id;
//   final String type; // 'card', 'paypal', 'google_pay', 'apple_pay'
//   final String? cardNumber;
//   final String? cardHolderName;
//   final String? expiryDate;
//   final String? cvv;
//   final String? email;
//   final String? cardType;

//   PaymentMethod({
//     required this.id,
//     required this.type,
//     this.cardNumber,
//     this.cardHolderName,
//     this.expiryDate,
//     this.cvv,
//     this.email,
//     this.cardType,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'type': type,
//       'cardNumber': cardNumber,
//       'cardHolderName': cardHolderName,
//       'expiryDate': expiryDate,
//       'cvv': cvv,
//       'email': email,
//       'cardType': cardType,
//     };
//   }

//   factory PaymentMethod.fromJson(Map<String, dynamic> json) {
//     return PaymentMethod(
//       id: json['id'] ?? '',
//       type: json['type'] ?? '',
//       cardNumber: json['cardNumber'],
//       cardHolderName: json['cardHolderName'],
//       expiryDate: json['expiryDate'],
//       cvv: json['cvv'],
//       email: json['email'],
//       cardType: json['cardType'],
//     );
//   }

//   PaymentMethod copyWith({
//     String? id,
//     String? type,
//     String? cardNumber,
//     String? cardHolderName,
//     String? expiryDate,
//     String? cvv,
//     String? email,
//     String? cardType,
//   }) {
//     return PaymentMethod(
//       id: id ?? this.id,
//       type: type ?? this.type,
//       cardNumber: cardNumber ?? this.cardNumber,
//       cardHolderName: cardHolderName ?? this.cardHolderName,
//       expiryDate: expiryDate ?? this.expiryDate,
//       cvv: cvv ?? this.cvv,
//       email: email ?? this.email,
//       cardType: cardType ?? this.cardType,
//     );
//   }
// }