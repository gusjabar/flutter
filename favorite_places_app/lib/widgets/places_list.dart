import 'package:favorite_places_app/models/places.dart';
import 'package:favorite_places_app/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Places> places;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(places[index].image),
        ),
        title: Text(
          places[index].title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlaceDetailsScreen(place: places[index]),
            ),
          );
        },
      ),
    );

    if (places.isEmpty) {
      content = Center(
        child: Text(
          'Not placess added yet!',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }
    return content;
  }
}
