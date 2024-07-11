import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/Provider/favorite_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'screens/nav_bar_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51Pb4xjAPX9zikVxBWkYKnHEj3Rpzu1kYw0tFuVgc1G7ombMJVTkNUA2Sd9iHjjfcHxa9SBMBtAkmR1nysPpnjvMM00YdMUGBpG';
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          // for add to cart
          ChangeNotifierProvider(create: (_) => CartProvider()),
          // for favorite
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.mulishTextTheme(),
          ),
          home: const BottomNavBar(initialIndex: 2),
        ),
      );
}
