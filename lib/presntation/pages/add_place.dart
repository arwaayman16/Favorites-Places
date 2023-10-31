import 'dart:io';

import 'package:fav_place/core/storage_helper.dart';
import 'package:fav_place/data/models/place.dart';
import 'package:fav_place/data/models/place_local_ds/place_local_ds.dart';
import 'package:fav_place/presntation/bloc/place_bloc.dart';
import 'package:fav_place/presntation/pages/curent_location.dart';
import 'package:fav_place/presntation/pages/google_map.dart';
import 'package:fav_place/presntation/pages/places_page.dart';
import 'package:fav_place/presntation/widgets/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({
    super.key,
  });

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  TextEditingController title = TextEditingController();
  File? file;
  String? country, city, road;
  Position? p;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            "Add Places",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: BlocConsumer<PlaceBloc, PlaceState>(
          listener: (context, state) {
            if (state is PlaceloadedState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlacesPage(),
                  ));
            }
          },
          builder: (context, state) {
            return SizedBox(
              child: ListView(children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: title,
                      style: TextStyle(
                          color: const Color.fromARGB(176, 255, 255, 255)),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hoverColor: Colors.white,
                          labelText: "Title",
                          labelStyle: TextStyle(
                              fontSize: 20,
                              color: const Color.fromARGB(170, 244, 67, 54))),
                    )),

                GestureDetector(
                  onTap: () async {
                    await showDialog(
                            context: context, builder: (context) => AddPhoto())
                        .then((value) => file = value);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 250,
                      child: Text(
                        file == null ? "Add photo" : "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(128, 158, 158, 158),
                          image: file != null
                              ? DecorationImage(
                                  image: FileImage(file!),
                                  fit: BoxFit.cover,
                                )
                              : null),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset("assets/images/map.png"),
                ),
                //  Spacer(),
                Row(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PickLocation(),
                              ));
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            GestureDetector(
                              onTap: () async {
                                p = await getCurrentLocation();
                                setState(() {});
                              },
                              child: Text(
                                "Get current location",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                        172, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.map,
                            color: Colors.red,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => GooglrMpas(),
                              ))
                                  .then((value) {
                                city = value["city"];
                                country = value["country"];
                                road = value["road"];
                              });
                              setState(() {
                                
                              });
                            },
                            child: Text(
                              "select from map",
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      const Color.fromARGB(172, 255, 255, 255)),
                            ),
                          ),
                        ],
                      ),
                    ]),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        context.read<PlaceBloc>().add(AddPlaceEvent(
                            place: Place(
                                latitude: 5,
                                longitude: 5,
                                id: "id",
                                userId: "userId",
                                image: await StorageHelperImpl()
                                    .uploadImageFromFile(file!),
                                title: title.text,
                                location:
                                    "${country}-${city}-${road}")));
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ]),
            );
          },
        ));
  }
}

Future<Position?> getCurrentLocation() async {
  await Geolocator.requestPermission();

  final state = await Geolocator.checkPermission();
  if (state == LocationPermission.always ||
      state == LocationPermission.whileInUse) {
    return Geolocator.getCurrentPosition();
  }
  return null;
}
