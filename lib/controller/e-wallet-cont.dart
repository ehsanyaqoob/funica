// controllers/e-wallet-cont.dart
import 'package:funica/constants/export.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  final RxList<TransactionModel> _transactions = <TransactionModel>[].obs;
  final RxList<TransactionModel> _filteredTransactions = <TransactionModel>[].obs;
  final RxString _searchQuery = ''.obs;
  
  List<TransactionModel> get transactions => 
      _searchQuery.value.isEmpty ? _transactions : _filteredTransactions;
  
  // Filtered transactions
  List<TransactionModel> get topUpTransactions => 
      _transactions.where((t) => t.isTopUp).toList();
  
  List<TransactionModel> get orderTransactions => 
      _transactions.where((t) => !t.isTopUp).toList();

  @override
  void onInit() {
    super.onInit();
    _loadTransactions();
  }

  void _loadTransactions() {
    _transactions.assignAll([
      TransactionModel(
        title: 'Lawson Chair',
        date: DateTime(2024, 12, 15, 10, 0),
        amount: 120.0,
        type: TransactionType.order,
        icon: Assets.chair,
      ),
      TransactionModel(
        title: 'Top Up Wallet',
        date: DateTime(2024, 12, 14, 16, 42),
        amount: 400.0,
        type: TransactionType.topUp,
        icon: Assets.walletfilled,
      ),
      TransactionModel(
        title: 'Parabolic Reflector',
        date: DateTime(2024, 12, 14, 11, 39),
        amount: 170.0,
        type: TransactionType.order,
        icon: Assets.lamp,
      ),
      TransactionModel(
        title: 'Mini Wooden Table',
        date: DateTime(2024, 12, 13, 14, 46),
        amount: 165.0,
        type: TransactionType.order,
        icon: Assets.table,
      ),
      TransactionModel(
        title: 'Top Up Wallet',
        date: DateTime(2024, 12, 12, 9, 27),
        amount: 300.0,
        type: TransactionType.topUp,
        icon: Assets.walletfilled,
      ),
      TransactionModel(
        title: 'Office Desk',
        date: DateTime(2024, 12, 11, 14, 30),
        amount: 250.0,
        type: TransactionType.order,
        icon: Assets.table,
      ),
      TransactionModel(
        title: 'Top Up Wallet',
        date: DateTime(2024, 12, 10, 11, 15),
        amount: 200.0,
        type: TransactionType.topUp,
        icon: Assets.walletfilled,
      ),
      TransactionModel(
        title: 'Bookshelf',
        date: DateTime(2024, 12, 9, 16, 45),
        amount: 180.0,
        type: TransactionType.order,
        icon: Assets.chair,
      ),
      TransactionModel(
        title: 'Desk Lamp',
        date: DateTime(2024, 12, 8, 13, 20),
        amount: 75.0,
        type: TransactionType.order,
        icon: Assets.lamp,
      ),
      TransactionModel(
        title: 'Top Up Wallet',
        date: DateTime(2024, 12, 7, 10, 0),
        amount: 350.0,
        type: TransactionType.topUp,
        icon: Assets.walletfilled,
      ),
      TransactionModel(
        title: 'Gaming Chair',
        date: DateTime(2024, 12, 6, 15, 30),
        amount: 320.0,
        type: TransactionType.order,
        icon: Assets.chair,
      ),
      TransactionModel(
        title: 'Coffee Table',
        date: DateTime(2024, 12, 5, 12, 0),
        amount: 140.0,
        type: TransactionType.order,
        icon: Assets.table,
      ),
      TransactionModel(
        title: 'Top Up Wallet',
        date: DateTime(2024, 12, 4, 9, 45),
        amount: 180.0,
        type: TransactionType.topUp,
        icon: Assets.walletfilled,
      ),
      TransactionModel(
        title: 'Study Table',
        date: DateTime(2024, 12, 3, 14, 15),
        amount: 210.0,
        type: TransactionType.order,
        icon: Assets.table,
      ),
      TransactionModel(
        title: 'Bedside Lamp',
        date: DateTime(2024, 12, 2, 11, 30),
        amount: 65.0,
        type: TransactionType.order,
        icon: Assets.lamp,
      ),
    ]);
    
    // Sort by date (newest first)
    _transactions.sort((a, b) => b.date.compareTo(a.date));
  }

  // Search functionality
  void searchTransactions(String query) {
    _searchQuery.value = query;
    
    if (query.isEmpty) {
      _filteredTransactions.clear();
      return;
    }
    
    _filteredTransactions.assignAll(
      _transactions.where((transaction) => 
        transaction.title.toLowerCase().contains(query.toLowerCase()) ||
        transaction.typeString.toLowerCase().contains(query.toLowerCase()) ||
        transaction.formattedAmount.toLowerCase().contains(query.toLowerCase())
      ).toList()
    );
    
    update();
  }

  // Add new transaction
  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
    update();
  }

  // Clear search
  void clearSearch() {
    _searchQuery.value = '';
    _filteredTransactions.clear();
    update();
  }

  // Get total balance
  double get totalBalance {
    double balance = 0;
    for (var transaction in _transactions) {
      if (transaction.isTopUp) {
        balance += transaction.amount;
      } else {
        balance -= transaction.amount;
      }
    }
    return balance;
  }

  // Get recent transactions (last 5)
  List<TransactionModel> get recentTransactions => 
      _transactions.take(5).toList();
}

enum TransactionType {
  topUp,
  order,
}

class TransactionModel {
  final String title;
  final DateTime date;
  final double amount;
  final TransactionType type;
  final String icon;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.type,
    required this.icon,
  });

  bool get isTopUp => type == TransactionType.topUp;

  String get formattedDate => 
      '${_getMonthName(date.month)} ${date.day}, ${date.year} | ${_formatTime(date)}';

  String get formattedAmount => '\$${amount.toStringAsFixed(0)}';

  String get typeString => type == TransactionType.topUp ? 'Top Up' : 'Orders';

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final period = date.hour < 12 ? 'AM' : 'PM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          date == other.date &&
          amount == other.amount;

  @override
  int get hashCode => title.hashCode ^ date.hashCode ^ amount.hashCode;
}