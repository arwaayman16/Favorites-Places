import 'package:fav_place/data/models/place.dart';
import 'package:fav_place/data/place_remot_ds.dart';
import 'package:fav_place/presntation/bloc/place_bloc.dart';
import 'package:fav_place/presntation/pages/place_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceListTile extends StatelessWidget {
  const PlaceListTile({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceInfo(
                place: place,
              ),
            ));
      },
      child: ListTile(
     
        subtitle: Text(
          place.location,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: CircleAvatar(
            radius: 35, backgroundImage: NetworkImage(place.image!)),
        title: Text(
          place.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
