import 'dart:io';

import 'package:fav_place/data/models/place.dart';
import 'package:fav_place/data/place_local_ds/place_local_ds.dart';
import 'package:fav_place/presntation/pages/places_page.dart';
import 'package:fav_place/presntation/widgets/add_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key, required this.file});
  final File? file;
  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  TextEditingController title = TextEditingController();

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
        body: SizedBox(
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
                    context: context, builder: (context) => AddPhoto());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 250,
                  child: Text(
                    widget.file == null ? "Add photo" : "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(128, 158, 158, 158),
                      image: widget.file != null
                          ? DecorationImage(
                              image: FileImage(widget.file!),
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
                  SizedBox(width: 40,),
                   Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        Text(
                          "Get current location",
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(172, 255, 255, 255)),
                        ),
                      ],
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
                        Text(
                          "select from map",
                          style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(172, 255, 255, 255)),
                        ),
                      ],
                    ),
                 
                ]),
            SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    await PlaceLocalDSIml().addPlace(
                      Place(
                          title: title.text,
                          location: "location",
                          image: widget.file!),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlacesPage(),
                        ));
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ]),
        ));
  }
}
