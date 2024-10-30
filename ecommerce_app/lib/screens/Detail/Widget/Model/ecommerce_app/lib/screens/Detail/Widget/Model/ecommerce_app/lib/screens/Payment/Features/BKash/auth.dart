import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

Future<void> storeAndRetrieveApiKey() async {
  // Write value
  await storage.write(key: "X-App-Key", value: "4f6o0cjiki2rfm34kfdadl1eqq");

  // Read value
  String? apiKey = await storage.read(key: "X-App-Key");

  // Use the apiKey as needed
  if (kDebugMode) {
    print("Stored API Key: $apiKey");
  }
}
