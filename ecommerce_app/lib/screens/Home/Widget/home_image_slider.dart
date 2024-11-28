// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:ecommerce_app/responsive.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final Function(int) onChange;
  final int currentSlide;

  const ImageSlider({
    super.key,
    required this.currentSlide,
    required this.onChange,
  });

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentSlide = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentSlide + 1) % 3; // Assuming 3 images
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        setState(() {
          _currentSlide = nextPage;
        });
        widget.onChange(_currentSlide);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = Responsive.isMobile(context)
        ? 220
        : Responsive.isTablet(context)
            ? 300
            : 400;
    double indicatorWidth = Responsive.isMobile(context) ? 15 : 20;
    double indicatorHeight = Responsive.isMobile(context) ? 8 : 10;
    double indicatorMargin = Responsive.isMobile(context) ? 3 : 5;

    return Stack(
      children: [
        SizedBox(
          height: imageHeight,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Responsive.isMobile(context) ? 15 : 25),
            child: PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _currentSlide = index;
                });
                widget.onChange(index);
              },
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "images/slider.jpg",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/image1.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "images/slider3.png",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: Responsive.isMobile(context) ? 10 : 15,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Assuming 3 images
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentSlide == index ? indicatorWidth : indicatorWidth / 2,
                  height: indicatorHeight,
                  margin: EdgeInsets.only(right: indicatorMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _currentSlide == index
                        ? const Color(0xffff660e)
                        : Colors.transparent,
                    border: Border.all(color: const Color(0xffff660e)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
