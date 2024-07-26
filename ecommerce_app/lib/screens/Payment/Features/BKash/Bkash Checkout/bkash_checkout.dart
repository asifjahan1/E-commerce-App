// import 'dart:convert';

// import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/create_payment_response.dart';
// import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/grant_token_response.dart';
// import 'package:ecommerce_app/screens/Payment/Features/BKash/Route/route_name.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/http.dart' as http;

// class BkashCheckout extends StatefulWidget {
//   const BkashCheckout({super.key, required double totalAmount});

//   @override
//   State<BkashCheckout> createState() => _BkashCheckoutState();
// }

// class _BkashCheckoutState extends State<BkashCheckout> {
//   bool loading = false;
//   TextEditingController amountController = TextEditingController();
//   TextEditingController invoiceNumberController = TextEditingController();

//   // Grant token
//   Future<GrantTokenResponse> grantToken() async {
//     final response = await http.post(
//       Uri.parse(
//           "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/token/grant"),
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//         "username": "sandboxTokenizedUser02",
//         "password": "sandboxTokenizedUser02@12345"
//       },
//       body: Uint8List.fromList(
//         utf8.encode(
//           jsonEncode(
//             {
//               "app_key": "4f6o0cjiki2rfm34kfdadl1eqq",
//               "app_secret":
//                   "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
//             },
//           ),
//         ),
//       ),
//     );

//     if (response.statusCode == 200) {
//       return GrantTokenResponse.fromJson(response.body);
//     } else {
//       Fluttertoast.showToast(msg: "Something went wrong");
//     }
//     return GrantTokenResponse(
//       statusCode: "statusCode",
//       statusMessage: "statusMessage",
//       idToken: "idToken",
//       tokenType: "tokenType",
//       expiresIn: 123,
//       refreshToken: "refreshToken",
//     );
//   }

//   // Create payment
//   Future<CreatePaymentResponse> createPayment({
//     required String idToken,
//     required String amount,
//     required String invoiceNumber,
//   }) async {
//     final response = await http.post(
//       Uri.parse(
//           "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/create"),
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//         "Authorization": idToken,
//         "X-App-Key": "4f6o0cjiki2rfm34kfdadl1eqq",
//       },
//       body: Uint8List.fromList(
//         utf8.encode(
//           jsonEncode(
//             {
//               "mode": "0011",
//               "payerReference": "01874392463",
//               "callbackURL":
//                   "https://tcean.store", // eidike amader website er url dite hobe
//               "amount": amount,
//               "currency": "BDT",
//               "intent": "sale",
//               "merchantInvoiceNumber": invoiceNumber
//             },
//           ),
//         ),
//       ),
//     );

//     if (response.statusCode == 200) {
//       if (kDebugMode) {
//         print("create payment: ${response.body}");
//       }
//       return CreatePaymentResponse.fromJson(response.body);
//     } else {
//       Fluttertoast.showToast(msg: "Something went wrong");
//     }

//     return CreatePaymentResponse(
//       paymentID: "paymentID",
//       paymentCreateTime: "paymentCreateTime",
//       transactionStatus: "transactionStatus",
//       amount: "amount",
//       currency: "currency",
//       intent: "intent",
//       merchantInvoiceNumber: "merchantInvoiceNumber",
//       bkashURL: "bkashURL",
//       callbackURL: "callbackURL",
//       successCallbackURL: "successCallbackURL",
//       failureCallbackURL: "failureCallbackURL",
//       cancelledCallbackURL: "cancelledCallbackURL",
//       statusCode: "statusCode",
//       statusMessage: "statusMessage",
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color(0xffF5F5F5),
//       // body: SafeArea(
//       //   child: Column(
//       //     children: [
//       //       Padding(
//       //         padding: const EdgeInsets.all(8),
//       //         child: Row(
//       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //           children: [
//       //             IconButton(
//       //               style: IconButton.styleFrom(
//       //                 backgroundColor: Colors.white,
//       //                 padding: const EdgeInsets.all(15),
//       //               ),
//       //               onPressed: () {
//       //                 Navigator.of(context).pop();
//       //               },
//       //               icon: const Icon(
//       //                 Icons.arrow_back_ios,
//       //               ),
//       //             ),
//       //             const Text(
//       //               "Pay with Bkash",
//       //               style: TextStyle(
//       //                 fontWeight: FontWeight.bold,
//       //                 fontSize: 25,
//       //               ),
//       //             ),
//       //             const SizedBox(),
//       //           ],
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),

