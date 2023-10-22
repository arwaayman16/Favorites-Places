import 'dart:io';

import 'package:flutter/material.dart';

class Place {
  final String title;
  final String location;
  final File? image;

  Place({this.image, required this.title, required this.location});
  Map toMap() {
    return {"title": title, "location": location, "image": image!.path};
  }

  factory Place.fromMap(Map m) {
    return Place(
      title: m["title"],
      location: m["location"],
    image:  m['image'] != null ? File(m['image']) : null,
    );
  }
}
