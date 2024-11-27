import 'dart:convert';
import 'dart:math';
import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/Payment/Features/BKash/Models/create_payment_response.dart';
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
    // Generate and set the invoice number
    invoiceNumberController.text = generateInvoiceNumber();
  }

  // Function to generate the invoice number in the format (T789XWYZ)
  String generateInvoiceNumber() {
    const String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    Random random = Random();

    // Generate random 2-character prefix
    String prefix = String.fromCharCodes(
      Iterable.generate(
        2,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );

    // Generate random 2-character suffix
    String suffix = String.fromCharCodes(
      Iterable.generate(
        2,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
      ),
    );

    // Generate a random 3-digit number
    String randomDigits = (100 + random.nextInt(900)).toString();

    return "$prefix$randomDigits$suffix";
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
            "callbackURL": "https://tcean.store",
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
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: const Color(0xffEE1284),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 40 : 16,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            if (bKashURL == null) ...[
              SizedBox(
                width: Responsive.isDesktop(context) ? 500 : double.infinity,
                child: TextField(
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
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: Responsive.isDesktop(context) ? 500 : double.infinity,
                child: TextField(
                  controller: invoiceNumberController,
                  readOnly: true,
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
            ],
          ],
        ),
      ),
    );
  }
}
