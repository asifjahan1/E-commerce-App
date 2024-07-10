import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/Provider/favorite_provider.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/Cart/cart_screen.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class DetailAppBar extends StatelessWidget {
  final Product product;
  final Function(int) updateCartCount;

  const DetailAppBar({
    super.key,
    required this.product,
    required this.updateCartCount,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = FavoriteProvider.of(context);
    final cartProvider = CartProvider.of(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.pop(context);
              // Update BottomNavBar index after navigating back
              final bottomNavBarState = BottomNavBar.of(context);
              if (bottomNavBarState != null) {
                bottomNavBarState.updateIndex(3);
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            iconSize: 24.0,
          ),
          const Spacer(),
          Stack(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {
                  // Update BottomNavBar index and navigate to CartScreen
                  BottomNavBar.of(context)?.updateIndex(3);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: badges.Badge(
                  badgeAnimation: const badges.BadgeAnimation.scale(
                    animationDuration: Duration(seconds: 1),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.fastOutSlowIn,
                    colorChangeAnimationCurve: Curves.easeInCubic,
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red,
                    padding: const EdgeInsets.all(5),
                    shape: badges.BadgeShape.circle,
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  position: badges.BadgePosition.topEnd(top: -8, end: -8),
                  badgeContent: Text(
                    '${cartProvider.cart.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  showBadge: cartProvider.cart.isNotEmpty,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(15),
            ),
            onPressed: () {
              favoriteProvider.toggleFavorite(product);
            },
            icon: favoriteProvider.isExist(product)
                ? const Icon(Icons.favorite, color: kprimaryColor)
                : const Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
