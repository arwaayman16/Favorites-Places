import 'package:bloc/bloc.dart';
import 'package:fav_place/data/models/place.dart';
import 'package:fav_place/data/place_remot_ds.dart';
import 'package:meta/meta.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRemotDS placeRemotDS;

  PlaceBloc(this.placeRemotDS) : super(PlaceInitial()) {
    
    on<PlaceEvent>((event, emit) async {
    
      if (event is AddPlaceEvent) {
        emit(PlaceLoadingState());
        placeRemotDS.addPlace(event.place);
        add(GetPlacesEvent());
      }
      if (event is GetPlacesEvent) {
        emit(PlaceLoadingState());
        List<Place> places = await placeRemotDS.getAllPlaces();
        emit(PlaceloadedState(places: places));
      }
         if (event is DeletPlaceEvent) {
        emit(PlaceLoadingState());
      await placeRemotDS.deletePlace(event.id);
        add(GetPlacesEvent());
      }
    });
  }
}
