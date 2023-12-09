import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/user_model.dart';

File? image ;

class EditeImagePicker extends StatefulWidget {
  final UserModel user;
  const EditeImagePicker({super.key, required this.user});

  @override
  State<EditeImagePicker> createState() => _EditeImagePickerState();
}

class _EditeImagePickerState extends State<EditeImagePicker> {
  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
          radius: 50,
          backgroundImage: FileImage(File(image != null ? image!.path : widget.user.image!)),
          child: Padding(
            padding: const EdgeInsets.only(top: 70,left: 65),
            child: InkWell(
              onTap: ()async{
               await addImage();
                
                if(image !=null){
                  await updateUserinfo('image',image!.path, widget.user.id!);
                }
               
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
   await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext cont) {
          return  CupertinoActionSheet(
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
        print("picked image");
  }
}
