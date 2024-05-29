import 'dart:convert';

import 'package:favorite_places_app/models/place_location.dart';
import 'package:flutter/material.dart';
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
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$log&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$log&key=AIzaSyBpMdZp8DBlkULbKX50q4Cub4Pf45dgWJA';
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
//ref:https://developers.google.com/maps/documentation/geocoding/requests-reverse-geocoding
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.longitude}&key=AIzaSyBpMdZp8DBlkULbKX50q4Cub4Pf45dgWJA');

    var response = await http.get(url);
    var geocoding = json.decode(response.body);
    final address = geocoding['results'][0]['formatted_address'];

    setState(() {
      isGettingLocation = false;
      _selectedLocation = PlaceLocation(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
          address: address);
    });
    widget.onSelectedLocation(_selectedLocation!);
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
              onPressed: () {},
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
