// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:ecommerce_app/Provider/favorite_provider.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/Detail/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  String currencySymbol = '৳'; // Default to BDT
  double? convertedPrice;
  bool isCurrencyLoading = true;

  @override
  void initState() {
    super.initState();
    _setCurrency();
  }

  Future<void> _setCurrency() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String currencyCode =
          getCurrencyCode(position.latitude, position.longitude);

      if (currencyCode == 'AED') {
        double rate = await getConversionRate('BDT', 'AED');
        convertedPrice = widget.product.priceBDT * rate;
      } else {
        convertedPrice = widget.product.priceBDT;
      }

      currencySymbol = currencyCode == 'BDT' ? '৳' : 'د.إ';
    } catch (e) {
      print("Error fetching currency: $e");
      convertedPrice = widget.product.priceBDT; // Fallback to default price
    } finally {
      setState(() {
        isCurrencyLoading = false;
      });
    }
  }

  String getCurrencyCode(double latitude, double longitude) {
    if (latitude >= 23.4 && latitude <= 26.4 && longitude >= 51.4 && longitude <= 56.4) {
      return "AED"; // Rough UAE coordinates
    } else {
      return "BDT";
    }
  }

  Future<double> getConversionRate(
      String fromCurrency, String toCurrency) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://v6.exchangerate-api.com/v6/YOUR_API_KEY/latest/$fromCurrency'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['conversion_rates'][toCurrency] ?? 1.0;
      } else {
        throw Exception('Failed to load conversion rates');
      }
    } catch (e) {
      print("Conversion rate error: $e");
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    double imageHeight = Responsive.isMobile(context)
        ? 150
        : Responsive.isTablet(context)
            ? 200
            : 250;

    double fontSize = Responsive.isMobile(context) ? 14 : 18;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: widget.product),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kcontentColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Center(
                  child: Hero(
                    tag: widget.product.image,
                    child: Image.asset(
                      widget.product.image,
                      width: imageHeight,
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: isCurrencyLoading
                            ? const CircularProgressIndicator(
                                color: Colors.grey,
                              )
                            : Text(
                                "$currencySymbol${convertedPrice?.toStringAsFixed(2) ?? "N/A"}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize,
                                ),
                              ),
                      ),
                      Row(
                        children: List.generate(
                          widget.product.colors.length,
                          (index) => Container(
                            width: 18,
                            height: 18,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              color: widget.product.colors[index],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    provider.toggleFavorite(widget.product);
                  },
                  child: Icon(
                    provider.isExist(widget.product)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
