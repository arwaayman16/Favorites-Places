import 'dart:io';

import 'package:fav_place/presntation/pages/add_place.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                file = await getImage(ImageSource.gallery);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPlace(file: file),
                    ));
                setState(() {});
              },
              child: Row(
                children: [
                  Icon(
                    Icons.photo,
                    color: Colors.red,
                  ),
                  Text(
                    "pick frome gallary",
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(172, 255, 255, 255)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async {
                file = await getImage(ImageSource.camera);
                setState(() {
                  file =  File(file!.path);
                });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPlace(file: file),
                    ));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.red,
                  ),
                  Text(
                    "Take photo ",
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(172, 255, 255, 255)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<File?> getImage(ImageSource imageSource) async {
  XFile? xFile = await ImagePicker().pickImage(source: imageSource);
  if (xFile != null) {
    return File(xFile.path);
  }
  return null;
}
