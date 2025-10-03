// models/order_model.dart
import 'package:funica/models/product-model.dart';

class Order {
  final String orderNumber;
  final DateTime orderDate;
  final List<CartItem> items;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final OrderStatus status;
  final DateTime estimatedDelivery;

  Order({
    required this.orderNumber,
    required this.orderDate,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    required this.estimatedDelivery,
  });

  // Convert Order to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'orderDate': orderDate.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'status': status.toString(),
      'estimatedDelivery': estimatedDelivery.toIso8601String(),
    };
  }

  // Create Order from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderNumber: json['orderNumber'],
      orderDate: DateTime.parse(json['orderDate']),
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      shippingAddress: json['shippingAddress'],
      paymentMethod: json['paymentMethod'],
      status: _statusFromString(json['status']),
      estimatedDelivery: DateTime.parse(json['estimatedDelivery']),
    );
  }

  // Convert string to OrderStatus
  static OrderStatus _statusFromString(String status) {
    switch (status) {
      case 'OrderStatus.confirmed':
        return OrderStatus.confirmed;
      case 'OrderStatus.processing':
        return OrderStatus.processing;
      case 'OrderStatus.shipped':
        return OrderStatus.shipped;
      case 'OrderStatus.delivered':
        return OrderStatus.delivered;
      case 'OrderStatus.cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

class CartItem {
  final ProductModel product;
  final int quantity;
  final int? selectedColorIndex;
  final double totalPrice;

  CartItem({
    required this.product,
    required this.quantity,
    this.selectedColorIndex,
  }) : totalPrice = (double.tryParse(product.price.replaceAll('\$', '')) ?? 0) *
            quantity;

  CartItem copyWith({
    int? quantity,
    int? selectedColorIndex,
  }) {
    return CartItem(
      product: product,
      quantity: quantity ?? this.quantity,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'selectedColorIndex': selectedColorIndex,
      'totalPrice': totalPrice,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      selectedColorIndex: json['selectedColorIndex'],
    );
  }
}
