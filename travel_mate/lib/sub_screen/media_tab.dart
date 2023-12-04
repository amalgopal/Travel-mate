import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/media_model.dart';
import 'package:travel_mate/model/trip_model.dart';

class MediaTab extends StatefulWidget {
  final TripModal trip;
  

  const MediaTab({Key? key, required this.trip}) : super(key: key);

  @override
  State<MediaTab> createState() => _MediaTabState();
}

class _MediaTabState extends State<MediaTab> {
   File? mediaImage=File(''); // Use late to indicate that it will be initialized before usage

  @override
  Widget build(BuildContext context) {
    return  ListView(
          
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text(
                'Pictures',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: InkWell(
                onTap: () {
                  addMedia();
                },
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  color: primaryColor,
                  size: 22,
                ),
              ),
            ),
            FutureBuilder(
              future: getmediapics(widget.trip.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); 
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                 
                  List<Map<String, dynamic>> data = snapshot.data as List<Map<String, dynamic>>;
                   print("length :- ${data.length}");
                   print('data:-$data');
                  return GridView.builder(shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                     // childAspectRatio: 0.68,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      String imagePath = data[index]['mediaPic'];
                      print("imagepath:- $imagePath");
                      return CircleAvatar(
                        radius: 20,
                        backgroundImage: FileImage(File(imagePath)),
                        child: IconButton(onPressed: (){
                          deletemedia(widget.trip.id);
                        }, icon:Icon(Icons.delete)),
                      );
                    },
                  );
                } else {
                  return Container(
                    height: 100, // Set a fixed height for the placeholder
                    alignment: Alignment.center,
                    child: Text('No data'),
                  );
                }
              },
            ),
          ],
        
      
    );
  }

  Future<void> addMedia() async {
    await addImage();
    if (mediaImage != null) {
      MediaModel obj = MediaModel(userId: widget.trip.userID!, tripId: widget.trip.id!, mediaImage: mediaImage!.path);
      final mediaId = await addMediapics(obj);
      obj.id = mediaId;
      // Optionally, you can setState to trigger a rebuild after adding the media
      // setState(() {});
    }
  }

  Future<void> addImage() async {
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
                if (pickedImage != null) {
                  setState(() {
                    mediaImage = File(pickedImage.path);
                  });
                }
              },
              child: Text('Take Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                final pickedImage = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedImage != null) {
                  setState(() {
                    mediaImage = File(pickedImage.path);
                    print("selected:- $mediaImage");
                  });
                }
              },
              child: Text('Choose Photo'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: TextStyle(color: Colors.red)),
          ),
        );
      },
    );
  }
}
