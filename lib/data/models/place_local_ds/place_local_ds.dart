import 'dart:convert';

import 'package:fav_place/data/models/place.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PlaceLocalDS {
  ///takes a [place] as parametr and save it to [shared prefrence]
  ///
  ///throws [exeption] if operation failed
  Future<void> addPlace(Place p);

  ///gets [list] of [places]from [sharedprefrences]
  ///
  ///throws [exeption] operation failed
  Future<List<Place>> getPlace();
}

final String placesKey = 'placeList';

class PlaceLocalDSIml implements PlaceLocalDS {
  @override
  Future<List<Place>> getPlace() async {
    List<Place> places = [];

    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> placesJson = prefs.getStringList(placesKey) ?? [];
      print(placesJson);
      for (int i = 0; i < placesJson.length; i++) {
        final placeJson = placesJson[i];
        final Map placeMap = jsonDecode(placeJson);
      //  final Place place = Place.fromDoc(placeMap);
      //  places.add(place);
      }
    } catch (e) {
      print(e);
    }

    return places;
  }

  @override
  Future<void> addPlace(Place p) async {
    final prefs = await SharedPreferences.getInstance();
    final String placeJson = jsonEncode(p.toMap());
    List<String> placesJson = prefs.getStringList(placesKey) ?? [];
    placesJson.add(placeJson);
    await prefs.setStringList(placesKey, placesJson);
  }
}
