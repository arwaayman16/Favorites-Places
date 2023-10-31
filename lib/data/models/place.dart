import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Place {
  final String title, id, userId;
  final String location;
  final String? image;
  final double latitude, longitude;

  Place(
      {required this.latitude,
      required this.longitude,
      required this.id,
      required this.userId,
      required this.image,
      required this.title,
      required this.location});
  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "location": location,
      "image": image,
      "id": id,
      "userId": userId,
      "longitude": longitude,
      "latitude": latitude,
    };
  }

  factory Place.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return Place(
      id: doc.id,
      title: doc.data()["title"]!,
      location: doc.data()["location"],
      image: doc.data()['image'],
      // id: doc.data()["id"],
      userId: doc.data()["userId"], latitude: doc.data()["latitude"],
      longitude: doc.data()["longitude"],
    );
  }
}
