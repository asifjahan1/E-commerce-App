import 'package:ecommerce_app/responsive.dart';
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
    required double height,
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
          // nicher ei code dile kono multiple hero kno use korechi tar error ashe na but Hero transition hoy na
          // return Hero(
          //   tag: '${image}_$index',
          //   child: Image.asset(
          //     image,
          //     fit: BoxFit.contain,
          //   ),
          // );

          return Responsive(
            mobile: Hero(
              tag: image,
              // tag: 'image_${widget.product.id}',
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            tablet: Hero(
              tag: image,
              // tag: 'image_${widget.product.id}',
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            desktop: Hero(
              tag: image,
              // tag: 'image_${widget.product.id}',
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
