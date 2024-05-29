import 'dart:convert';

import 'package:favorite_places_app/models/place_location.dart';
import 'package:favorite_places_app/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectedLocation});
  final void Function(PlaceLocation location) onSelectedLocation;

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _selectedLocation;
  bool isGettingLocation = false;

  String get locationImage {
    if (_selectedLocation == null) {
      return '';
    }
    final lat = _selectedLocation!.latitude;
    final log = _selectedLocation!.longitude;
//ref:https://developers.google.com/maps/documentation/maps-static/overview
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$log&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:P%7C$lat,$log&key=AIzaSyBpMdZp8DBlkULbKX50q4Cub4Pf45dgWJA';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
//ref:https://developers.google.com/maps/documentation/geocoding/requests-reverse-geocoding
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyBpMdZp8DBlkULbKX50q4Cub4Pf45dgWJA');

    var response = await http.get(url);
    var geocoding = json.decode(response.body);
    final address = geocoding['results'][0]['formatted_address'];

    setState(() {
      isGettingLocation = false;
      _selectedLocation = PlaceLocation(
          latitude: latitude, longitude: longitude, address: address);
    });
    widget.onSelectedLocation(_selectedLocation!);
  }

  void _getCurrentLocatin() async {
    Location location = new Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });
    locationData = await location.getLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      setState(() {
        isGettingLocation = false;
        return;
      });
    }
    _savePlace(locationData.latitude!, locationData.longitude!);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewLocation = Text(
      'Location Not Selected yet!',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );

    if (_selectedLocation != null) {
      previewLocation = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (isGettingLocation) {
      previewLocation = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewLocation,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentLocatin,
              label: const Text('Get Current Location'),
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              onPressed: _selectOnMap,
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
