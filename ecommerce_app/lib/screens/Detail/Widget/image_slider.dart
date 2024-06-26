import 'package:flutter/material.dart';

class MyImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final String image;
  final PageController pageController;

  const MyImageSlider({
    super.key,
    required this.image,
    required this.onChange,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onChange,
        itemCount: 5, // Ensure only one image is displayed
        itemBuilder: (context, index) {
          return Hero(
            tag: image,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}
