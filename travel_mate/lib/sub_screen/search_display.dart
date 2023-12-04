// // ignore_for_file: must_be_immutable
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:travel_mate/components/app_color.dart';
// import 'package:travel_mate/custom_widge/bottom_navigation.dart';
// import 'package:travel_mate/custom_widge/ongoing_container.dart';

// import 'package:travel_mate/db/functions/db_function.dart';
// import 'package:travel_mate/model/trip_model.dart';
// import 'package:travel_mate/model/user_model.dart';

// import 'package:travel_mate/sub_screen/detail_tab.dart';
// import 'package:travel_mate/sub_screen/expense_tab.dart';
// import 'package:travel_mate/sub_screen/media_tab.dart';


// class OngoingTripScreen extends StatelessWidget {
//   final UserModel user;
//   final TripModal trip;

//   OngoingTripScreen({Key? key, required this.user, required this.trip})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         backgroundColor: backgroundColor,
//         appBar: AppBar(
//           backgroundColor: backgroundColor,
//           elevation: 0,
//           leading: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: Icon(
//               Icons.arrow_back,
//               color: primaryColor,
//             ),
//           ),
//           title: Text(
//             trip.tripName,
//             style: TextStyle(color: primaryColor),
//           ),
//           actions: [
//             IconButton(onPressed: (){
//                _deleteDialog(context);
//             }, 
//             icon: Icon(Icons.delete,color: Colors.red,))
         
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
//           child: Column(
//             children: [
//               OngoingContainer(
//                 coverPic: trip.coverPic,
//                 destination: trip.destination,
//                 startingDate: trip.startingDate,
//               ),
//               TabBar(
//                   indicatorColor: primaryColor,
//                   padding: EdgeInsets.only(top: 10),
//                   indicatorSize: TabBarIndicatorSize.label,
//                   labelColor: primaryColor,
//                   tabs: [
//                     Tab(
//                       text: 'Details',
//                     ),
//                     Tab(
//                       text: 'Media',
//                     ),
//                     Tab(
//                       text: 'Expenses',
//                     ),
//                   ]),
//               Expanded(
//                 child: TabBarView(children: [
//                   DetailTab(
//                     user: user,
//                     trip: trip,
//                   ),
//                   MediaTab(),
//                   ExpenseTab()
//                 ]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _deleteDialog(BuildContext context) async {
//     getOnGoingTrip(user.id!);
//     showDialog(
//       context: context,
//       builder: (ctx) => CupertinoAlertDialog(
//         title: Column(
//           children: [
//             Text("Delete your trip?"),
//             Text(
//               "Any drafts that you've saved will be deleted on this device",
//               style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.normal),
//             )
//           ],
//         ),
//         actions: [
//           CupertinoButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Cancel"),
//           ),
//           CupertinoButton(
//             onPressed: () async {
//               await deleteTrip(trip.id!);
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) => (BotteomBar(userdata: user)),
//                 ),
//                 (route) => false,
//               );
//             },
//             child: Text("Delete", style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
// }
