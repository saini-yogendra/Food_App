import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider = ChangeNotifierProvider<FavoriteProvider>(
  (ref) => FavoriteProvider(),
);

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteIds = [];
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  List<String> get favorite => _favoriteIds;
  String? get userId => _supabaseClient.auth.currentUser?.id;
  FavoriteProvider() {
    // load the favorite provider
    loadFavorites();
  }
  void reset() {
    _favoriteIds = [];
    notifyListeners();
  }

  // toggle favorite state
  Future<void> toggleFavorite(String productId) async {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      // remove favorite
      await _removeFavorite(productId);
    } else {
      _favoriteIds.add(productId);
      // add favorite
      await _addFavorite(productId);
    }
    notifyListeners();
  }

  // check if product is fav.
  bool isExist(String productId) {
    return _favoriteIds.contains(productId);
  }

  // add fav. to supabase
  Future<void> _addFavorite(String productId) async {
    if (userId == null) return;
    try {
      await _supabaseClient.from("favorites").insert({
        "user_id": userId,
        "product_id": productId,
      });
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  // remove fav. from supabase
  Future<void> _removeFavorite(String productId) async {
    if (userId == null) return;
    try {
      await _supabaseClient.from("favorites").delete().match({
        "user_id": userId!,
        "product_id": productId,
      });
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  // load fav. from supabase
  Future<void> loadFavorites() async {
    if (userId == null) return;
    try {
      final data = await _supabaseClient
          .from("favorites")
          .select("product_id")
          .eq("user_id", userId!);
      _favoriteIds =
          data.map<String>((row) => row['product_id'] as String).toList();
    } catch (e) {
      print("Error loading favorite $e");
    }
    notifyListeners();
  }
}