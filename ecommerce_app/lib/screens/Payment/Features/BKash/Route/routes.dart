import 'package:ecommerce_app/screens/Payment/Features/BKash/Bkash%20Checkout/bkash_checkout.dart';
import 'package:ecommerce_app/screens/Payment/Features/BKash/Bkash%20Checkout/bkash_payment_screen.dart';
import 'package:ecommerce_app/screens/Payment/Features/BKash/Route/route_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<RouteBase> routes = [
  GoRoute(
    path: "/",
    name: RouteName.bkashCheckout,
    pageBuilder: (context, state) {
      final totalAmount =
          state.extra as double; // Retrieve the totalAmount from state.extra
      return MaterialPage(
        child: BkashCheckout(totalAmount: totalAmount),
      );
    },
  ),
  GoRoute(
    path: "/payment",
    name: RouteName.paymentScreen,
    pageBuilder: (context, state) => MaterialPage(
      child: PaymentScreen(
        bKashURL: state.extra as String,
      ),
    ),
  ),
];
