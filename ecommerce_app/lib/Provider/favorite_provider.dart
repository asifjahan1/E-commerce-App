import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  // Get the list of favorite products
  List<Product> get favorites => _favorites;

  // Toggle favorite status for a product
  void toggleFavorite(Product product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product); // Remove if already in favorites
    } else {
      _favorites.add(product); // Add to favorites
    }
    notifyListeners(); // Notify listeners of changes
  }

  // Check if a product is in the favorites list
  bool isExist(Product product) {
    return _favorites.contains(product);
  }

  // Static method to get the provider instance
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
