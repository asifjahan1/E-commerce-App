import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart';

class CustomAppBar extends StatefulWidget {
  final VoidCallback onAvatarTap;

  const CustomAppBar({super.key, required this.onAvatarTap});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: kcontentColor,
            padding: const EdgeInsets.all(15),
          ),
          onPressed: () {},
          icon: Image.asset(
            "images/icon.png",
            height: 20,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: kcontentColor,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(
                Icons.notifications_outlined,
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: widget.onAvatarTap,
              child: const Hero(
                tag: 'avatarHero', // Unique tag for the Hero widget
                child: CircleAvatar(
                  backgroundColor: Color(0xffF5F5F5),
                  radius: 25,
                  backgroundImage: AssetImage("images/profile3.png"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
