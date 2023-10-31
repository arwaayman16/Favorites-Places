import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fav_place/data/models/place.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class PlaceRemotDS {
  Future<void> addPlace(Place place);
  Future<List<Place>> getAllPlaces();
  Future<void> deletePlace(String placeId);
  Future<void> updatePlace(Place place);
}

class PlaceRemotDSImpl implements PlaceRemotDS {
  @override
  Future<void> addPlace(Place place) async {
    await FirebaseFirestore.instance.collection("places").add(place.toMap());
  }

  @override
  Future<void> deletePlace(String placeId) async {
    await FirebaseFirestore.instance.collection("places").doc(placeId).delete();
  //  await FirebaseFirestore.instance.collection("places").doc().delete();
  }

  @override
  Future<List<Place>> getAllPlaces() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("places").get();
    return snapshot.docs.map((e) => Place.fromDoc(e)).toList();
  }

  @override
  Future<void> updatePlace(Place place) async {
    await FirebaseFirestore.instance
        .collection("places")
        .doc(place.id)
        .update(place.toMap());
  }
}
