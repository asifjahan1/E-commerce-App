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
              title: "Terms & Conditions",
              isSelected: selectedTab == "Terms & Conditions",
              onPressed: () {
                setState(() {
                  selectedTab = "Terms & Conditions";
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
      case "Terms & Conditions":
        return const Text(
          "Dear Customer, we try our best from our end to provide you the best customer experience.\n\n"
          "The delivery of your order is subjected to availability of stock.\n\n"
          "Check and receive your product in front of the delivery man. If your product is damaged, defective, incorrect or has any mismatch in size or pricing issue at the time of delivery, please return it immediately to the delivery person.\n\n"
          "For any assistance, you can call our customer service at 01874392463. (9.00am to 9.00pm except Govt. holidays) But in case if you couldn't reach the customer service, you can provide your issue details after selecting the proper issue section in our Report Issue Section.\n\n"
          "Ordering Policy\n"
          "Service is only available for articles (products) which are shown in stock on our website. "
          "The delivery of your order is subjected to availability of stock. Only one product should be booked in one order, in case of any customer needs to order multiple products or the same products in multiple quantities, customers will need to place multiple separate orders. "
          "Currently, each order will be shipped only to a single destination address. If customers wish to ship products to different addresses, customers will need to place multiple separate orders. Orders that are paid for cannot be cancelled. "
          "For Order-related queries, please kindly contact our Customer Service at 01874392463. (9.00am to 9.00pm except Govt. holidays).\n\n"
          "Shipping Policy\n"
          "We are committed to delivering your order accurately, in good condition, and on time. While we will endeavor to ship all items in your order together, this may not always be possible due to product characteristics or stock availability.\n\n"
          "Shipping Details:\n"
          "We make our best efforts to ship each item in your order within 3 to 5 working days inside Dhaka metropolitan city and 7 to 10 working days outside Dhaka.\n"
          "We ship on regular weekdays (Sunday to Thursday), excluding public holidays.\n"
          "Currently, each order will be shipped only to a single destination address. If customers wish to ship products to different addresses, they will need to place multiple separate orders.\n"
          "While we endeavor to ship all items in your order accurately, in good condition, and on time, your order may get canceled or delivery may be delayed due to size unavailability, product unavailability, or courier issues.\n"
          "To ensure that your order reaches you in the fastest time and in good condition, we only ship through reputed courier agencies.\n",
          style: TextStyle(
            fontSize: 18,
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
