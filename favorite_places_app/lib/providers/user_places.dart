import 'package:favorite_places_app/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super([]);

  void addPlace(String title) {
    state = [...state, Places(title: title)];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
        (ref) => UserPlacesNotifier());
