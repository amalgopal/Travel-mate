import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


File? coverPic;

// ignore: camel_case_types
class addTripCoverPicContainer extends StatefulWidget {
  const addTripCoverPicContainer({super.key});

  @override
  State<addTripCoverPicContainer> createState() =>
      _addTripCoverPicContainerState();
}

// ignore: camel_case_types
class _addTripCoverPicContainerState extends State<addTripCoverPicContainer> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return coverPic == null
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(6)),
            height: screenSize.height * 0.23,
            width: screenSize.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    addImage();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 217, 217, 217),
                    child: Icon(
                      Icons.upload,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                const Text('Select cover picture'),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(coverPic!), fit: BoxFit.cover),
                // border: Border.all(width: 1, color: primaryColor),
                borderRadius: BorderRadius.circular(6)),
            height: screenSize.height * 0.23,
            width: screenSize.width * 0.9,
            child: GestureDetector(
              onTap: () {
                addImage();
              },
            ),
          );
  }

  addImage() async {
    final imagePicker = ImagePicker();
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final pickedImage = await imagePicker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedImage == null) {
                    return;
                  }
                  final imageFile = File(pickedImage.path);
                  setState(() {
                    coverPic = imageFile;
                  });
                },
                child: const Text('Choose Photo'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          );
        });
  }
}
