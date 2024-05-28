import 'dart:io';

import 'package:favorite_places_app/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super([]);

  void addPlace(String title, File image) {
    state = [...state, Places(title: title, image: image)];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
        (ref) => UserPlacesNotifier());
