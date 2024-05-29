import 'dart:io';

import 'package:favorite_places_app/models/place_location.dart';
import 'package:favorite_places_app/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super([]);

  void addPlace(String title, File image, PlaceLocation placeLocation) {
    state = [
      ...state,
      Places(title: title, image: image, placeLocation: placeLocation)
    ];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
        (ref) => UserPlacesNotifier());
