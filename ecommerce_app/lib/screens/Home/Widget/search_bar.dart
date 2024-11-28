import 'package:ecommerce_app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';

class MySearchBAR extends StatefulWidget {
  final Function(String) onSearch;

  const MySearchBAR({super.key, required this.onSearch});

  @override
  State<MySearchBAR> createState() => _MySearchBARState();
}

class _MySearchBARState extends State<MySearchBAR> {
  @override
  Widget build(BuildContext context) {
    double padding = Responsive.isDesktop(context) ? 30.0 : 15.0;
    double height = Responsive.isMobile(context) ? 50.0 : 60.0;
    double fontSize = Responsive.isDesktop(context) ? 18.0 : 14.0;
    double iconSize = Responsive.isDesktop(context) ? 28.0 : 24.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: kcontentColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: widget.onSearch,
                style: TextStyle(fontSize: fontSize),
                decoration: const InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                // You can implement a search trigger action here if needed
              },
              icon: Icon(
                Icons.search,
                color: Colors.grey,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
