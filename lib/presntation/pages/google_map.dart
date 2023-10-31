import 'package:fav_place/presntation/pages/add_place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GooglrMpas extends StatefulWidget {
  const GooglrMpas({super.key});

  @override
  State<GooglrMpas> createState() => _GooglrMpasState();
}

class _GooglrMpasState extends State<GooglrMpas> {
  late String country, city, road;
  List<Placemark>? placemarks;
  Set<Marker> marker = {
    Marker(
        infoWindow: InfoWindow(title: "bbb"),
        markerId: MarkerId(""),
        position: LatLng(30.1, 30.1))
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: marker,
            onTap: (argument) async {
              marker.clear();
              marker.add(Marker(
                markerId: MarkerId("value"),
                position: argument,
              ));
              setState(() {});
              placemarks = await placemarkFromCoordinates(
                  argument.latitude, argument.longitude);
              // print(placemarks);
              country = placemarks![0].country!;
              road = placemarks![0].street!;
              city = placemarks![0].administrativeArea!;
                   print(country);
                    print(road);
                    print(city);
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(30.1, 30.1),
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    country;
                    road;
                    city;
               
                  });
                   Navigator.pop(context,{ 
                     "city": city,
                     "country": country,
                      "road": road,});
                  setState(() {});
                },
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ))
        ],
      ),
    );
  }
}
