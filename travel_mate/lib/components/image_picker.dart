import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? image;

class ProfileImagePicker extends StatefulWidget {
  const ProfileImagePicker({super.key});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  @override
  Widget build(BuildContext context) {
    return image == null
        ?  Stack(
          children: [
           const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black12,
                backgroundImage: AssetImage('asset/image/young-man-avatar-character_24877-9475.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70,left: 65),
                child: InkWell(
                  onTap: (){
                    addImage();
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.add),
                  ),
                ),
              )
          ],
        )
        : CircleAvatar(
          radius: 50,
          backgroundImage: FileImage(image!),
          child: Padding(
            padding: const EdgeInsets.only(top: 70,left: 65),
            child: InkWell(
              onTap: (){
                addImage();
              },
              child: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black,
                child: Icon(Icons.edit_outlined),
              ),
            ),
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
                    source: ImageSource.camera,
                  );
                  if (pickedImage == null) {
                    return;
                  }
                  final imageFile = File(pickedImage.path);
                  setState(() {
                    image = imageFile;
                  });
                },
                child: const Text('Take Photo'),
              ),
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
                    image = imageFile;
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
