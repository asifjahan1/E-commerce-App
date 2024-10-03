// ignore_for_file: avoid_print, library_private_types_in_public_api, use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ecommerce_app/Provider/add_to_cart_provider.dart';
import 'package:ecommerce_app/Provider/favorite_provider.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/Payment/Features/BKash/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'screens/nav_bar_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // store secret api keys
  await storeAndRetrieveApiKey();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          home: const SplashScreen(),
        ),
      );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const BottomNavBar(initialIndex: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'images/Noor Al-Sana.jpg',
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 150),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    RotateAnimatedText(
                      'Commitment is',
                      textStyle: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                      duration: const Duration(milliseconds: 2000),
                    ),
                    RotateAnimatedText(
                      'Our excellence',
                      textStyle: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                      duration: const Duration(milliseconds: 2000),
                    ),
                  ],
                  pause: const Duration(milliseconds: 500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// 
// Testing

// import 'dart:convert';
// import 'package:http/http.dart' as https;
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as https;
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Stripe.publishableKey =
//       'pk_test_51Pb4xjAPX9zikVxBWkYKnHEj3Rpzu1kYw0tFuVgc1G7ombMJVTkNUA2Sd9iHjjfcHxa9SBMBtAkmR1nysPpnjvMM00YdMUGBpG';
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         textTheme: GoogleFonts.mulishTextTheme(),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Map<String, dynamic>? paymentIntent;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stripe Account'),
//       ),
//       body: Center(
//         child: TextButton(
//           onPressed: () async {
//             await makePayment();
//           },
//           child: const Text('Make Payment'),
//         ),
//       ),
//     );
//   }

//   Future<void> makePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('10', 'USD');
//       await Stripe.instance
//           .initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret: paymentIntent!['client_secret'],
//               googlePay: const PaymentSheetGooglePay(
//                 testEnv: true,
//                 currencyCode: 'USD',
//                 merchantCountryCode: 'US',
//               ),
//               style: ThemeMode.dark,
//               merchantDisplayName: 'Adnan',
//             ),
//           )
//           .then((value) {});

//       await displayPaymentSheet();
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }

//   Future<void> displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) {
//         showDialog(
//           context: context,
//           builder: (_) => const AlertDialog(
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                     ),
//                     Text("Payment Successful"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//         paymentIntent = null;
//       }).onError((error, stackTrace) {
//         print('Error is:--->$error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Error is:---> $e');
//       showDialog(
//         context: context,
//         builder: (_) => const AlertDialog(
//           content: Text("Cancelled"),
//         ),
//       );
//     }
//   }

//   Future<Map<String, dynamic>?> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card', // এখানে পরিবর্তন করা হয়েছে
//       };

//       var response = await https.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//               'Bearer sk_test_51Pb4xjAPX9zikVxBegXLWkmf83Koxg2yMNskOkBMWabj1sjETtIojtrOKXuwM8d0KmMg2H7BSkQM27LJEya3k44s00yCpHwFt0',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       print('payment Intent Body->> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//       return null;
//     }
//   }

//   String calculateAmount(String amount) {
//     final calculateAmount = (int.parse(amount)) * 100;
//     return calculateAmount.toString();
//   }
// }
