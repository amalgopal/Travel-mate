import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_mate/add_trip/choice_chip.dart';
import 'package:travel_mate/add_trip/companion.dart';
import 'package:travel_mate/add_trip/date_picker.dart';
import 'package:travel_mate/add_trip/add_trip_cover_pic.dart';
import 'package:travel_mate/add_trip/drop_down.dart';


import 'package:travel_mate/components/button.dart';
import 'package:travel_mate/components/app_color.dart';
import 'package:travel_mate/custom_widge/bottom_navigation.dart';

import 'package:travel_mate/db/functions/db_function.dart';
import 'package:travel_mate/model/trip_model.dart';
import 'package:travel_mate/model/user_model.dart';


String? selectedTransport;
String? selectedTravelPurpose;
class ScreenAddTrip extends StatefulWidget {
    final UserModel user;
  final TripModal? tripData;
  const ScreenAddTrip({super.key,  this.tripData, required this.user});

  @override
  State<ScreenAddTrip> createState() => _ScreenAddTripState();
}

class _ScreenAddTripState extends State<ScreenAddTrip> {
  
   final formKey = GlobalKey<FormState>();
  final tripNameController = TextEditingController();
  final destinationController = TextEditingController();
  final budgetController = TextEditingController();
  final startingDateController = TextEditingController();
 final endingDateController = TextEditingController();
  void initState() {
    super.initState();
    if (widget.tripData != null) {
      final tripData = widget.tripData!;
      tripNameController.text = tripData.tripName;
      destinationController.text = tripData.destination;
      budgetController.text = tripData.budget;
      startingDateController.text = tripData.startingDate;
      endingDateController.text = tripData.endingDate;
      coverPic = File(tripData.coverPic!);

      selectedTransport = widget.tripData!.transport;
      selectedTravelPurpose = widget.tripData!.travelPurpose;

      companionList = tripData.companions.map((companion) {
        return {
          "name": companion.name,
          "number": companion.number,
        };
      }).toList();
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Trip'),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20,5,20,20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const addTripCoverPicContainer(),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                    
                    TextFormField(
                   controller: tripNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter trip name',
                      ),
                      validator:  (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[A-Z][a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Name must start with a capital letter and be at least 3 characters long';
                    } else {
                      return null;
                    }
                  },
                    ),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                     TextFormField(
                      controller: destinationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter trip destination'
                      ),
                      validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[A-Z][a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Destination must start with a capital letter and be at least 3 characters long';
                    } else {
                      return null;
                    }
                  },
                      
                    ),
                    SizedBox(
                      height:  screensize.height * 0.018,
                    ),
                   TextFormField(
                    controller: budgetController,
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'Enter trip budget'

                     ),
                     validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Budget is required';
                    } else if (double.parse(value) <= 0) {
                      return 'Budget must be a positive number';
                    }
                    return null;
                  },
                     
                   ),
                   SizedBox(
                    height: screensize.height * 0.018,
                   ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                        Container(
                          width: screensize.width * 0.43,
                          child:MyDatePicker(
                            dateCheck: true,
                            startController: startingDateController,
                            startOrend: 'Starting date')
                        ),
                        Container(
                          width: screensize.width *0.43,
                          child: MyDatePicker(
                           // dateCheck: true,
                            endController: endingDateController,
                            startOrend: 'Ending date'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                    const Text('Choose preferred transport',style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                    MyChoiceChip(),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                    const Text('Select travel purpose',style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                     MyDropdownMenu(items:const ['business','Entertainment','Family','other'], 
                     initialValue: 'business'),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         MyCompanion(
                      context: context,
                      functionCheck: true,
                      text: '  Select companions',
                    ),
                    MyCompanion(
                      text: '  Show companions',
                      context: context,
                    )
                      ],
                      
                    ),
                    SizedBox(
                      height: screensize.height * 0.018,
                    ),
                    MyButton(
                    backgroundColor: primaryColor,
                   text:  'Add' ,
                    textColor: backgroundColor,
                    onTap: () {
                      onButtonClicked();
              
                    }
                    )
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  showDatapicker({required BuildContext context, required initialdate}) {}
  addtrip(){

  }
   onButtonClicked() async {
    if (formKey.currentState!.validate()) {
      if (coverPic == null) {
        // Show an error message if the image is not selected.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please add image before finishig the form.'),
            behavior: SnackBarBehavior.floating,
            // margin: EdgeInsets.all(20),
          ),
        );
        return;
      }
      final tripName = tripNameController.text.trim();
      final destination = destinationController.text.trim();
      final budget = budgetController.text.trim();
      final startingDate = startingDateController.text.trim();
      final endingDate = endingDateController.text.trim();
      final userID = widget.user.id;

      final trip = TripModal(
        tripName: tripName,
        destination: destination,
        budget: budget,
        startingDate: startingDate,
        endingDate: endingDate,
        transport: selectedTransport!,
        travelPurpose: selectedTravelPurpose!,
        coverPic: coverPic!.path,
        userID: userID,
        id: widget.tripData?.id,
      );
      print('Trip Details');
      print('data is $trip');

      if (widget.tripData != null) {
        await updateTrip(trip);
      } else {
        await addTrip(trip, companionList);
      }

      coverPic = null;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => (BotteomBar(userdata: widget.user)),
        ),
        (route) => false,
      );
    }
  }
}