//       // eidik theke start
//       appBar: AppBar(
//         leading: IconButton(
//           style: IconButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             padding: const EdgeInsets.all(15),
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios,
//           ),
//         ),
//         title: const Text("Checkout"),
//         centerTitle: true,
//         backgroundColor: const Color(0xffEE1284),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: amountController,
//                   decoration: InputDecoration(
//                     hintText: "Amount",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Color(0xffEE1284),
//                         width: 1.5,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 TextField(
//                   controller: invoiceNumberController,
//                   decoration: InputDecoration(
//                     hintText: "Invoice Number",
//                     border: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Color(0xffEE1284),
//                         width: 1.5,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 16,
//                 ),
//                 FilledButton(
//                   onPressed: () async {
//                     setState(() {
//                       loading = true;
//                     });
//                     await grantToken().then((grantTokenResponse) async {
//                       await createPayment(
//                         idToken: grantTokenResponse.idToken,
//                         amount: amountController.text,
//                         invoiceNumber: invoiceNumberController.text,
//                       ).then((createPaymentResponse) {
//                         setState(() {
//                           loading = false;
//                         });
//                         context.pushNamed(RouteName.paymentScreen,
//                             extra: createPaymentResponse.bkashURL);
//                       });
//                     });
//                   },
//                   child: loading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text("Pay with Bkash"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// for applying below this method it worked well
import 'dart:convert';

import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/create_payment_response.dart';
import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/grant_token_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart'; // Add this import

class BkashCheckout extends StatefulWidget {
  const BkashCheckout({super.key, required this.totalAmount});
  final double totalAmount;

  @override
  State<BkashCheckout> createState() => _BkashCheckoutState();
}

class _BkashCheckoutState extends State<BkashCheckout> {
  bool loading = false;
  TextEditingController amountController = TextEditingController();
  TextEditingController invoiceNumberController = TextEditingController();
  String? bKashURL; // Add this state variable

  @override
  void initState() {
    super.initState();
    amountController.text =
        widget.totalAmount.toString(); // Initialize the amount
  }

  // Grant token
  Future<GrantTokenResponse> grantToken() async {
    final response = await http.post(
      Uri.parse(
          "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/token/grant"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "username": "sandboxTokenizedUser02",
        "password": "sandboxTokenizedUser02@12345"
      },
      body: Uint8List.fromList(
        utf8.encode(
          jsonEncode({
            "app_key": "4f6o0cjiki2rfm34kfdadl1eqq",
            "app_secret": "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
          }),
        ),
      ),
    );

    if (response.statusCode == 200) {
      return GrantTokenResponse.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    return GrantTokenResponse(
      statusCode: "statusCode",
      statusMessage: "statusMessage",
      idToken: "idToken",
      tokenType: "tokenType",
      expiresIn: 123,
      refreshToken: "refreshToken",
    );
  }

  // Create payment
  Future<CreatePaymentResponse> createPayment({
    required String idToken,
    required String amount,
    required String invoiceNumber,
  }) async {
    final response = await http.post(
      Uri.parse(
          "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/create"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": idToken,
        "X-App-Key": "4f6o0cjiki2rfm34kfdadl1eqq",
      },
      body: Uint8List.fromList(
        utf8.encode(
          jsonEncode({
            "mode": "0011",
            "payerReference": "01874392463",
            "callbackURL":
                "https://tcean.store", // eidike amader website er url dite hobe
            "amount": amount,
            "currency": "BDT",
            "intent": "sale",
            "merchantInvoiceNumber": invoiceNumber
          }),
        ),
      ),
    );

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("create payment: ${response.body}");
      }
      return CreatePaymentResponse.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }

    return CreatePaymentResponse(
      paymentID: "paymentID",
      paymentCreateTime: "paymentCreateTime",
      transactionStatus: "transactionStatus",
      amount: "amount",
      currency: "currency",
      intent: "intent",
      merchantInvoiceNumber: "merchantInvoiceNumber",
      bkashURL: "bkashURL",
      callbackURL: "callbackURL",
      successCallbackURL: "successCallbackURL",
      failureCallbackURL: "failureCallbackURL",
      cancelledCallbackURL: "cancelledCallbackURL",
      statusCode: "statusCode",
      statusMessage: "statusMessage",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Pay with Bkash"),
        centerTitle: true,
        backgroundColor: const Color(0xffEE1284),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                if (bKashURL == null) ...[
                  TextField(
                    readOnly: true,
                    controller: amountController,
                    decoration: InputDecoration(
                      hintText: "Amount",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffEE1284),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: invoiceNumberController,
                    decoration: InputDecoration(
                      hintText: "Invoice Number",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffEE1284),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  MaterialButton(
                    // padding: const EdgeInsets.only(
                    //   top: 10,
                    //   bottom: 10,
                    //   left: 10,
                    //   right: 10,
                    // ),
                    color: const Color(0xffEE1284),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      await grantToken().then((grantTokenResponse) async {
                        await createPayment(
                          idToken: grantTokenResponse.idToken,
                          amount: amountController.text,
                          invoiceNumber: invoiceNumberController.text,
                        ).then((createPaymentResponse) {
                          setState(() {
                            loading = false;
                            bKashURL = createPaymentResponse.bkashURL;
                          });
                        });
                      });
                    },
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Checkout",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ] else ...[
                  Expanded(
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(
                          Uri.parse(bKashURL!),
                        ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
