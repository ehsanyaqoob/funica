import 'dart:convert';
import 'package:funica/app-state/app-state.dart';
import 'package:funica/constants/export.dart';
import 'package:funica/models/product-model.dart';

class FavouritesController extends BaseController {
  final RxList<ProductModel> _favourites = <ProductModel>[].obs;
  final SharedPreferences _prefs = Get.find<SharedPreferences>();

  static const String _favouritesKey = 'favourites_data';

  List<ProductModel> get favourites => _favourites.toList();

  @override
  void onInit() {
    super.onInit();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    await runAsyncOperation(() async {
      final favouritesData = _prefs.getString(_favouritesKey);
      if (favouritesData != null && favouritesData.isNotEmpty) {
        final List<dynamic> decoded = json.decode(favouritesData);
        _favourites.assignAll(
          decoded.map((item) => ProductModel.fromJson(item)).toList(),
        );
      }
    });
  }

  Future<void> persistFavourites() async {
    try {
      final favouritesJson = json.encode(
        _favourites.map((e) => e.toJson()).toList(),
      );
      await _prefs.setString(_favouritesKey, favouritesJson);
      debugPrint('✅ Favourites persisted successfully');
    } catch (e) {
      debugPrint('❌ Error persisting favourites: $e');
    }
  }

  void toggleFavourite(ProductModel product, bool isLiked) {
    if (isLiked) {
      _favourites.add(product);
    } else {
      _favourites.removeWhere((item) => item.title == product.title);
    }
    // Auto-save when favourites change
    persistFavourites();
  }

  bool isFavourite(ProductModel product) {
    return _favourites.any((item) => item.title == product.title);
  }

  // App lifecycle methods
  void onAppResumed() {
    debugPrint('🔄 FavouritesController: App resumed');
    // Refresh data if needed
    _loadFavourites();
  }

  void onAppInactive() {
    debugPrint('⏸️ FavouritesController: App inactive');
    // Quick save
    persistFavourites();
  }

  void onAppPaused() {
    debugPrint('🚫 FavouritesController: App paused');
    // Ensure data is persisted
    persistFavourites();
  }

  void onAppDetached() {
    debugPrint('💀 FavouritesController: App detached');
    // Final persistence
    persistFavourites();
  }
}
