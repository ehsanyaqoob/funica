// controller/order-cont.dart
import 'package:funica/constants/export.dart';
import 'package:funica/models/order-model.dart';
import 'package:funica/widget/toasts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderController extends GetxController {
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    _simulateFetchOrders();
  }

  Future<void> _simulateFetchOrders() async {
    _isLoading = true;
    update();
    
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    try {
      _orders = await _getCachedOrders();
      print('✅ Loaded ${_orders.length} orders from cache');
    } catch (e) {
      print('❌ Error loading orders: $e');
      _orders = [];
    } finally {
      _isLoading = false;
      update();
    }
  }

  void addNewOrder(Order order) {
    _orders.insert(0, order); // Add to beginning of list
    _cacheOrders(); // Save to SharedPreferences
    update();
    print('✅ New order added: ${order.orderNumber}');
  }

  Future<void> _cacheOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = _orders.map((order) => order.toJson()).toList();
      await prefs.setString('cached_orders', json.encode(ordersJson));
      print('💾 Orders cached successfully: ${_orders.length} orders');
    } catch (e) {
      print('❌ Error caching orders: $e');
    }
  }

  Future<List<Order>> _getCachedOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString('cached_orders');
      
      if (ordersJson != null && ordersJson.isNotEmpty) {
        final List<dynamic> ordersList = json.decode(ordersJson);
        return ordersList.map((orderJson) => Order.fromJson(orderJson)).toList();
      } else {
        print('📝 No cached orders found, returning empty list');
        return [];
      }
    } catch (e) {
      print('❌ Error loading cached orders: $e');
      return [];
    }
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    update();
    
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));
    
    try {
      _orders = await _getCachedOrders();
      print('🔄 Refreshed orders: ${_orders.length} orders');
      AppToast.success("Orders updated!");
    } catch (e) {
      print('❌ Error refreshing orders: $e');
      AppToast.error("Failed to refresh orders");
    } finally {
      _isLoading = false;
      update();
    }
  }

  // CORRECTED: Simulate getting single order by ID
  Order? getOrderById(String orderNumber) {
    try {
      return _orders.firstWhere(
        (order) => order.orderNumber == orderNumber,
      );
    } catch (e) {
      return null; // Return null if order not found
    }
  }

  // Alternative method using try-catch with explicit return
  Order? getOrderByIdAlternative(String orderNumber) {
    for (final order in _orders) {
      if (order.orderNumber == orderNumber) {
        return order;
      }
    }
    return null;
  }

  // Clear all orders (for testing)
  Future<void> clearAllOrders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_orders');
    _orders = [];
    update();
    print('🗑️ All orders cleared');
  }

  // Get orders by status
  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }

  // Update order status
  void updateOrderStatus(String orderNumber, OrderStatus newStatus) {
    final orderIndex = _orders.indexWhere((order) => order.orderNumber == orderNumber);
    if (orderIndex != -1) {
      // Create a new order with updated status (since Order is immutable)
      final oldOrder = _orders[orderIndex];
      final updatedOrder = Order(
        orderNumber: oldOrder.orderNumber,
        orderDate: oldOrder.orderDate,
        items: oldOrder.items,
        totalAmount: oldOrder.totalAmount,
        shippingAddress: oldOrder.shippingAddress,
        paymentMethod: oldOrder.paymentMethod,
        status: newStatus,
        estimatedDelivery: oldOrder.estimatedDelivery,
      );
      
      _orders[orderIndex] = updatedOrder;
      _cacheOrders();
      update();
      print('✅ Order $orderNumber status updated to $newStatus');
    }
  }
}