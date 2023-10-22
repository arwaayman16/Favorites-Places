import 'package:fav_place/data/models/place.dart';
import 'package:flutter/material.dart';

class PlaceListTile extends StatelessWidget {
  const PlaceListTile (  {super.key, required this.place} );
  final Place place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text(
        place.location,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      leading: CircleAvatar(backgroundImage:place.image!=null? FileImage(place.image!):null),
      title: Text(
        place.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
