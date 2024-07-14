// import 'package:flutter/material.dart';

// class Profile extends StatelessWidget {
//   const Profile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             "images/profile3.png",
//             fit: BoxFit.cover,
//             height: size.height,
//             width: size.width,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 20),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Container(
//                   height: size.height * 0.4,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
//                   child: ListView(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Stack(
//                                   children: [
//                                     const Hero(
//                                       tag: 'avatarHero',
//                                       child: CircleAvatar(
//                                         radius: 42,
//                                         backgroundImage:
//                                             AssetImage("images/profile3.png"),
//                                       ),
//                                     ),
//                                     Positioned(
//                                       bottom: 0,
//                                       right: 0,
//                                       child: Container(
//                                         height: 25,
//                                         width: 25,
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color:
//                                               Color.fromARGB(255, 95, 225, 99),
//                                         ),
//                                         child: const Icon(
//                                           Icons.check,
//                                           color: Colors.white,
//                                           size: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         border:
//                                             Border.all(color: Colors.black54),
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 9, horizontal: 12),
//                                       child: const Text(
//                                         "ADD FRIEND",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         color: Colors.pink,
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           vertical: 8, horizontal: 12),
//                                       child: const Text(
//                                         "Follow",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 16,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             const Text(
//                               "Winnie Vasquez",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 35,
//                               ),
//                             ),
//                             const Text(
//                               "Flutter Developer",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: 16,
//                                 color: Colors.black45,
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             const Text(
//                               "A Flutter developer is a software engineer who has proficiency with the Flutter framework to develop mobile, web,",
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Divider(
//                         color: Colors.black12,
//                       ),
//                       SizedBox(
//                         height: 65,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             friendAndMore("FRIENDS", "2318"),
//                             friendAndMore("FOLLOWING", "364"),
//                             friendAndMore("FOLLOWER", "175"),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   SizedBox friendAndMore(String title, String number) {
//     return SizedBox(
//       width: 110,
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//               color: Colors.black26,
//             ),
//           ),
//           Text(
//             number,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 25,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kprimaryColor,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle settings button press
                      },
                      icon: const Icon(Icons.settings),
                      color: kprimaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    // Handle login/sign up button press
                  },
                  color: kprimaryColor,
                  textColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Login / SignUp',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
