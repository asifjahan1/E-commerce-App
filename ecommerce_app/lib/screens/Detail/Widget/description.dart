import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final String description;

  const Description({super.key, required this.description});

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  String selectedTab = "Description";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTabButton(
              title: "Description",
              isSelected: selectedTab == "Description",
              onPressed: () {
                setState(() {
                  selectedTab = "Description";
                });
              },
            ),
            _buildTabButton(
              title: "Specification",
              isSelected: selectedTab == "Specification",
              onPressed: () {
                setState(() {
                  selectedTab = "Specification";
                });
              },
            ),
            _buildTabButton(
              title: "Review",
              isSelected: selectedTab == "Review",
              onPressed: () {
                setState(() {
                  selectedTab = "Review";
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildTabContent(),
      ],
    );
  }

  // Widget to build each tab button
  Widget _buildTabButton(
      {required String title,
      required bool isSelected,
      required VoidCallback onPressed}) {
    return Flexible(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? kprimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "Specification":
        return const Text(
          "Here are the product specifications...",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        );
      case "Review":
        return const Text(
          "Here are the product reviews...",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        );
      default:
        return Text(
          widget.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        );
    }
  }
}
