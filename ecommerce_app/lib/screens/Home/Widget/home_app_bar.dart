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
  String _location = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _location = 'Location services are disabled.';
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
      });
    } catch (e) {
      // Handle errors
      setState(() {
        _location = 'Failed to get location';
        // _location = 'Failed to get location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: kcontentColor,
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                // Add drawer or other functionality here if needed
              },
              icon: Image.asset(
                "images/icon.png",
                color: Colors.black54,
                height: 20,
              ),
            ),
            const SizedBox(width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black54,
                ),
                const SizedBox(width: 2.5),
                Text(
                  _location,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 5),
            InkWell(
              onTap: widget.onAvatarTap,
              child: const CircleAvatar(
                backgroundColor: Color(0xffF5F5F5),
                radius: 25,
                backgroundImage: AssetImage("images/profile2.jpg"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
