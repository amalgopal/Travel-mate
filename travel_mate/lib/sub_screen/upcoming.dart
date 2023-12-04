// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/custom_widge/bottom_navigation.dart';

import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/trip_model.dart';
import 'package:travel_mate/model/user_model.dart';
import 'package:travel_mate/screen/add_trip.dart';
import 'package:travel_mate/sub_screen/detail_tab.dart';


class UpcomingTripScreen extends StatefulWidget {
  UserModel user;
  TripModal trip;
  UpcomingTripScreen({super.key, required this.user, required this.trip});

  @override
  State<UpcomingTripScreen> createState() => _UpcomingTripScreenState();
}

class _UpcomingTripScreenState extends State<UpcomingTripScreen> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: const Icon(
            Icons.arrow_back,
            color: primaryColor,
          ),),
        title: Text(
          widget.trip.tripName,
          style: const TextStyle(color: primaryColor),
        ),
        actions: [
          InkWell(onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenAddTrip(
                          user: widget.user,
                          tripData: widget.trip,
                        ),
                      ),
                    );
          },
            child: Icon(Icons.edit,color: Colors.black,)),

          IconButton(onPressed: (){
               ScreenAddTrip(user:widget. user,tripData:widget. trip,);
            }, icon: const Icon(Icons.edit,color: Colors.black,)),
            IconButton(onPressed: (){
               _deleteDialog(context);
            }, 
            icon: const Icon(Icons.delete,color: Colors.red,))

          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DetailTab(user: widget.user, trip: widget.trip),
      ),
    );
  }

  Future<void> _deleteDialog(BuildContext context) async {
   // getOnGoingTrip(widget.user.id!);
    showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Column(
          children: [
            Text("Delete your trip?"),
            Text(
              "Any drafts that you've saved will be deleted on this device",
              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.normal),
            )
          ],
        ),
        actions: [
          CupertinoButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          CupertinoButton(
            onPressed: () async {
              await deleteTrip(widget.trip.id!);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => (BotteomBar(userdata: widget.user)),
                ),
                (route) => false,
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  
   editTripdetails() async {
    print('in function');
    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenAddTrip(
                          user: widget.user,
                          tripData: widget.trip,
                        ),
                      ),
                    );
  }
}
