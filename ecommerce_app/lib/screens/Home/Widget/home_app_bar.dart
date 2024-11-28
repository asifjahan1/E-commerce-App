import 'package:ecommerce_app/responsive.dart';
import 'package:ecommerce_app/screens/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ecommerce_app/constants.dart';

class CustomAppBar extends StatefulWidget {
  final VoidCallback onAvatarTap;

  const CustomAppBar({super.key, required this.onAvatarTap});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool loading = false;
  String _location = 'Tap to get location';

  Future<void> _getLocation() async {
    setState(() {
      loading = true;
    });

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _location = 'Location services are disabled.';
          loading = false;
        });
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          setState(() {
            _location = 'Location permissions are denied.';
            loading = false;
          });
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      // Reverse geocoding
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark placemark = placemarks[0];

      // Update location state with formatted address
      setState(() {
        _location = '${placemark.locality}, ${placemark.country}';
        loading = false;
      });
    } catch (e) {
      // Handle errors
      setState(() {
        _location = 'Try connect internet';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = Responsive.isMobile(context) ? 20 : Responsive.isTablet(context) ? 24 : 28;
    double fontSize = Responsive.isMobile(context) ? 16 : Responsive.isTablet(context) ? 18 : 20;
    double avatarRadius = Responsive.isMobile(context) ? 25 : Responsive.isTablet(context) ? 30 : 35;
    double paddingSize = Responsive.isMobile(context) ? 10 : 20;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: kcontentColor,
                  padding: EdgeInsets.all(Responsive.isMobile(context) ? 12 : 15),
                ),
                onPressed: () {
                  BottomNavBar.of(context)?.updateIndex(0);
                },
                icon: Image.asset(
                  "images/icon.png",
                  color: Colors.black54,
                  height: iconSize,
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.black54,
                    size: iconSize,
                  ),
                  const SizedBox(width: 2.5),
                  GestureDetector(
                    onTap: _getLocation,
                    child: loading
                        ? SizedBox(
                            width: iconSize,
                            height: iconSize,
                            child: const CircularProgressIndicator(color: Colors.grey),
                          )
                        : Text(
                            _location,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: Colors.black54,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: widget.onAvatarTap,
            child: CircleAvatar(
              backgroundColor: const Color(0xffF5F5F5),
              radius: avatarRadius,
              backgroundImage: const AssetImage("images/profile2.jpg"),
            ),
          ),
        ],
      ),
    );
  }
}
