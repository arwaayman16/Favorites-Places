import 'package:fav_place/data/models/place.dart';
import 'package:fav_place/presntation/bloc/place_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceInfo extends StatelessWidget {
  const PlaceInfo({super.key, required this.place});
  final Place place;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(place.title),
        actions: [
          GestureDetector(
              onTap: () async {
                context.read<PlaceBloc>().add(DeletPlaceEvent(id: place.id));
                Navigator.pop(context);
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              )),
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(128, 158, 158, 158),
              image: DecorationImage(
                  image: NetworkImage(place.image!), fit: BoxFit.cover))),
    );
  }
}
