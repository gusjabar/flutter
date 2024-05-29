import 'dart:io';

import 'package:favorite_places_app/models/place_location.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Places {
  final String id;
  final String title;
  final File image;
  final PlaceLocation placeLocation;

  Places(
      {required this.title, required this.image, required this.placeLocation})
      : id = uuid.v4();
}
