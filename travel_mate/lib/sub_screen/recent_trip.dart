// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/custom_widge/bottom_navigation.dart';
import 'package:travel_mate/custom_widge/ongoing_container.dart';

import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/trip_model.dart';
import 'package:travel_mate/model/user_model.dart';

import 'package:travel_mate/sub_screen/detail_tab.dart';
import 'package:travel_mate/sub_screen/expense_tab.dart';
import 'package:travel_mate/sub_screen/media_tab.dart';


class RecentTripScreen extends StatelessWidget {
  UserModel user;
  TripModal trip;
  RecentTripScreen({super.key, required this.user, required this.trip});

  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: primaryColor,
            ),
          ),
          title: Text(
            trip.tripName,
            style: TextStyle(color: primaryColor),
          ),
          actions: [
            IconButton(onPressed: (){ 
              _deleteDialog(context);
                   Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute( 
                    builder: (context) =>
                        (BotteomBar(userdata: user)),
                  ),
                  (route) => false,);}, icon: Container(
                height:screensize.height * 0.1,
                width: screensize.width * 0.1,
                child: Icon(Icons.delete,color: Colors.red,)))
            // Builder(
            //   builder: (context) => PopupMenuButton(
            //     color: backgroundColor,
            //     icon: Icon(
            //       Icons.more_vert,
            //       color: primaryColor,
            //     ),
            //     itemBuilder: (context) => [
            //       PopupMenuItem(
            //         child: Text('Edit'),
            //         onTap: () async {
            //           getRecentTrip(user.id!);
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => ScreenAddTrip(
            //                       user: user,
            //                       tripData: trip,
            //                     )),
            //           );
            //         },
            //       ),
            //       PopupMenuItem(
            //         child: Text(
            //           'Delete',
            //           style: TextStyle(color: Colors.red),
            //         ),
            //         onTap: () async {
            //           _deleteDialog(context);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              OngoingContainer(
                coverPic: trip.coverPic,
                destination: trip.destination,
                startingDate: trip.startingDate,
              ),
              const TabBar(
                  indicatorColor: primaryColor,
                  padding: EdgeInsets.only(top: 10),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: primaryColor,
                  tabs: [
                    Tab(
                      text: 'Details',
                    ),
                    Tab(
                      text: 'Media',
                    ),
                    Tab(
                      text: 'Expenses',
                    ),
                  ]),
              Expanded(
                child: TabBarView(children: [
                  DetailTab(
                    user: user,
                    trip: trip,
                  ),
                  MediaTab(trip: trip,),
                  ExpenseTab(trip: trip)
                 // ExpenseTab(trip: trip)
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteDialog(BuildContext context) async {
    getRecentTrip(user.id!);
    showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Column(
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
            child: Text("Cancel"),
          ),
          CupertinoButton(
            onPressed: () async {
              await deleteTrip(trip.id!);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => (BotteomBar(userdata: user)),
                ),
                (route) => false,
              );
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
