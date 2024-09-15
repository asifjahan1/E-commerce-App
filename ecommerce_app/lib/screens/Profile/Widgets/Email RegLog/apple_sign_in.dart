import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  Future<User?> signInWithApple(
      {List<AppleIDAuthorizationScopes> scopes = const []}) async {
    try {
      // Request Apple sign-in credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: scopes,
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId:
              'de.lunaone.flutter.signinwithappleexample.service', // example client_id
          redirectUri: Uri.parse(
              'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple'), // example redirect_url
        ),
      );

      // Create an OAuth credential for Firebase
      final oAuthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(oAuthCredential);
      final User? firebaseUser = userCredential.user;

      if (scopes.contains(AppleIDAuthorizationScopes.fullName)) {
        final fullName = appleCredential.givenName != null &&
                appleCredential.familyName != null
            ? '${appleCredential.givenName} ${appleCredential.familyName}'
            : null;

        if (fullName != null && firebaseUser != null) {
          await firebaseUser.updateDisplayName(fullName);
        }
      }

      return firebaseUser;
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_ABORTED_BY_USER') {
        throw Exception('Sign in aborted by user');
      } else {
        // throw Exception('Sign in failed: ${e.message}');
        throw Exception('Sign in failed');
      }
    } catch (e) {
      // Handle general errors
      throw Exception('Sign in failed: $e');
    }
  }
}

// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthMethods {
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   Future<User?> signInWithApple(
//       {List<AppleIDAuthorizationScopes> scopes = const [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName
//       ]}) async {
//     try {
//       // Request credentials
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: scopes,
//       );

//       // Create an OAuth credential
//       final oAuthCredential = OAuthProvider('apple.com').credential(
//         idToken: appleCredential.identityToken,
//         accessToken: appleCredential.authorizationCode,
//       );

//       // Sign in with Firebase using the Apple credential
//       final UserCredential userCredential =
//           await auth.signInWithCredential(oAuthCredential);
//       final User? firebaseUser = userCredential.user;

//       // Optionally, update the user's display name
//       if (scopes.contains(AppleIDAuthorizationScopes.fullName) &&
//           appleCredential.givenName != null &&
//           appleCredential.familyName != null) {
//         final displayName =
//             '${appleCredential.givenName} ${appleCredential.familyName}';
//         await firebaseUser?.updateDisplayName(displayName);
//       }

//       return firebaseUser;
//     } catch (e) {
//       print('Error during Apple sign-in: $e');
//       throw Exception('Failed to sign in with Apple: $e');
//     }
//   }
// }
