part of 'place_bloc.dart';

@immutable
sealed class PlaceState {}

final class PlaceInitial extends PlaceState {}

final class PlaceLoadingState extends PlaceState {}

final class PlaceloadedState extends PlaceState {
 final List<Place> places;

  PlaceloadedState({required this.places});
}

final class PlaceErrorState extends PlaceState {}
