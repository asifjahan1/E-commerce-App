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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: kcontentColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.grey,
              size: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: widget.onSearch,
                decoration: const InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              height: 25,
              width: 1.5,
              color: Colors.grey,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.tune,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
