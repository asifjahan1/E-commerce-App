// // import 'package:ecommerce_app/screens/Profile/Widgets/Email%20RegLog/google_signin_service.dart';
// import 'package:ecommerce_app/screens/Profile/Widgets/Email%20RegLog/home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleLoginButton extends StatefulWidget {
//   const GoogleLoginButton({super.key});

//   @override
//   State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
// }

// class _GoogleLoginButtonState extends State<GoogleLoginButton> {
//   login() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     await FirebaseAuth.instance.signInWithCredential(credential);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       // onPressed: () => GoogleSignInService().signInWithGoogle(context),
//       onPressed: () => const Home(),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         textStyle: const TextStyle(fontSize: 16, color: Colors.white),
//       ),
//       child: const Text("Login with Google"),
//     );
//   }
// }
