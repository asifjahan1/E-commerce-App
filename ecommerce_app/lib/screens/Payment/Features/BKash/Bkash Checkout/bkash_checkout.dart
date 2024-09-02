// eita previous well worked code
import 'dart:convert';

import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/create_payment_response.dart';
// import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/execute_payment_response.dart';
import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/grant_token_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

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
  String? bKashURL;

  @override
  void initState() {
    super.initState();
    amountController.text = widget.totalAmount.toString();
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

  // // Execute Payment
  // Future<ExecutePaymentResponse> executePayment(
  //     String paymentID, String idToken) async {
  //   final response = await http.post(
  //     Uri.parse(
  //         "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/execute"),
  //     headers: {
  //       "Accept": "application/json",
  //       "Authorization": idToken,
  //       "X-App-Key": "4f6o0cjiki2rfm34kfdadl1eqq",
  //     },
  //     body: jsonEncode({
  //       "paymentID": paymentID,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     if (kDebugMode) {
  //       print("execute payment: ${response.body}");
  //     }
  //     return ExecutePaymentResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     Fluttertoast.showToast(msg: "Something went wrong: ${response.body}");
  //   }

  //   return ExecutePaymentResponse(
  //     paymentID: "paymentID",
  //     customerMsisdn: "customerMsisdn",
  //     payerReference: "01874392463",
  //     paymentExecuteTime: "paymentExecuteTime",
  //     trxID: "trxID",
  //     transactionStatus: "transactionStatus",
  //     amount: "amount",
  //     currency: "BDT",
  //     intent: "sale",
  //     merchantInvoiceNumber: "invoiceNumber",
  //     statusCode: response.statusCode.toString(),
  //     statusMessage: response.reasonPhrase ?? "Unknown error",
  //   );
  // }

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
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: const Color(0xffEE1284),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                        "Pay with Bkash",
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
              // // execute payment response
              // const SizedBox(height: 16),
              // MaterialButton(
              //   color: const Color(0xffEE1284),
              //   onPressed: () async {
              //     final grantTokenResponse = await grantToken();
              //     await executePayment(
              //       "paymentID",
              //       grantTokenResponse.idToken,
              //     ).then((executePaymentResponse) {
              //       Fluttertoast.showToast(
              //         msg: "Payment executed: ${executePaymentResponse.trxID}",
              //       );
              //     });
              //   },
              //   child: const Text(
              //     "Complete Payment",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ),
            ],
          ],
        ),
      ),
    );
  }
}
//
//
// for applying below this method it worked well also
// import 'dart:convert';
// import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/create_payment_response.dart';
// import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/grant_token_response.dart';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart'; // Add this import

// class BkashCheckout extends StatefulWidget {
//   const BkashCheckout({super.key, required this.totalAmount});
//   final double totalAmount;

//   @override
//   State<BkashCheckout> createState() => _BkashCheckoutState();
// }

// class _BkashCheckoutState extends State<BkashCheckout> {
//   bool loading = false;
//   TextEditingController amountController = TextEditingController();
//   TextEditingController invoiceNumberController = TextEditingController();
//   String? bKashURL; // Add this state variable

//   @override
//   void initState() {
//     super.initState();
//     amountController.text =
//         widget.totalAmount.toString(); // Initialize the amount
//   }

//   // Grant token
//   Future<GrantTokenResponse> grantToken() async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//             "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/token/grant"),
//         headers: {
//           "Content-Type": "application/json",
//           "Accept": "application/json",
//           "username": "sandboxTokenizedUser02",
//           "password": "sandboxTokenizedUser02@12345"
//         },
//         body: jsonEncode({
//           "app_key": "4f6o0cjiki2rfm34kfdadl1eqq",
//           "app_secret": "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseJson = jsonDecode(response.body);
//         return GrantTokenResponse.fromJson(responseJson);
//       } else {
//         Fluttertoast.showToast(msg: "Token grant failed: ${response.body}");
//         throw Exception('Failed to grant token');
//       }
//     } catch (e) {
//       print("Error granting token: $e");
//       rethrow;
//     }
//   }

// // Create payment
//   Future<CreatePaymentResponse> createPayment({
//     required String idToken,
//     required String amount,
//     required String invoiceNumber,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(
//             "https://tokenized.sandbox.bka.sh/v1.2.0-beta/tokenized/checkout/create"),
//         headers: {
//           "Content-Type": "application/json",
//           "Accept": "application/json",
//           "Authorization": idToken,
//           "X-App-Key": "4f6o0cjiki2rfm34kfdadl1eqq",
//         },
//         body: jsonEncode({
//           "mode": "0011",
//           "payerReference": "01874392463",
//           "callbackURL": "https://tcean.store",
//           // "callbackURL": "https://asifjahan1.github.io/",
//           "amount": amount,
//           "currency": "BDT",
//           "intent": "sale",
//           "merchantInvoiceNumber": invoiceNumber
//         }),
//       );

//       if (response.statusCode == 200) {
//         print("create payment: ${response.body}");
//         return CreatePaymentResponse.fromJson(response.body);
//       } else {
//         Fluttertoast.showToast(
//             msg: "Payment creation failed: ${response.body}");
//         throw Exception('Failed to create payment');
//       }
//     } catch (e) {
//       print("Error creating payment: $e");
//       rethrow;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           style: IconButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             padding: const EdgeInsets.all(15),
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: const Text("Checkout"),
//         centerTitle: true,
//         backgroundColor: const Color(0xffEE1284),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             if (bKashURL == null) ...[
//               TextField(
//                 readOnly: true,
//                 controller: amountController,
//                 decoration: InputDecoration(
//                   hintText: "Amount",
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Color(0xffEE1284),
//                       width: 1.5,
//                     ),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 controller: invoiceNumberController,
//                 decoration: InputDecoration(
//                   hintText: "Invoice Number",
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       color: Color(0xffEE1284),
//                       width: 1.5,
//                     ),
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               MaterialButton(
//                 color: const Color(0xffEE1284),
//                 onPressed: () async {
//                   setState(() {
//                     loading = true;
//                   });
//                   await grantToken().then((grantTokenResponse) async {
//                     await createPayment(
//                       idToken: grantTokenResponse.idToken,
//                       amount: amountController.text,
//                       invoiceNumber: invoiceNumberController.text,
//                     ).then((createPaymentResponse) {
//                       setState(() {
//                         loading = false;
//                         bKashURL = createPaymentResponse.bkashURL;
//                       });
//                     });
//                   });
//                 },
//                 child: loading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text(
//                         "Pay with Bkash",
//                         style: TextStyle(color: Colors.white),
//                       ),
//               ),
//             ] else ...[
//               Expanded(
//                 child: WebViewWidget(
//                   controller: WebViewController()
//                     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                     ..loadRequest(
//                       Uri.parse(bKashURL!),
//                     ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }