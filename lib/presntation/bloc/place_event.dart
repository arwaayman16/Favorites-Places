part of 'place_bloc.dart';

@immutable
sealed class PlaceEvent {}

class AddPlaceEvent extends PlaceEvent {
  final Place place;

  AddPlaceEvent({required this.place});
}

class GetPlacesEvent extends PlaceEvent {}

class DeletPlaceEvent extends PlaceEvent {
 final String id;

  DeletPlaceEvent({required this.id});
}

class UpdatePlaceEvent extends PlaceEvent {}
