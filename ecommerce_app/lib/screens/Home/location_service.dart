import 'package:ecommerce_app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  String _location = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _location = 'Location services are disabled.';
        });
        return;
      }

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

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark placemark =
          placemarks.isNotEmpty ? placemarks[0] : const Placemark();

      setState(() {
        _location =
            '${placemark.locality ?? 'Unknown location'}, ${placemark.country ?? 'Unknown country'}';
      });
    } catch (e) {
      setState(() {
        _location = 'Failed to get location: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = Responsive.isDesktop(context) ? 18.0 : 14.0;
    double iconSize = Responsive.isDesktop(context) ? 28.0 : 24.0;
    Color textColor = Responsive.isTablet(context) ? Colors.blueGrey : Colors.black54;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.location_on_outlined,
          color: textColor,
          size: iconSize,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            _location,
            style: TextStyle(
              fontSize: fontSize,
              color: textColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
